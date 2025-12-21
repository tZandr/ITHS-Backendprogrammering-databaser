-- CRUD:
-- READ: Visa alla medlemmar med medlemskap
SELECT 
    m.member_id,
    m.name AS member_name,
    ms.name AS membership
FROM Member m
JOIN Membership ms ON m.membership_id = ms.membership_id;

INSERT INTO Member (name, email, membership_id)
VALUES ('Sara Lind', 'sara.lind@example.com', 2);

-- CREATE: Lägg till ny medlem
INSERT INTO Member (name, email, membership_id)
VALUES ('Sara Lind', 'sara.lind@example.com', 2);

-- UPDATE: Uppdatera medlemskap
UPDATE Member
SET membership_id = 3
WHERE member_id = 1;

-- DELETE: Ta bort medlem
DELETE FROM Member
WHERE member_id = 1;


-- Joins:
-- Visa medlemmar och deras bokade klasser
SELECT
    m.name AS member,
    c.name AS class,
    c.start_time,
    c.duration
FROM Booking b
JOIN Member m ON b.member_id = m.member_id
JOIN Class c ON b.class_id = c.class_id
ORDER BY m.name;

-- Klasser med instruktör
SELECT
    c.name AS class,
    i.name AS instructor,
    c.start_time,
    c.duration
FROM Class c
JOIN Instructor i ON c.instructor_id = i.instructor_id;


-- Statistik:
-- Antal bokningar per klass
SELECT
    c.name AS class,
    COUNT(b.booking_id) AS total_bookings
FROM Class c
LEFT JOIN Booking b ON c.class_id = b.class_id
GROUP BY c.class_id;

-- Medelpris för medlemskap
SELECT AVG(price) AS average_membership_price
FROM Membership;


-- View:
-- Medlemmar + klasser
CREATE VIEW vw_member_classes AS
SELECT
    m.name AS member,
    c.name AS class,
    c.start_time,
    c.duration
FROM Booking b
JOIN Member m ON b.member_id = m.member_id
JOIN Class c ON b.class_id = c.class_id;

SELECT * FROM vw_member_classes;


-- Referensintegritet:
-- Försök boka med ogiltigt member_id (ska misslyckas)
INSERT INTO Booking (member_id, class_id)
VALUES (999, 1);

-- Försök lägga till medlem med ogiltigt membership_id (ska misslyckas)
INSERT INTO Member (name, email, membership_id)
VALUES ('Test Test', 'mr@test.com', 99);


-- VG: 
-- Stored Procedures - Boka pass(med kapacitetskontroll)
DELIMITER $$
CREATE PROCEDURE sp_book_class (
    IN p_member_id INT,
    IN p_class_id INT
)
BEGIN
    DECLARE current_bookings INT;
    DECLARE max_capacity INT;

    START TRANSACTION;

    -- Hämta kapacitet
    SELECT capacity INTO max_capacity
    FROM Class
    WHERE class_id = p_class_id
    FOR UPDATE;

    -- Räkna befintliga bokningar
    SELECT COUNT(*) INTO current_bookings
    FROM Booking
    WHERE class_id = p_class_id;

    -- Kontrollera plats
    IF current_bookings >= max_capacity THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Klassen är full';
    ELSE
        INSERT INTO Booking (member_id, class_id, status)
        VALUES (p_member_id, p_class_id, 'booked');

        COMMIT;
    END IF;
END$$

DELIMITER ;
CALL sp_book_class(1, 1);

-- Avboka pass
DELIMITER $$

CREATE PROCEDURE sp_cancel_booking (
    IN p_booking_id INT
)
BEGIN
    DELETE FROM Booking
    WHERE booking_id = p_booking_id;
END$$

DELIMITER ;
CALL sp_cancel_booking(1);


-- Triggers - Stoppa bokning om klassen är full
DELIMITER $$

CREATE TRIGGER trg_before_booking_insert
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    DECLARE current_bookings INT;
    DECLARE max_capacity INT;

    SELECT COUNT(*) INTO current_bookings
    FROM Booking
    WHERE class_id = NEW.class_id;

    SELECT capacity INTO max_capacity
    FROM Class
    WHERE class_id = NEW.class_id;

    IF current_bookings >= max_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kan inte boka: klassen är full';
    END IF;
END$$

DELIMITER ;


-- Transaktion:
START TRANSACTION;

INSERT INTO Member (name, email, membership_id)
VALUES ('Test Medlem', 'test.medlem@example.com', 1);

INSERT INTO Booking (member_id, class_id)
VALUES (LAST_INSERT_ID(), 2);

COMMIT;
-- eller
ROLLBACK;
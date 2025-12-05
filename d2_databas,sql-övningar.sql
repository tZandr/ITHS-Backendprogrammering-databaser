-- SQL JOIN, relationer och modellering
-- Del 1 - Ett-till-många (kund-order)

    -- 1. Skapa ny databas
CREATE DATABASE butik;

    -- 2. Skapa tabellerna kund och order:
CREATE TABLE kund(
    id INT primary key AUTO_INCREMENT,
    namn VARCHAR(50),
    stad VARCHAR(50),
    epost VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kund_id INT,
    orderdatum DATE,
    totalbelopp DECIMAL(10,2),
    FOREIGN KEY (kund_id) REFERENCES kund(id)
);

    -- 3. Fyll tabellerna med data
INSERT INTO kund
VALUES (001, 'Martin', 'Örebro', 'martin@orebro.se'),
       (002, 'Alice', 'Töreboda', 'alice@toreboda.se'),
       (003, 'Oskar', 'Nyköping', 'oskar@nykoping.se');

INSERT INTO orders
VALUES (001, 002, '2023-03-31', 449.00),
       (002, 002, '2024-05-21', 599.00),
       (003, 001, '2021-02-28', 319.00),
       (004, 003, '2025-08-11', 619.00),
       (005, 001, '2023-06-02', 249.00);

    -- 4. Skriv SQL-frågor som
    -- Visar alla ordrar tillsammans med kundens namn:
SELECT orders.id AS orders_id,
       orders.orderdatum,
       orders.totalbelopp,
       kund.namn
FROM orders
JOIN kund ON orders.kund_id = kund.id;

    -- Visar alla ordrar för en viss kund(filtrera på t.ex. namn eller k.id)
SELECT orders.id AS order_id,
orders.orderdatum,
orders.totalbelopp,
kund.namn
FROM orders
JOIN kund ON orders.kund_id = kund.id
WHERE kund.id = 001;

    -- Visar alla kunder, även de som inte har några ordrar, tillsammans med de ordrar som finns
SELECT kund.id,
       kund.namn,
       kund.stad,
        kund.epost,
        orders.id,
        orders.orderdatum
FROM kund
LEFT JOIN orders ON kund.id = orders.kund_id;

    -- Som raderar en rad i tabellen order.
DELETE FROM orders
WHERE orders.id = 005;

    -- Som raderar en rad i tabellen kund
DELETE FROM kund
WHERE kund.id = 004;


-- Del 2: Många-till-många (order-produkt)
    -- 5. Skapa tabellerna produkt och order_rad
CREATE TABLE produkt(
    id INT PRIMARY KEY AUTO_INCREMENT,
    namn VARCHAR(50),
    pris DECIMAL(10,2),
    kategori VARCHAR(50)
);

CREATE TABLE order_rad (
    orders_id   INT NOT NULL,
    produkt_id INT NOT NULL,
    antal      INT NOT NULL,
    radpris    INT NOT NULL,
    PRIMARY KEY (orders_id, produkt_id),
    FOREIGN KEY (orders_id)   REFERENCES orders(id),
    FOREIGN KEY (produkt_id) REFERENCES produkt(id)
);

    -- 6. Fyll tabellerna med data:
        -- Minst 4 produkter
        -- Lägg in order rader så att någon order har flera produkter, och någon produkt ingår i flera ordrar.
INSERT INTO produkt
VALUES (01, 'Vassleprotein', 299.00, 'kosttillskott'),
       (02, 'Kaseinprotein', 319.00, 'kosttillskott'),
       (03, 'Creatine Monohydrate', 199.00, 'kosttillskott'),
       (04, 'T-Shirt', 399.00, 'kläder'),
       (05, 'Byxor', 599.00, 'kläder');

INSERT INTO order_rad
VALUES (0001, 01, 5, 5 * 299), -- 5x vassle
        (0001, 03, 5, 5 * 199), -- 5x creatine
        (0002, 01, 2, 2* 299), -- 2x vassle(finns även i order 1)
        (0002, 05, 2, 2 * 599) -- 2x byxor

    -- 7. Skriv SQL frågor som:
        -- visar alla ordrar med tillhörande produkter(orderid, kundnamn, produktnamn, antal)
SELECT
    r.order_id,
    p.namn,
    r.antal
FROM order_rad r
JOIN produkt p ON p.id = r.produkt_id

        -- som visar alla produkter som ingår i en viss order
SELECT
    r.order_id,
    p.namn,
    r.antal,
    r.radpris
FROM order_rad r
JOIN produkt p ON r.produkt_id = p.id
WHERE r.order_id = 0001;

        -- som visar alla produkter tillsammans med hur många gånger de beställts totalt. (tips: GROUP BY)
SELECT
    p.namn,
    SUM(r.antal) AS totalt_beställt
FROM order_rad r
JOIN produkt p ON r.produkt_id = p.id
GROUP BY p.id, p.namn

        -- som visar alla produkter, även de som inte förekommer i någon order_rad
SELECT
    p.id,
    p.namn,
    p.pris,
    p.kategori,
    SUM(r.antal) AS totalt_beställda
FROM produkt p
LEFT JOIN order_rad r ON p.id = produkt_id
GROUP BY p.id, p.namn;

        -- som raderar en viss produkt ur tabellen produkt.
        -- Fundera på vad som händer med kopplingarna, behöver man radera i order_rad först för att behålla referensintegriteten?
DELETE FROM produkt
WHERE produkt.id = 05; -- Ger error, svar ja. ^


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

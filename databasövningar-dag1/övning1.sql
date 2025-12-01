-- 1. Förberedelse: Skapa ny databas.
CREATE DATABASE ovningar2;
USE ovningar2;

-- 2. Tabellen "mobiltelefon".
CREATE TABLE mobiltelefon(Serienummer INT PRIMARY KEY, Modell VARCHAR(50), Tillverkare VARCHAR(50), Lagringsutrymme_GB INT, RAM_GB INT, Pris DECIMAL(10,2), Releasedatum DATE);

    -- Mata in minst 3 rader med INSERT INTO.
INSERT INTO mobiltelefon(serienummer, modell, tillverkare, lagringsutrymme_gb, ram_gb, pris, releasedatum)
VALUES
    (1001, 'Galaxy S21', 'Samsung', 128, 8, 7999.00, '2021-01-29'),
    (1002, 'iPhone 13', 'Apple', 256, 6, 9999.00, '2021-09-24'),
    (1003, 'Xperia 5 II', 'Sony', 128, 8, 6999.00, '2020-10-15');

    -- Hämta alla mobiler från tabellen.
SELECT * FROM mobiltelefon;

    -- Hämta alla mobiler sorterade på pris(dyrast först).
SELECT * FROM mobiltelefon ORDER BY Pris DESC;

    -- Hämta alla mobiler av tillverkaren "Samsung".
SELECT * FROM mobiltelefon WHERE Tillverkare = 'Samsung';

    -- Hämta alla mobiler med mer än 128GB lagring.
SELECT * FROM mobiltelefon
WHERE Lagringsutrymme_GB >= 128;

    -- Uppdatera priset på en av mobilerna.
UPDATE mobiltelefon
SET Pris = 7499.00
WHERE Serienummer = 1001;

    -- Radera en av de inlagda mobilerna.
DELETE FROM mobiltelefon
WHERE Serienummer = 1003;


-- 3. Tabellen "filmer".
CREATE TABLE filmer(ID INT PRIMARY KEY , Title VARCHAR(50), Genre VARCHAR(50), Director VARCHAR(50), Release_date DATE, Pris DECIMAL(10,2));

INSERT INTO filmer (ID, Title, Genre, Director, Release_date, Pris)
VALUES
    (1001, 'Inception', 'Action', 'Christopher Nolan', '2010-07-23', 99.00),
    (1002, 'Dragon Ball Z: Fusion Reborn', 'Anime', 'Yamauchi Shigeyasu', '1995-03-04', 69.00),
    (1003, 'Django Unchained', 'Western', 'Quentin Tarantino', '2013-01-18', 99.00);

    -- Visa alla filmer med genren "Action"
SELECT * FROM filmer WHERE Genre = 'Action';

    -- Visa alla filmer som släpåpts efter 2018, sorterat på senaste först.
SELECT * FROM filmer ORDER BY Release_date DESC;

    -- Uppdatera priset på en av filmerna.
UPDATE filmer
SET pris = 39.00
WHERE ID = 1002;

    -- Radera alla filmer av en viss regissör.
DELETE FROM filmer
WHERE Director = 'Yamauchi Shigeyasu';

    -- Visa alla filmer av en viss regissör, men visa endast kolumnerna "Titel" och "Genre".
SELECT Title, Genre FROM filmer WHERE Director = 'Quentin Tarantino';

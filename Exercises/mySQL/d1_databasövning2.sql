-- 1. Skapa en ny databas med namnet "uppgifter"
    CREATE DATABASE uppgifter;

    CREATE TABLE dator(Artikelnummer INT PRIMARY KEY, Fabrikat VARCHAR(50), Processortyp VARCHAR(50), HastighetGhz DECIMAL(10,2), RAMGb INT, HårddiskstorlekGB INT, Pris DECIMAL(10,2));

    -- Mata in minst 3 rader med INSERT INTO.
    INSERT INTO dator (Artikelnummer, Fabrikat, Processortyp, HastighetGhz, RAMGb, HårddiskstorlekGB, Pris)
    VALUES (1001, 'ASUS', 'i7', 5.1, 32, 1, 14499.00),
       (1002, 'MSI', 'i9', 5.7, 64, 4, 28999.00),
       (1003, 'Acer', 'i5', 4.7, 16, 1, 11999.00);

-- 2. Skriv en SQL-fråga som hämtar alla datorer från tabellen "dator"
    SELECT * FROM dator;

-- 3. Skriv en SQL-fråga som hämtar alla datorer från tabellen ”datorer” med sorterar på pris med den som kostar mest överst.
    SELECT * FROM dator ORDER BY Pris DESC;

-- 4. Skriv en SQL-fråga som hämtar alla datorer från tabellen ”datorer” som är av fabrikat "ASUS".
    SELECT * FROM dator WHERE Fabrikat = 'ASUS';

-- 5. Skriv en SQL-fråga som visar datorer som har större RAM än 16 (GB).
    SELECT * FROM dator WHERE RAMGb >= 16;

-- 6. Skriv en SQL-fråga som uppdaterar priset för en av de inlagda datorerna.
    UPDATE dator
    SET Pris = 27999.00
    WHERE Artikelnummer = 1002;

-- 7. Skriv en SQL-fråga som raderar en av de inlagda datorerna.
    DELETE FROM dator
    WHERE Artikelnummer = 1003


-- 8. Skapa en tabell för "skivor"
    -- Tabellen skall kunna användas av t.ex. en butik för CD, LP-skivor, så att all nödvändig information om varje skiva finns med.
    -- Skapa själv kolumner för tabellen, och välj rätt datatyp.
    -- Man skall kunna hitta information om vad skivan heter, vad den kostar, när den är utgiven etc.
    -- Du ska ha minst fem kolumner.

    CREATE TABLE skivor(id INT PRIMARY KEY, type VARCHAR(50), name VARCHAR(50), price DECIMAL(10,2), releaseDate DATE);

    INSERT INTO skivor
    VALUES (0001, 'LP', 'Metallica', 299.90, '1991-08-12'),
       (0002, 'CD', 'AbsoluteHits', 99.00, '2008-12-15'),
       (0003, 'LP', 'Currents', 299.90, '2021-03-29'),
       (0004, 'CD', 'Adele', 199.00, '2014-09-24');

-- 9. Skriv en SQL-fråga som visar alla skivor för en viss artist från tabellen ”skivor”.
    SELECT * FROM skivor;

-- 10. Skriv en SQL-fråga som visar alla skivor som har givits ut senare än 2020 från tabellen ”skivor”, sortera på senast utgiven
    SELECT * FROM skivor
    WHERE releaseDate > '2020-01-01'

-- 11. Skriv en SQL-fråga som uppdaterar en av skivorna till ett nytt pris.
    UPDATE skivor
    SET price = 249.00
    WHERE id = 0004;

-- 12. Skriv en SQL-fråga som raderar alla skivor av en viss artist.
    DELETE FROM skivor
    WHERE name = 'Adele'

-- 13. Skriv en SQL-fråga som visar alla skivor för en viss artist, visa bara kolumnerna releaseDate och namn.
    SELECT name, releaseDate FROM skivor
    WHERE name = 'Metallica'

-- 14. Skapa en tabell för "Anställda"
    -- Tabellen skall kunna användas av t.ex. Ett företag med många anställda, så att all nödvändig information om varje person finns med.
    -- Skapa själv kolumner för tabellen, och välj rätt datatyp.
    -- Man skall kunna hitta information om vad den anställde heter, vad hen har för lön, vad hen har för befattning etc.
    -- Du ska ha minst fem kolumner.
    -- Skriv SQL-kod med CREATE TABLE för att skapa tabellen. Mata in minst 2 rader i din tabell med INSERT INTO.

    CREATE TABLE employees(id INT PRIMARY KEY, type VARCHAR(50), name VARCHAR(50), city VARCHAR(50), hireDate DATE);

    INSERT INTO employees
    VALUES (0001, 'Boss', 'Magdalene', 'Stockholm', '2001-08-12'),
        (0002, 'Minion', 'Alice', 'Uppsala', '2015-11-30'),
        (0003, 'Minion', 'Jonas', 'Göteborg', '2021-05-01'),
        (0004, 'Minion', 'Burt', 'Malmö', '2025-01-30');

-- 15. Skriv en SQL-fråga som hämtar alla anställda från tabellen ”anställda”, sorterat på senast inlagd.
    SELECT * FROM employees ORDER BY hireDate DESC;

-- 16. Skriv en SQL-fråga som raderar alla anställda från tabellen ”anställda” som bor i Göteborg.
    DELETE FROM employees
    WHERE city = 'Göteborg';

-- 17. Skriv en SQL-fråga som uppdaterar någon av kolumnerna för alla anställda som är ”chefer”
    UPDATE employees
    SET type = 'SuperBoss'
    WHERE type = 'Boss';

-- 18. Lägg till en ny kolumn med ALTER i tabellen ”anställda” t ex avdelning.
    ALTER TABLE employees
    ADD Section VARCHAR(50);

-- 19. Skriv sedan en SQL-fråga som gör en UPDATE för samtliga anställda så att de tillhör samma avdelning.
    UPDATE employees
    SET Section = 'Economy'
    WHERE id >= 0

-- 20. Skriv en SQL-fråga som lägger till en ny anställd med INSERT INTO. Den nya anställda ska tillhöra en ny avdelning.
    INSERT INTO employees
    VALUE (0005, 'Boss', 'Joppe', 'Göteborg', '2023-03-03', 'SocialMedia');

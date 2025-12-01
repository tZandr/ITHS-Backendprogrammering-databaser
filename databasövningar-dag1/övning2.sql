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

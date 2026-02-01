CREATE DATABASE myArtists;
USE myArtists;

CREATE TABLE artists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    -- albums VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    debutYear INT NOT NULL,
    UNIQUE (name)
);

INSERT INTO artists VALUES
(1, 'Metallica',  'USA' ,1981),
(2, 'Landmvrks', 'France', 2014),
(3, 'Currents', 'USA',2011);

-- ALBUMS --
CREATE TABLE albums (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    releaseYear INT NOT NULL,

    FOREIGN KEY (artist_id)
                    REFERENCES artists(id)
                    ON DELETE CASCADE
)

INSERT INTO albums VALUES (
1, 1, '...And Justice for All', 1988),
(2, 1, 'Master of Puppets', 1986),
(3, 2, 'The Way It Ends', 2020),
(4, 2, 'I Let the Devil In', 2018),
(5, 3, 'Lost in the Waves', 2021),
(6, 3, 'The Darkest Place I''ve Ever Been', 2025)

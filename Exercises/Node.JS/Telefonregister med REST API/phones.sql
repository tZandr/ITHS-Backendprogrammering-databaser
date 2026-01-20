-- Made in datagrip, just here for reference

CREATE DATABASE phone_db;
use phone_db;

CREATE TABLE phone (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    price INT NOT NULL
);

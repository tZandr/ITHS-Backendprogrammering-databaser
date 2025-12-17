CREATE DATABASE SQLLAB_GYM;
USE SQLLAB_GYM;

CREATE TABLE Membership (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    duration_months INT NOT NULL
);

CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    membership_id INT NOT NULL,

    CONSTRAINT uq_member_email UNIQUE (email),
    CONSTRAINT fk_member_membership
        FOREIGN KEY (membership_id)
        REFERENCES Membership(membership_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,

    CONSTRAINT uq_instructor_email UNIQUE (email)
);

CREATE TABLE Class (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    start_time DATE NOT NULL,
    duration INT NOT NULL COMMENT 'Duration in minutes',
    instructor_id INT NOT NULL,

    CONSTRAINT fk_class_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES Instructor(instructor_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Booking ( -- Det är här jag tänker att kopplingen blir M-N
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'booked',
    member_id INT NOT NULL,
    class_id INT NOT NULL,

    CONSTRAINT fk_booking_member
        FOREIGN KEY (member_id)
        REFERENCES Member(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_booking_class
        FOREIGN KEY (class_id)
        REFERENCES Class(class_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT uq_member_class UNIQUE (member_id, class_id)
);

-- Data

-- Data
INSERT INTO Membership (name, price, duration_months) VALUES
('Basic', 299.00, 1),
('Standard', 399.00, 1),
('Premium', 499.00, 1);

INSERT INTO Member (name, email, membership_id) VALUES
('Ludvig Ekström', 'ludvig.ekstrom@example.com', 1),
('Erik Sandberg', 'erik.sandberg@example.com', 2),
('Maria Karlsson', 'maria.karlsson@example.com', 3);

INSERT INTO Instructor (name, email) VALUES
('Annica Larsson', 'annica.larsson@example.com'),
('Johan Berg', 'johan.berg@example.com');

INSERT INTO Class (name, start_time, duration, capacity, instructor_id) VALUES
('Bodypump', '2025-01-10 10:00:00', 60, 15, 1),
('Spinning', '2025-01-10 12:00:00', 45, 20, 2),
('HIIT', '2025-01-11 18:00:00', 30, 12, 1);

INSERT INTO Booking (member_id, class_id, status) VALUES
(1, 1, 'booked'),
(1, 2, 'booked'),
(2, 1, 'booked'),
(3, 3, 'booked'),
(2, 3, 'booked');

-- Step 1: Create Database
DROP DATABASE IF EXISTS pharmacy_project;
CREATE DATABASE pharmacy_project;
USE pharmacy_project;

-- Step 2: Create Normalized Tables First (Required for Foreign Keys Later)

-- 2.1 Roles Table (for normalization of 'User')
CREATE TABLE Role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(20) NOT NULL UNIQUE
);

-- 2.2 Medicine Type Table (for normalization of 'Medicine')
CREATE TABLE Medicine_Type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

-- Step 3: Create Main Tables

-- 3.1 User Table (reference to Role)
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

-- 3.2 Customer Table
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- 3.3 Manufacturer Table
CREATE TABLE Manufacturer (
    manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200)
);

-- 3.4 Medicine Table (reference to Manufacturer and Medicine_Type)
CREATE TABLE Medicine (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    quantity INT,
    manufacturer_id INT,
    type_id INT,
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturer(manufacturer_id),
    FOREIGN KEY (type_id) REFERENCES Medicine_Type(type_id)
);

-- 3.5 Sales Invoice Table (reference to Customer and User)
CREATE TABLE Sales_Invoice (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_date DATE,
    customer_id INT,
    user_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- 3.6 Invoice Details Table (Many-to-Many between Medicine and Sales_Invoice)
CREATE TABLE Invoice_Details (
    invoice_id INT,
    medicine_id INT,
    quantity INT,
    PRIMARY KEY (invoice_id, medicine_id),
    FOREIGN KEY (invoice_id) REFERENCES Sales_Invoice(invoice_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

-- Step 4: Show All Tables to Verify
SHOW TABLES;
-- Step 3: Inserting Data into Tables
-- Insert data into Role table
INSERT INTO Role (role_name) VALUES
('admin'),
('user');

-- Insert data into Medicine_Type table
INSERT INTO Medicine_Type (type_name) VALUES
('Painkiller'),
('Cough Medicine'),
('Antibiotic'),
('Diabetic Medicine'),
('Supplement'),
('Allergy Medicine'),
('Blood Pressure'),
('Antacid');

-- Insert data into User table
INSERT INTO User (username, password, role_id) VALUES
('admin', 'admin123', 1),
('john_doe', 'password', 2),
('jane_doe', 'password', 2),
('mohamed_ali', '123456', 2),
('ahmed_sayed', 'password123', 2),
('sara_mohamed', '1234', 2),
('nada_hassan', 'qwerty', 2),
('omar_sherif', 'password1', 2),
('layla_khaled', 'password2023', 2),
('mohamed_nasser', 'securepass', 2);

-- Insert data into Customer table
INSERT INTO Customer (name, phone, email) VALUES
('Ahmed Hassan', '01012345678', 'ahmed@gmail.com'),
('Mona Ahmed', '01023456789', 'mona@gmail.com'),
('Ali Mohamed', '01034567890', 'ali@gmail.com'),
('Sarah Ali', '01045678901', 'sarah@gmail.com'),
('Ahmed Shawky', '01056789012', 'ahmed.shawky@gmail.com'),
('Laila Sayed', '01067890123', 'laila@gmail.com'),
('Omar Mohamed', '01078901234', 'omar@gmail.com'),
('Yara Khaled', '01089012345', 'yara@gmail.com'),
('Ramy Hossam', '01090123456', 'ramy@gmail.com'),
('Dina Tamer', '01012345679', 'dina@gmail.com');

-- Insert data into Manufacturer table
INSERT INTO Manufacturer (name, address) VALUES
('Pharma Co.', '123 Pharmacy Street'),
('Med Supply', '456 Medical Avenue'),
('Health Mart', '789 Wellness Blvd'),
('Life Care', '101 Health Park'),
('Vital Pharma', '202 Vital Road'),
('CureTech', '303 Cure St'),
('Medicor', '404 Med Center'),
('Rx Solutions', '505 Pharmacy Way'),
('SafeMed', '606 Safety Blvd'),
('HealthLife', '707 Health Rd');

-- Insert data into Medicine table
INSERT INTO Medicine (name, price, quantity, manufacturer_id, type_id) VALUES
('Paracetamol', 10.5, 100, 1, 1),
('Aspirin', 15.0, 150, 2, 1),
('Cough Syrup', 25.0, 200, 3, 2),
('Amoxicillin', 50.0, 50, 4, 3),
('Insulin', 120.0, 30, 5, 4),
('Ibuprofen', 20.0, 100, 6, 1),
('Vitamin C', 12.0, 500, 7, 5),
('Diphenhydramine', 18.0, 200, 8, 6),
('Lisinopril', 40.0, 75, 9, 7),
('Omeprazole', 30.0, 60, 10, 8);

-- Insert data into Sales_Invoice table
INSERT INTO Sales_Invoice (invoice_date, customer_id, user_id) VALUES
('2025-05-01', 1, 1),
('2025-05-02', 2, 2),
('2025-05-03', 3, 3),
('2025-05-04', 4, 4),
('2025-05-05', 5, 5),
('2025-05-06', 6, 6),
('2025-05-07', 7, 7),
('2025-05-08', 8, 8),
('2025-05-09', 9, 9),
('2025-05-10', 10, 10);

-- Insert data into Invoice_Details table
INSERT INTO Invoice_Details (invoice_id, medicine_id, quantity) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 1),
(4, 4, 5),
(5, 5, 2),
(6, 6, 4),
(7, 7, 3),
(8, 8, 6),
(9, 9, 2),
(10, 10, 1);
-- Query 1: Search for medicines containing "Pain"
SELECT * FROM Medicine WHERE name LIKE '%Pain%';

-- Query 2: Aggregate function (Sum of quantity of medicines)
SELECT SUM(quantity) AS total_quantity FROM Medicine;

-- Query 3: Order medicines by price in ascending order
SELECT * FROM Medicine ORDER BY price ASC;

-- Query 4: Order medicines by price in descending order
SELECT * FROM Medicine ORDER BY price DESC;

-- Query 5: Aggregate function (Average price of medicines)
SELECT AVG(price) AS average_price FROM Medicine;

-- Optional: Check Tables
SHOW TABLES;











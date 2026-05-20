CREATE DATABASE IF NOT EXISTS Hotel_Management_System;
USE Hotel_Management_System;

CREATE TABLE IF NOT EXISTS Hotel (
  Hotel_Id INT PRIMARY KEY,
  Hotel_Name VARCHAR(100) NOT NULL,
  City VARCHAR(50) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  Rating INT CHECK (Rating BETWEEN 1 AND 5),
  Hotline int NOT NULL
);

CREATE TABLE IF NOT EXISTS Supplier (
  Supplier_Id INT PRIMARY KEY AUTO_INCREMENT,
  Phone_Number VARCHAR(20) UNIQUE,
  Email VARCHAR(100) NOT NULL UNIQUE,
  Company_Supplier_Name VARCHAR(100) NOT NULL,
  Supplier_Name VARCHAR(100) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  City VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Manager (
  Manager_Id INT PRIMARY KEY AUTO_INCREMENT,
  Manager_Name VARCHAR(100) NOT NULL,
  Phone_Number VARCHAR(20) UNIQUE NOT NULL,
  Salary INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Receptionist (
  Receptionist_Id INT PRIMARY KEY AUTO_INCREMENT,
  Receptionist_Name VARCHAR(100) NOT NULL,
  Phone_Number VARCHAR(20) UNIQUE NOT NULL,
  Shift TIME NOT NULL,
  Salary int NOT NULL,
  Manager_Id INT NOT NULL,
  FOREIGN KEY (Manager_Id) REFERENCES Manager(Manager_Id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Guests (
  SSN VARCHAR(20) PRIMARY KEY ,
  First_Name VARCHAR(50) NOT NULL,
  Last_Name VARCHAR(50) NOT NULL,
  Address VARCHAR(255) NOT NULL,
  Nationality VARCHAR(50) NOT NULL,
  Phone_Number VARCHAR(20) UNIQUE NOT NULL,
  Gender VARCHAR(10) NOT NULL,
  Date_Of_Birth DATE NOT NULL,
  Hotel_Id int NULL,
  Receptionist_Id int NOT NULL,
  FOREIGN KEY (Hotel_Id) REFERENCES Hotel(Hotel_Id)
  ON UPDATE CASCADE
  ON DELETE SET NULL,
  FOREIGN KEY (Receptionist_Id) REFERENCES Receptionist(Receptionist_Id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Staff (
  Staff_Id INT PRIMARY KEY AUTO_INCREMENT,
  Staff_Name VARCHAR(100) NOT NULL,
  Salary INT NOT NULL,
  Department VARCHAR(50) NOT NULL,
  Staff_Role VARCHAR(50) NOT NULL,
  Manager_Id INT NOT NULL,
  FOREIGN KEY (Manager_Id) REFERENCES Manager(Manager_Id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Facilities (
  Facilities_Id INT PRIMARY KEY AUTO_INCREMENT,
  Facilities_Name VARCHAR(150) NOT NULL,
  Facilities_Fees INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Room_Data (
  Room_Type_Id INT PRIMARY KEY AUTO_INCREMENT,
  Type_Name VARCHAR(50) NOT NULL,
  Room_Type_Description VARCHAR(255) NOT NULL,
  Price_Per_Night INT NOT NULL,
  Availability boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS Room_Info (
  Room_Number INT PRIMARY KEY,
  Room_Type_Id INT NOT NULL,
  FOREIGN KEY (Room_Type_Id) REFERENCES Room_Data(Room_Type_Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Reservation_Info (
  Reservation_Id INT PRIMARY KEY AUTO_INCREMENT,
  Check_In DATETIME NOT NULL,
  Check_Out DATETIME NOT NULL,
  Room_Number INT NOT NULL ,
  SSN VARCHAR(20) NOT NULL ,
  Receptionist_Id int NOT NULL, 
  FOREIGN KEY (Room_Number) REFERENCES Room_Info(Room_Number)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (SSN) REFERENCES Guests(SSN)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (Receptionist_Id) REFERENCES Receptionist(Receptionist_Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Payment (
  Payment_Id INT PRIMARY KEY AUTO_INCREMENT,
  Payment_Date DATE NOT NULL,
  Payment_Method VARCHAR(50) NOT NULL,
  Room_Charge INT NOT NULL,
  Extras INT DEFAULT 0,
  Reservation_Id INT NOT NULL,
  FOREIGN KEY (Reservation_Id) REFERENCES Reservation_Info(Reservation_Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Multivalue table:

CREATE TABLE IF NOT EXISTS Supplied_Items(
Supplied_Items VARCHAR(100), 
Supplier_Id int NOT NULL,
primary key(Supplied_Items,Supplier_Id),
foreign key(Supplier_Id) references Supplier(Supplier_Id)
);

drop table Supplied_Items;
show tables;

CREATE TABLE IF NOT EXISTS Supplied_Items(
Item_Price int not null,
Item_Name VARCHAR(15) NOT NULL,
Item_Category VARCHAR(50) NOT NULL,
Supplied_Items_Id VARCHAR(100) NOT NULL, 
Supplier_Id int NOT NULL,
primary key(Supplied_Items_Id),
foreign key(Supplier_Id) references Supplier(Supplier_Id)
);
describe Supplied_Items;



-- many to many tables 

CREATE TABLE IF NOT EXISTS Used_Facilities (
  SSN VARCHAR(20) NOT NULL,
  Facilities_Id INT NOT NULL,
  PRIMARY KEY (SSN, Facilities_Id),
  FOREIGN KEY (SSN) REFERENCES Guests(SSN)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (Facilities_Id) REFERENCES Facilities(Facilities_Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Assigned_Facilities (
  Facilities_Id INT NOT NULL,
  Staff_Id INT NOT NULL,
  PRIMARY KEY (Facilities_Id, Staff_Id),
  FOREIGN KEY (Facilities_Id) REFERENCES Facilities(Facilities_Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (Staff_Id) REFERENCES Staff(Staff_Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Restock_Supplier(
  Supplier_Id INT NOT NULL,
  Hotel_Id INT NOT NULL,
  PRIMARY KEY (Supplier_Id, Hotel_Id),
  FOREIGN KEY (Supplier_Id) REFERENCES Supplier(Supplier_Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (Hotel_Id) REFERENCES Hotel(Hotel_Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);


 -- insertion
 
 
 -- Hotels (10)
INSERT INTO Hotel (Hotel_Id, Hotel_Name, City, Country, Rating, Hotline) VALUES
(1, 'Nile View Hotel', 'Cairo', 'Egypt', 5, 19991111),
(2, 'Pyramids Inn', 'Giza', 'Egypt', 4, 19992222),
(3, 'Luxor Palace', 'Luxor', 'Egypt', 5, 19993333),
(4, 'Aswan Oasis', 'Aswan', 'Egypt', 4, 19994444),
(5, 'Red Sea Resort', 'Hurghada', 'Egypt', 5, 19995555),
(6, 'Alexandria Bay Hotel', 'Alexandria', 'Egypt', 4, 19996666),
(7, 'Cairo Downtown', 'Cairo', 'Egypt', 3, 19997777),
(8, 'Sharm Sunshine', 'Sharm El Sheikh', 'Egypt', 5, 19998888),
(9, 'Sinai View', 'Dahab', 'Egypt', 4, 19999999),
(10, 'Nile Breeze', 'Cairo', 'Egypt', 3, 19990000);

describe Hotel;
select * from Hotel;

-- Suppliers (15)
INSERT INTO Supplier (Phone_Number, Email, Company_Supplier_Name, Supplier_Name, Country, City) VALUES
('01110000001', '[info@cairofood.com](mailto:info@cairofood.com)', 'Cairo Food Supply', 'Ahmed Nabil', 'Egypt', 'Cairo'),
('01110000002', '[contact@luxorfurniture.com](mailto:contact@luxorfurniture.com)', 'Luxor Furniture Co', 'Sara Mahmoud', 'Egypt', 'Luxor'),
('01110000003', '[sales@aswanlinen.com](mailto:sales@aswanlinen.com)', 'Aswan Linen Ltd', 'Omar Hassan', 'Egypt', 'Aswan'),
('01110000004', '[support@hurghadaclean.com](mailto:support@hurghadaclean.com)', 'Hurghada Cleaning Supplies', 'Laila Sami', 'Egypt', 'Hurghada'),
('01110000005', '[orders@alexdecoration.com](mailto:orders@alexdecoration.com)', 'Alex Decoration', 'Hany Adel', 'Egypt', 'Alexandria'),
('01110000006', '[info@sharmtech.com](mailto:info@sharmtech.com)', 'Sharm Tech Supply', 'Mona Farid', 'Egypt', 'Sharm El Sheikh'),
('01110000007', '[contact@dahabdrinks.com](mailto:contact@dahabdrinks.com)', 'Dahab Drinks Co', 'Khaled Naguib', 'Egypt', 'Dahab'),
('01110000008', '[sales@cairoclean.com](mailto:sales@cairoclean.com)', 'Cairo Cleaning Ltd', 'Fatma Ali', 'Egypt', 'Cairo'),
('01110000009', '[support@gizafood.com](mailto:support@gizafood.com)', 'Giza Food Supply', 'Tamer Youssef', 'Egypt', 'Giza'),
('01110000010', '[orders@luxorstay.com](mailto:orders@luxorstay.com)', 'Luxor Stay Supplies', 'Amira Salah', 'Egypt', 'Luxor'),
('01110000011', '[info@aswanbeds.com](mailto:info@aswanbeds.com)', 'Aswan Beds', 'Nadia Hamid', 'Egypt', 'Aswan'),
('01110000012', '[contact@hurghadadrinks.com](mailto:contact@hurghadadrinks.com)', 'Hurghada Drinks Co', 'Omar Farouk', 'Egypt', 'Hurghada'),
('01110000013', '[sales@alexfood.com](mailto:sales@alexfood.com)', 'Alex Food Supply', 'Rania Adel', 'Egypt', 'Alexandria'),
('01110000014', '[support@sharmlinen.com](mailto:support@sharmlinen.com)', 'Sharm Linen Ltd', 'Youssef Sami', 'Egypt', 'Sharm El Sheikh'),
('01110000015', '[orders@dahabcatering.com](mailto:orders@dahabcatering.com)', 'Dahab Catering', 'Mona Hany', 'Egypt', 'Dahab');

describe Supplier;
select * from Supplier;

-- Managers (5)
INSERT INTO Manager (Manager_Name, Phone_Number, Salary) VALUES
('Mohamed Ahmed', '01010000001', 12000),
('Sara Ali', '01010000002', 12500),
('Omar Nabil', '01010000003', 13000),
('Laila Hassan', '01010000004', 11500),
('Hany Youssef', '01010000005', 14000);

describe Manager;
select * from Manager;

-- Receptionists (10)
INSERT INTO Receptionist (Receptionist_Name, Phone_Number, Shift, Salary, Manager_Id) VALUES
('Nadia Samir', '01020000001', '08:00:00', 5000, 1),
('Khaled Farouk', '01020000002', '16:00:00', 5200, 1),
('Amira Tamer', '01020000003', '08:00:00', 5100, 2),
('Fatma Adel', '01020000004', '16:00:00', 5300, 2),
('Youssef Omar', '01020000005', '08:00:00', 5000, 3),
('Mona Sami', '01020000006', '16:00:00', 5200, 3),
('Ahmed Hany', '01020000007', '08:00:00', 5100, 4),
('Sara Nabil', '01020000008', '16:00:00', 5300, 4),
('Hany Mohamed', '01020000009', '08:00:00', 5000, 5),
('Rania Ali', '01020000010', '16:00:00', 5200, 5);

describe Receptionist;
select * from Receptionist;


-- Guests (20)
INSERT INTO Guests (SSN, First_Name, Last_Name, Address, Nationality, Phone_Number, Gender, Date_Of_Birth, Hotel_Id, Receptionist_Id) 
VALUES
('30102214567890',  'Ahmed',   'Mohamed', '12 Tahrir St, Cairo','Egyptian', '01030000001', 'Male',   '1990-05-12', 1, 1),
('30205123567891',  'Sara',    'Ali',     '45 Nile Ave, Giza','Egyptian', '01030000002', 'Female', '1992-11-03', 2, 2),
('29912094567892',  'Omar',    'Hassan',  '78 Ramses Rd, Cairo','Egyptian', '01030000003', 'Male',   '1995-07-21', 3, 3),
('30007011567893',  'Mona',    'Sami',    '33 Corniche St, Alexandria','Egyptian', '01030000004', 'Female', '1991-09-10', 4, 4),
('30103184567894',  'Youssef', 'Adel',    '22 Luxor Rd, Luxor','Egyptian', '01030000005', 'Male',   '1993-01-15', 5, 5),
('30002254567895',  'Fatma',   'Omar',    '11 Nile St, Cairo','Egyptian', '01030000006', 'Female', '1994-12-22', 6, 6),
('29810111567896',  'Hany',    'Farid',   '66 Aswan Rd, Aswan','Egyptian', '01030000007', 'Male',   '1990-03-17', 7, 7),
('30302012567897',  'Rania',   'Salah',   '77 Hurghada St, Hurghada',      'Egyptian', '01030000008', 'Female', '1992-07-30', 8, 8),
('29909094567898',  'Mohamed', 'Tamer',   '88 Sharm Rd, Sharm El Sheikh',  'Egyptian', '01030000009', 'Male',   '1995-11-11', 9, 9),
('30206154567899',  'Amira',   'Hamid',   '99 Dahab St, Dahab',            'Egyptian', '01030000010', 'Female', '1991-02-25',10,10),
('29711234567900',  'Nadia',   'Youssef', '101 Nile St, Cairo',            'Egyptian', '01030000011', 'Female', '1990-08-05', 1, 1),
('30108124567901',  'Khaled',  'Mohamed', '102 Ramses Rd, Giza',           'Egyptian', '01030000012', 'Male',   '1993-06-19', 2, 2),
('29903054567902',  'Sara',    'Hassan',  '103 Luxor Rd, Luxor',           'Egyptian', '01030000013', 'Female', '1994-04-07', 3, 3),
('30301014567903',  'Omar',    'Ali',     '104 Aswan St, Aswan',           'Egyptian', '01030000014', 'Male',   '1995-09-14', 4, 4),
('29805094567904',  'Laila',   'Nabil',   '105 Hurghada Rd, Hurghada',     'Egyptian', '01030000015', 'Female', '1991-12-03', 5, 5),
('30109184567905',  'Ahmed',   'Farid',   '106 Sharm Rd, Sharm El Sheikh', 'Egyptian', '01030000016', 'Male',   '1990-10-20', 6, 6),
('30003254567906',  'Mona',    'Salah',   '107 Dahab St, Dahab',           'Egyptian', '01030000017', 'Female', '1992-01-29', 7, 7),
('29907224567907',  'Youssef', 'Hamid',   '108 Nile St, Cairo',            'Egyptian', '01030000018', 'Male',   '1993-03-18', 8, 8),
('30204014567908',  'Fatma',   'Tamer',   '109 Ramses Rd, Giza',           'Egyptian', '01030000019', 'Female', '1994-07-12', 9, 9),
('30006234567909',  'Hany',    'Sami',    '110 Luxor Rd, Luxor',           'Egyptian', '01030000020', 'Male',   '1995-05-23',10,10);


describe Guests;
select * from Guests;

-- Staff (15)
INSERT INTO Staff (Staff_Name, Salary, Department, Staff_Role, Manager_Id) VALUES
('Ali Ahmed', 6000, 'Housekeeping', 'Cleaner', 1),
('Sara Mohamed', 6500, 'Front Desk', 'Reception Support', 1),
('Omar Hassan', 7000, 'Maintenance', 'Technician', 2),
('Mona Nabil', 6200, 'Housekeeping', 'Cleaner', 2),
('Youssef Farid', 6800, 'Front Desk', 'Reception Support', 3),
('Fatma Tamer', 6000, 'Housekeeping', 'Cleaner', 3),
('Hany Sami', 7200, 'Maintenance', 'Technician', 4),
('Rania Ali', 6500, 'Front Desk', 'Reception Support', 4),
('Mohamed Hamid', 7000, 'Housekeeping', 'Cleaner', 5),
('Amira Omar', 6800, 'Front Desk', 'Reception Support', 5),
('Nadia Youssef', 6300, 'Housekeeping', 'Cleaner', 1),
('Khaled Mohamed', 6900, 'Maintenance', 'Technician', 2),
('Sara Hassan', 6200, 'Front Desk', 'Reception Support', 3),
('Omar Ali', 7100, 'Housekeeping', 'Cleaner', 4),
('Laila Nabil', 6700, 'Maintenance', 'Technician', 5);

describe Staff;
select * from Staff;

-- Facilities (10)
INSERT INTO Facilities (Facilities_Name, Facilities_Fees) VALUES
('Swimming Pool', 500),
('Gym', 300),
('Spa', 400),
('Restaurant', 200),
('Bar', 250),
('Conference Hall', 600),
('Parking', 100),
('Wi-Fi', 50),
('Laundry', 150),
('Airport Shuttle', 300);

describe Facilities;
select * from Facilities;

-- Room_Data (30)
INSERT INTO Room_Data (Type_Name, Room_Type_Description, Price_Per_Night, Availability) VALUES
('Single', 'Single bed, basic amenities', 100, true),
('Double', 'Double bed, standard amenities', 150, true),
('Suite', 'King bed, luxury amenities', 300, true),
('Deluxe', 'Queen bed, ocean view', 250, true),
('Family', 'Two bedrooms, living area', 400, true),
('Single', 'Single bed, city view', 100, true),
('Double', 'Double bed, sea view', 160, true),
('Suite', 'King bed, jacuzzi', 350, true),
('Deluxe', 'Queen bed, balcony', 260, true),
('Family', 'Three bedrooms, living area', 450, true),
('Single', 'Single bed, balcony', 110, true),
('Double', 'Double bed, balcony', 170, true),
('Suite', 'King bed, ocean view', 320, true),
('Deluxe', 'Queen bed, garden view', 240, true),
('Family', 'Two bedrooms, garden view', 420, true),
('Single', 'Single bed, standard', 105, true),
('Double', 'Double bed, standard', 155, true),
('Suite', 'King bed, luxury view', 330, true),
('Deluxe', 'Queen bed, luxury', 270, true),
('Family', 'Two bedrooms, premium', 430, true),
('Single', 'Single bed, city view', 115, true),
('Double', 'Double bed, city view', 165, true),
('Suite', 'King bed, suite view', 310, true),
('Deluxe', 'Queen bed, deluxe', 260, true),
('Family', 'Three bedrooms, deluxe', 440, true),
('Single', 'Single bed, luxury', 120, true),
('Double', 'Double bed, luxury', 180, true),
('Suite', 'King bed, penthouse', 360, true),
('Deluxe', 'Queen bed, premium', 280, true),
('Family', 'Two bedrooms, penthouse', 450, true);

describe Room_Data;
select * from Room_Data;

-- Room_Info (30)
INSERT INTO Room_Info (Room_Number, Room_Type_Id) VALUES
(101, 1),(102, 2),(103, 3),(104, 4),(105, 5),
(106, 1),(107, 2),(108, 3),(109, 4),(110, 5),
(111, 1),(112, 2),(113, 3),(114, 4),(115, 5),
(116, 1),(117, 2),(118, 3),(119, 4),(120, 5),
(121, 6),(122, 7),(123, 8),(124, 9),(125, 10),
(126, 11),(127, 12),(128, 13),(129, 14),(130, 15);

describe Room_Info;
select * from Room_Info;


-- Reservation_Info(20)
INSERT INTO Reservation_Info (Check_In, Check_Out, Room_Number, SSN, Receptionist_Id) VALUES
('2025-12-01 14:00:00', '2025-12-05 12:00:00', 101, 30102214567890, 1),
('2025-12-02 15:00:00', '2025-12-06 11:00:00', 102, 30205123567891, 2),
('2025-12-03 12:00:00', '2025-12-07 12:00:00', 103, 29912094567892, 3),
('2025-12-01 16:00:00', '2025-12-04 10:00:00', 104, 30007011567893, 4),
('2025-12-05 14:00:00', '2025-12-10 12:00:00', 105, 30103184567894, 5),
('2025-12-06 14:00:00', '2025-12-12 12:00:00', 106, 30002254567895, 6),
('2025-12-07 14:00:00', '2025-12-11 12:00:00', 107, 29810111567896, 7),
('2025-12-02 14:00:00', '2025-12-06 12:00:00', 108, 30302012567897, 8),
('2025-12-03 14:00:00', '2025-12-08 12:00:00', 109, 29909094567898, 9),
('2025-12-04 14:00:00', '2025-12-09 12:00:00', 110, 30206154567899, 10),
('2025-12-05 14:00:00', '2025-12-08 12:00:00', 111, 29711234567900, 1),
('2025-12-06 14:00:00', '2025-12-10 12:00:00', 112, 30108124567901, 2),
('2025-12-07 14:00:00', '2025-12-12 12:00:00', 113, 29903054567902, 3),
('2025-12-01 14:00:00', '2025-12-05 12:00:00', 114, 30301014567903, 4),
('2025-12-02 14:00:00', '2025-12-06 12:00:00', 115, 29805094567904, 5),
('2025-12-03 14:00:00', '2025-12-07 12:00:00', 116, 30109184567905, 6),
('2025-12-04 14:00:00', '2025-12-09 12:00:00', 117, 30003254567906, 7),
('2025-12-05 14:00:00', '2025-12-10 12:00:00', 118, 29907224567907, 8),
('2025-12-06 14:00:00', '2025-12-11 12:00:00', 119, 30204014567908, 9),
('2025-12-07 14:00:00', '2025-12-12 12:00:00', 120, 30006234567909, 10);



describe Reservation_Info;
select * from Reservation_Info;

INSERT INTO Supplied_Items 
(Item_Price, Item_Name, Item_Category, Supplied_Items_Id, Supplier_Id)
VALUES
(50,  'Shampoo',        'Personal Care',         'SI001', 1),
(30,  'Soap',           'Personal Care',         'SI002', 1),
(120, 'Notebook',       'Stationery',            'SI003', 2),
(15,  'Pen',            'Stationery',            'SI004', 2),
(250, 'USB Cable',      'Electronics',           'SI005', 3),
(900, 'Headphones',     'Electronics',           'SI006', 3),
(75,  'Coffee',         'Food & Beverage',       'SI007', 4),
(60,  'Tea Box',        'Food & Beverage',       'SI008', 4),
(110, 'Detergent',      'Cleaning Supplies',     'SI009', 2),
(45,  'Mop',            'Cleaning Supplies',     'SI010', 1);


describe Supplied_Items;
select * from Supplied_Items;

-- payment insertion 
INSERT INTO Payment (Payment_Date, Payment_Method, Room_Charge, Extras, Reservation_Id) VALUES
('2025-01-02', 'Credit Card', 300, 50, 1),
('2025-01-05', 'Cash', 200, 0, 2),
('2025-01-07', 'Debit Card', 450, 20, 3),
('2025-01-09', 'Credit Card', 600, 0, 4),
('2025-01-10', 'Credit Card', 350, 30, 5),
('2025-01-12', 'Cash', 400, 0, 6),
('2025-01-14', 'Debit Card', 320, 15, 7),
('2025-01-15', 'Cash', 500, 40, 8),
('2025-01-17', 'Credit Card', 250, 0, 9),
('2025-01-18', 'Debit Card', 270, 10, 10),
('2025-01-20', 'Credit Card', 390, 20, 11),
('2025-01-21', 'Cash', 410, 0, 12),
('2025-01-22', 'Debit Card', 360, 25, 13),
('2025-01-24', 'Credit Card', 300, 0, 14),
('2025-01-25', 'Credit Card', 500, 50, 15),
('2025-01-27', 'Cash', 330, 0, 16),
('2025-01-28', 'Debit Card', 420, 10, 17),
('2025-01-30', 'Debit Card', 380, 20, 18),
('2025-02-01', 'Credit Card', 450, 35, 19),
('2025-02-02', 'Cash', 600, 0, 20);

describe Payment;
select * from Payment;

--  check availability based on check in and check out dates.
UPDATE Room_Data
JOIN Room_Info ON Room_Data.Room_Type_Id = Room_Info.Room_Type_Id
JOIN Reservation_Info ON Room_Info.Room_Number = Reservation_Info.Room_Number
SET Room_Data.Availability = false
WHERE NOW() BETWEEN Reservation_Info.Check_In AND Reservation_Info.Check_Out;

select * from Room_Data;

-- modify
Alter table Payment
modify column Payment_Method Enum('cash','credit card','debit card') NOT NULL;

select * from Payment;
describe Payment;

-- DROP
ALTER TABLE Guests
drop column Gender;
select * from Guests;

-- ADD 
ALTER TABLE Guests
ADD COLUMN Gender VARCHAR(10) not null;

UPDATE Guests SET Gender = 'Male'   WHERE SSN = 30102214567890;
UPDATE Guests SET Gender = 'Female' WHERE SSN = 30205123567891;
UPDATE Guests SET Gender = 'Male'   WHERE SSN = 29912094567892;
UPDATE Guests SET Gender = 'Female'   WHERE SSN = 30007011567893;
UPDATE Guests SET Gender = 'Male' WHERE SSN = 30103184567894;
UPDATE Guests SET Gender = 'Female' WHERE SSN = 30002254567895;
UPDATE Guests SET Gender = 'Male'   WHERE SSN = 29810111567896;
UPDATE Guests SET Gender = 'Female' WHERE SSN = 30302012567897;
UPDATE Guests SET Gender = 'Male'   WHERE SSN = 29909094567898;
UPDATE Guests SET Gender = 'Female' WHERE SSN = 30206154567899;
UPDATE Guests SET Gender = 'Female'   WHERE SSN = 29711234567900;
UPDATE Guests SET Gender = 'Male' WHERE SSN = 30108124567901;
UPDATE Guests SET Gender = 'Female'   WHERE SSN = 29903054567902;
UPDATE Guests SET Gender = 'Male' WHERE SSN = 30301014567903;
UPDATE Guests SET Gender = 'Female'   WHERE SSN = 29805094567904;
UPDATE Guests SET Gender = 'Male' WHERE SSN = 30109184567905;
UPDATE Guests SET Gender = 'Female'   WHERE SSN = 30003254567906;
UPDATE Guests SET Gender = 'Male'   WHERE SSN = 29907224567907;
UPDATE Guests SET Gender = 'Female' WHERE SSN = 30204014567908;
UPDATE Guests SET Gender = 'Male'   WHERE SSN = 30006234567909;

SELECT * FROM Guests;

-- DELETE
Delete from Hotel
where Rating =3;
select * from Hotel;

-- retrieval/logical operator between
select Staff_Id from Staff
where Staff_Id between 5 and 10;

-- logical operator like
select Staff_Name from Staff
where Staff_Name like 'm%';

-- comparison operator
select Room_Charge from Payment
where Room_Charge > 350;

-- Aggragation functions
-- LIMIT
select Check_In from Reservation_Info
LIMIT 5;

-- SUM
SELECT Reservation_Id , SUM(Room_Charge + Extras) AS Total_Per_Guest
FROM Payment
GROUP BY Reservation_Id;

-- Order by
SELECT * from Guests
ORDER BY First_Name DESC; 





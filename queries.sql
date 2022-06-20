CREATE TABLE customer
(
c_username VARCHAR(20) PRIMARY KEY,
f_name VARCHAR(20),
l_name VARCHAR(20),
c_phone BIGINT(12),
email VARCHAR(30),
c_dob DATE,
c_password VARCHAR(20)
) ; 

CREATE TABLE admin
(
a_username VARCHAR(20) PRIMARY KEY,
f_name VARCHAR(20),
l_name VARCHAR(20),
a_phone BIGINT(12),
email VARCHAR(30),
a_dob DATE,
password VARCHAR(20)
) ;

CREATE TABLE company
 (
 cmp_logo VARCHAR(200),
 cmp_name VARCHAR(20) PRIMARY KEY,
 cmp_email VARCHAR(20),
 no_of_cars INT(200) DEFAULT 0,
 cmp_address VARCHAR(200),
 cmp_desc VARCHAR(1000)
 ) ;


 CREATE TABLE cars
(
car_photo VARCHAR(200),
car_no INT(20) PRIMARY KEY,
type VARCHAR(20),
car_name VARCHAR(20),
availability VARCHAR(20),
company VARCHAR(20),
price INT(20),
description VARCHAR(300),
FOREIGN KEY (company) REFERENCES company(cmp_name) ON DELETE 
CASCADE
) ;

CREATE TABLE bookings
(
car_photo VARCHAR(200),
c_username VARCHAR(20),
booking_id VARCHAR(20) PRIMARY KEY,
car_no INT,
car_name VARCHAR(20),
final_price INT(20),
FOREIGN KEY (c_username) REFERENCES customer(c_username) ON DELETE 
CASCADE,
FOREIGN KEY (car_no) REFERENCES cars(car_no) ON DELETE CASCADE
);


-- Trigger to increment the no_of_cars attribute of company table by 1 when a car information is added to the cars table.
CREATE TRIGGER add_car
AFTER INSERT ON cars
FOR EACH ROW
UPDATE company 
SET no_of_cars =no_of_cars+1
WHERE cmp_name = new.company;


-- Trigger to decrement the no_of_cars attribute of company table by 1 when a car information is removed from the cars table.
CREATE TRIGGER remove_car
AFTER DELETE ON cars
FOR EACH ROW
UPDATE company 
SET no_of_cars = no_of_cars-1
WHERE cmp_name = old.company;

--STORED PROCEDURE.
DELIMITER //
CREATE PROCEDURE ViewBookings()
BEGIN
SELECT * FROM `bookings`;
END;
//
DELIMITER ;

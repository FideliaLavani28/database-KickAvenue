create database KickAvenue

use [KickAvenue]

CREATE TABLE Customer(
    Email VARCHAR(25) PRIMARY KEY CHECK(Email like '%@gmail.com'),
    CName VARCHAR(25) NOT NULL,
    CPassword VARCHAR(25) NOT NULL CHECK(LEN(CPassword)>=8),
    Country VARCHAR(25) NOT NULL,
    Province VARCHAR(25) NOT NULL,
    CAddress VARCHAR(100) NOT NULL CHECK (CAddress LIKE '% %')
)

create table Inventory(
    ProductID varchar(5) primary key check(ProductID like 'PI[0-9][0-9][0-9]'),
    ProductType varchar(100) not null,
    ProductColor varchar(100) not null,
    Size int not null,
    Price float not null
)

Create table Payment(
	ReceiptID VARCHAR(5) PRIMARY KEY CHECK(ReceiptID LIKE 'RI[0-9][0-9][0-9]'),
    PaymentMethod VARCHAR(100) NOT NULL,
    AccountNumber VARCHAR(100) NOT NULL
)


CREATE TABLE Staff(
	StaffID VARCHAR(5) PRIMARY KEY CHECK(StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffRole VARCHAR(100) NOT NULL,
	StaffName VARCHAR(100) NOT NULL
)

Create table Shipping(
	ShippingID VARCHAR(5) PRIMARY KEY CHECK(ShippingID LIKE 'SI[0-9][0-9][0-9]'),
	StaffID VARCHAR(5) FOREIGN KEY REFERENCES Staff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	Weight float NOT NULL
)

create table COrder(
    OrderID varchar(5) primary key check(OrderID like 'KA[0-9][0-9][0-9]'),
    Email varchar(25) foreign key references Customer(Email) on update cascade on delete cascade,
    ReceiptID varchar(5) foreign key references Payment(ReceiptID) on update cascade on delete cascade,
    ShippingID varchar(5) foreign key references Shipping(ShippingID) on update cascade on delete cascade,
    OrderDate date
)

CREATE TABLE OrderDetail(
   	PRIMARY KEY(OrderID, ProductID),
           	OrderID VARCHAR(5) FOREIGN KEY REFERENCES COrder(OrderID) on update cascade on delete cascade,
           	ProductID VARCHAR(5) FOREIGN KEY REFERENCES Inventory(ProductID) on update cascade on delete cascade,
           	Qty INT NOT NULL
)

--INVENTORY
INSERT INTO Inventory
VALUES ('PI012','Adidas','Black','40','1000000'),('PI032','Air Jordan S','White','42','1500000'),('PI065','Air Jordan J','Tosca','39','1200000'),('PI080','Asics','Yellow','39','1800000')

INSERT INTO Inventory
VALUES ('PI045','Puma Hybrid','Red','42','2000000'),('PI046','Puma Hybrid','Red','44','2000000'),('PI047','Puma Hybrid','Red','45','2000000'),('PI048','Converse 70','Orange','37','1100000'),('PI049','Converse 70','Yellow','39','1100000')

INSERT INTO Inventory
VALUES ('PI075','Lebron XI','Blue','44','2100000'),
('PI001','Lebron XII','Grey','43','2100000'),
('PI005','AirJordan II','White','44','2100000'),
('PI055','Kyrie I','Blue White','43','1899000'),
('PI035','Curry XIII','Blue','44','2300000'),
('PI031','Klay Thompson KT6','Blue White','44','2199000'),
('PI020','Kyrie II','Orange','42','1600000')

SELECT * FROM Inventory

SELECT *
FROM Inventory
ORDER BY Price ASC

SELECT ProductID, ProductType, Price
FROM Inventory
WHERE ProductType LIKE 'Air Jordan %'
ORDER BY Price ASC

SELECT COUNT(*) AS CustomerNameWith3Words
FROM Customer
WHERE CName LIKE '% %'
HAVING COUNT(*) >= 1

SELECT COUNT(Province) AS CustomerFromJakarta, COUNT(Province) AS CustomerFromAceh
FROM Customer
WHERE Province IN ('Jakarta','Aceh')
HAVING COUNT(Province) >= 1



-- CUSTOMER
INSERT INTO Customer
VALUES ('EkoTeguh@gmail.com','Eko Teguh H.','ekoteguh1998','Indonesia','Jakarta','Jl Sungai Tiram 23'), 
('mawar_SDian@gmail.com','Mawar Sinta Dian','dian180989','Indonesia','Aceh','Jl Kacapiring 8'), 
('bennypasaribu09@gmail.com','Benny Pasaribu','pasaribu','Indonesia','Lampung','Jl Sanggar Kencana'),
('ratna.hartono@gmail.com','Ratna Cinta Hartono','rchartono','Indonesia','Banten','Jl Trunojoyo 3'),
('ezra.lubis@gmail.com','Ezra Lubis','ezralubis10','Indonesia','Aceh','Jl Holis 300')

INSERT INTO Customer
VALUES
('daniszulka89@gmail.com','Daniswara Zulkarnain','daniszulka89','Indonesia','Papua','Jl. Laksamana No. 359'),
('nurdiyanti@gmail.com','Usyi Nurdiyanti','slaksmiwat','Indonesia','Riau','Jl. Psr. Bak Air No. 697'),
('amalia.permata@gmail.com','Amalia Permata','tomipermata96','Indonesia','Bali','Jl. Fajar No. 540'),
('widwastuti@gmail.com','Widya Wastuti','wastuti00','Indonesia','Aceh','Jl. Honggowongso No. 967'),
('hartaka.nugro@gmail.com','Hartaka Nugroho','harta_nugro','Indonesia','Bali','Jl. Ki. Cut Nyak Dien No. 58')

SELECT * FROM Staff

SELECT *
FROM Customer
WHERE Country='Indonesia' AND Province='Aceh'
SELECT * FROM COrder
-- COrder 
INSERT INTO COrder
VALUES ('KA003','EkoTeguh@gmail.com','RI003','SI003','2020-09-15'),('KA051','mawar_SDian@gmail.com','RI051','SI051','2021-01-05'), ('KA043','bennypasaribu09@gmail.com','RI043','SI043','2020-12-13'),('KA011','ratna.hartono@gmail.com','RI011','SI011','2021-03-27')

INSERT INTO COrder
VALUES ('KA044','ezra.lubis@gmail.com','RI044','SI044','2020-01-15'),
('KA069','daniszulka89@gmail.com','RI069','SI069','2020-11-21'),
('KA052','nurdiyanti@gmail.com','RI052','SI052','2020-05-01'),
('KA038','amalia.permata@gmail.com','RI038','SI038','2021-03-18'),
('KA019','widwastuti@gmail.com','RI019','SI019','2021-9-11'),
('KA024','hartaka.nugro@gmail.com','RI024','SI024','2021-12-24')

INSERT INTO Payment
VALUES ('RI003','BCA','1371619391'), ('RI051','BCA','3991779635'), ('RI043','CIMB Niaga','9355853018'),('RI011','CitiBank','1418610919')

INSERT INTO Payment
VALUES ('RI044','BCA','4024007117'),
('RI069','Citibank','4556508048'),
('RI052','Mandiri','5448175742'),
('RI038','BCA','2720858479'),
('RI019','BCA','4485959817'),
('RI024','Mandiri','5387863958')

SELECT * FROM Payment

INSERT INTO Shipping
VALUES ('SI003','ST021','1.2'),('SI051','ST021','1'),('SI043','ST022','2'),('SI011','ST022','1.2')

INSERT INTO Shipping
VALUES 
('SI044','ST053','2'),
('SI069','ST035','1.2'),
('SI052','ST037','1'),
('SI038','ST054','1.1'),
('SI019','ST036','1'),
('SI024','ST052','1')

SELECT * FROM Shipping

INSERT INTO Staff
VALUES ('ST010','Manager','Daniel Samusra'),('ST021','Shipping','Ivan Handoko'), ('ST022','Shipping','Raja Surya Johan')

INSERT INTO Staff
VALUES ('ST035', 'Shipping', 'Andi Pratomo'),
('ST036', 'Shipping', 'Budi Nugraha'),
('ST037', 'Shipping', 'Jane Thomas'),
('ST051', 'Manager', 'Erick Silvernus'),
('ST052', 'Shipping', 'Kelvin April'),
('ST053', 'Shipping', 'Chrisian Albert'),
('ST054', 'Shipping', 'Nikolas Chris')

INSERT INTO OrderDetail
VALUES ('KA003','PI012','1'), ('KA051','PI065','1')

INSERT INTO OrderDetail
VALUES ('KA043','PI012','1'), ('KA011','PI080','1')

INSERT INTO OrderDetail
VALUES
('KA044','PI075','1'),
('KA069','PI001','1'),
('KA051','PI005','2'),
('KA038','PI055','1'),
('KA019','PI035','1'),
('KA024','PI031','2')

SELECT * FROM OrderDetail

SELECT OrderID, [Weight]
FROM COrder CO JOIN Shipping S ON CO.ShippingID = S.ShippingID
WHERE YEAR(OrderDate)='2020' OR [Weight]=1

SELECT OrderID, [Weight]
FROM COrder CO JOIN Shipping S ON CO.ShippingID = S.ShippingID
WHERE MONTH(OrderDate)='12' OR [Weight]=1

SELECT * FROM Shipping

SELECT CAST([Weight] AS VARCHAR) + ' kg' AS Berat, ShippingID
FROM Shipping
WHERE ShippingID IN('SI051','SI043','SI011')

SELECT RIGHT(ShippingID, 3) AS ShippingNumber
FROM Shipping
WHERE CAST(SUBSTRING(ShippingID,3,LEN(ShippingID)) AS INT) % 2=1 

SELECT [Staff]=sh.StaffID, StaffName, OrderDate
FROM Staff s JOIN Shipping sh ON s.StaffID=sh.StaffID JOIN COrder CO ON CO.ShippingID=sh.ShippingID
WHERE YEAR(OrderDate)=2020 

SELECT [Item Type]=UPPER(ProductType), [Average Price]=AVG(Price), [Number of Color]=COUNT(ProductColor)
FROM Inventory i JOIN OrderDetail od ON i.ProductID=od.ProductID
WHERE ProductType LIKE '%_%' 
GROUP BY ProductType
HAVING AVG(Price)>2000000

SELECT CName, [Maximum Purchase]=MAX(Qty), [Minimum Purchase]=MIN(Qty)
FROM Customer c JOIN COrder CO ON c.Email=CO.Email JOIN OrderDetail od ON od.OrderID=CO.OrderID
WHERE Province IN ('Bali','Aceh')
GROUP BY CName

SELECT c.CName, c.Email , i.ProductID, od.Qty
FROM Customer c JOIN COrder co ON c.Email = co.Email
JOIN OrderDetail od ON co.OrderID = od.OrderID 
JOIN Inventory i ON i.ProductID = od.ProductID,(
           SELECT avg(Qty) AS [AverageQuantity]
           FROM OrderDetail
)a
GROUP BY c.CName, c.Email, i.ProductID, a.AverageQuantity, od.Qty
HAVING a.AverageQuantity < od.Qty
ORDER BY ProductID ASC

SELECT * FROM Inventory

BEGIN TRAN
INSERT INTO Inventory
VALUES ('PI021','Nike Air','Blue Violet','37','780000')
ROLLBACK

BEGIN TRAN
UPDATE Inventory
SET Price=Price*0.7
WHERE ProductID='PI012'
ROLLBACK

BEGIN TRAN
DELETE FROM Inventory
WHERE ProductID='PI065'
ROLLBACK

SELECT * FROM COrder
BEGIN TRAN
DELETE FROM COrder
ROLLBACK

CREATE VIEW CustomerNameWith3Words
AS
SELECT COUNT(*) AS CustomerNameWith2orMoreWords, CName
FROM Customer
WHERE CName LIKE '% % %'
GROUP BY CName

--CustomerNameWith3Words
SELECT *
FROM Customer
WHERE CName LIKE '% % %'


SELECT COUNT(*) AS CustomerNameWith3orMoreWords
FROM Customer
WHERE LEN(SUBSTRING(TRIM(CName),' ',1))>0--WHERE CName NOT LIKE '% %'


--------------------------------------------------

DECLARE @CustomerID VARCHAR(5)
DECLARE @CustomerName CHAR(50)
DECLARE @MemberType CHAR(8)

DECLARE CursorGoldMember CURSOR
FOR SELECT CustomerID, CustomerName, MemberType
FROM Customer

OPEN CursorGoldMember

FETCH NEXT FROM CursorGoldMember 
INTO @CustomerID, @CustomerName, @MemberType

WHILE @@FETCH_STATUS=0
	BEGIN 
		IF (@MemberType='Gold')
			PRINT @CustomerID + @CustomerName + CONCAT(@MemberType,' membership')
			FETCH NEXT FROM CursorGoldMember 
			INTO @CustomerID, @CustomerName, @MemberType
	END

CLOSE CursorGoldMember
DEALLOCATE CursorGoldMember
--Declare variable yang digunakan dalam Cursor
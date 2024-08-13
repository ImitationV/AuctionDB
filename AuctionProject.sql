CREATE DATABASE auction_db;
USE auction_db;

-- Create tables
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20),
    UserType ENUM('Buyer', 'Seller', 'Admin') NOT NULL
);

CREATE TABLE Item (
    ItemID INT PRIMARY KEY,
    SellerID INT NOT NULL,
    ItemName VARCHAR(255) NOT NULL,
    StartingBid DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SellerID) REFERENCES User(UserID)
);

CREATE TABLE Auction (
    AuctionID INT PRIMARY KEY,
    ItemID INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Status ENUM('Upcoming', 'Ongoing', 'Completed') NOT NULL,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);

CREATE TABLE Bid (
    BidID INT PRIMARY KEY,
    AuctionID INT NOT NULL,
    BidderID INT NOT NULL,
    BidAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (AuctionID) REFERENCES Auction(AuctionID),
    FOREIGN KEY (BidderID) REFERENCES User(UserID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    BidID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME NOT NULL,
    FOREIGN KEY (BidID) REFERENCES Bid(BidID)
);

CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY,
    AuctionID INT NOT NULL,
    BuyerID INT NOT NULL,
    SellerID INT NOT NULL,
    TransactionDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    ShippingAddress VARCHAR(255) NOT NULL,
    FOREIGN KEY (AuctionID) REFERENCES Auction(AuctionID),
    FOREIGN KEY (BuyerID) REFERENCES User(UserID),
    FOREIGN KEY (SellerID) REFERENCES User(UserID)
);


-- Insert sample data into tables
INSERT INTO User (UserID, Email, Password, PhoneNumber, UserType) VALUES
(1, 'john.doe@gmail.com', 'John2024!', '123-456-7890', 'Buyer'),
(2, 'jane.smith@yahoo.com', 'Jane@123', '123-456-7891', 'Seller'),
(3, 'admin123@auction.com', 'AdminSecure1!', '123-456-7892', 'Admin'),
(4, 'mike.brown@hotmail.com', 'Mike#Pass1', '123-456-7893', 'Buyer'),
(5, 'lisa.jones@outlook.com', 'Lisa$Pass2', '123-456-7894', 'Seller'),
(6, 'david.wilson@gmail.com', 'David@2024', '123-456-7895', 'Buyer'),
(7, 'emma.davis@yahoo.com', 'Emma#2024!', '123-456-7896', 'Seller'),
(8, 'admin@own.com', 'OwnAdmin2!', '123-456-7897', 'Admin'),
(9, 'chris.evans@gmail.com', 'Chris!2024', '123-456-7898', 'Buyer'),
(10, 'sarah.miller@hotmail.com', 'Sarah$2024', '123-456-7899', 'Seller');

INSERT INTO Item (ItemID, SellerID, ItemName, StartingBid) VALUES
(1, 2, 'Antique Vase', 100.00),
(2, 5, 'Vintage Clock', 150.00),
(3, 7, 'Painting', 200.00),
(4, 2, 'Rare Book', 50.00),
(5, 5, 'Collector Coin', 75.00),
(6, 7, 'Jewelry Set', 300.00),
(7, 10, 'Classic Car', 5000.00),
(8, 5, 'Sculpture', 400.00),
(9, 7, 'Stamp Collection', 250.00),
(10, 2, 'Old Camera', 180.00);

INSERT INTO Auction (AuctionID, ItemID, StartDate, EndDate, Status) VALUES
(1, 1, '2024-01-01 10:00:00', '2024-01-07 10:00:00', 'Completed'),
(2, 2, '2024-01-02 10:00:00', '2024-01-08 10:00:00', 'Ongoing'),
(3, 3, '2024-01-03 10:00:00', '2024-01-09 10:00:00', 'Upcoming'),
(4, 4, '2024-01-04 10:00:00', '2024-01-10 10:00:00', 'Completed'),
(5, 5, '2024-01-05 10:00:00', '2024-01-11 10:00:00', 'Ongoing'),
(6, 6, '2024-01-06 10:00:00', '2024-01-12 10:00:00', 'Upcoming'),
(7, 7, '2024-01-07 10:00:00', '2024-01-13 10:00:00', 'Completed'),
(8, 8, '2024-01-08 10:00:00', '2024-01-14 10:00:00', 'Ongoing'),
(9, 9, '2024-01-09 10:00:00', '2024-01-15 10:00:00', 'Upcoming'),
(10, 10, '2024-01-10 10:00:00', '2024-01-16 10:00:00', 'Completed');

INSERT INTO Bid (BidID, AuctionID, BidderID, BidAmount) VALUES
(1, 1, 1, 120.00),
(2, 2, 4, 160.00),
(3, 3, 6, 220.00),
(4, 4, 9, 60.00),
(5, 5, 1, 85.00),
(6, 6, 4, 320.00),
(7, 7, 6, 5200.00),
(8, 8, 9, 4500.00),
(9, 9, 1, 280.00),
(10, 10, 4, 200.00);

INSERT INTO Payment (PaymentID, BidID, Amount, PaymentDate) VALUES
(1, 1, 120.00, '2024-01-08 10:00:00'),
(2, 2, 160.00, '2024-01-09 10:00:00'),
(3, 4, 60.00, '2024-01-10 10:00:00'),
(4, 5, 85.00, '2024-01-11 10:00:00'),
(5, 7, 5200.00, '2024-01-12 10:00:00'),
(6, 8, 450.00, '2024-01-13 10:00:00'),
(7, 10, 200.00, '2024-01-14 10:00:00'),
(8, 3, 220.00, '2024-01-15 10:00:00'),
(9, 6, 320.00, '2024-01-16 10:00:00'),
(10, 9, 280.00, '2024-01-17 10:00:00');


INSERT INTO Transaction (TransactionID, AuctionID, BuyerID, SellerID, TransactionDate, TotalAmount, ShippingAddress) VALUES
(1, 1, 1, 2, '2024-01-08 12:00:00', 120.00, '123 Main St'),
(2, 2, 4, 5, '2024-01-09 12:00:00', 160.00, '456 Oak St'),
(3, 4, 9, 2, '2024-01-10 12:00:00', 60.00, '789 Pine St'),
(4, 5, 1, 5, '2024-01-11 12:00:00', 85.00, '123 Maple St'),
(5, 7, 6, 10, '2024-01-12 12:00:00', 5200.00, '456 Birch St'),
(6, 8, 9, 5, '2024-01-13 12:00:00', 450.00, '789 Willow St'),
(7, 10, 4, 2, '2024-01-14 12:00:00', 200.00, '321 Cedar St'),
(8, 3, 6, 7, '2024-01-15 12:00:00', 220.00, '654 Pine St'),
(9, 6, 1, 7, '2024-01-16 12:00:00', 320.00, '789 Maple St'),
(10, 9, 4, 5, '2024-01-17 12:00:00', 280.00, '987 Oak St');


-- JOIN operation between User, Item, and Auction tables
SELECT U.UserID, U.Email, I.ItemName, A.AuctionID, A.Status
FROM User U
JOIN Item I ON U.UserID = I.SellerID
JOIN Auction A ON I.ItemID = A.ItemID;


SELECT U.UserID, U.Email, I.ItemName, B.BidAmount, A.Status
FROM Bid B
JOIN User U ON B.BidderID = U.UserID
JOIN Auction A ON B.AuctionID = A.AuctionID
JOIN Item I ON A.ItemID = I.ItemID
WHERE B.BidAmount > 4000;


-- Verify data in the tables
SELECT * FROM User;

SELECT * FROM Item;

SELECT * FROM Auction;

SELECT * FROM Bid;

SELECT * FROM Payment;

SELECT * FROM Transaction;

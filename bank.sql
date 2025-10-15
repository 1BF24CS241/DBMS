create database if not exists bank ;
 use bank ;
 
DROP TABLE IF EXISTS Depositer;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS BankAccount;
DROP TABLE IF EXISTS BankCustomer;
DROP TABLE IF EXISTS Branch;

CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets REAL
);

CREATE TABLE BankAccount (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE BankCustomer (
    customer_name VARCHAR(50) PRIMARY KEY,
    customer_street VARCHAR(100),
    customer_city VARCHAR(50)
);

CREATE TABLE Depositer (
    customer_name VARCHAR(50),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

CREATE TABLE Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);
INSERT INTO Branch VALUES
('SBI_ResidencyRoad', 'Bangalore', 12000000),
('SBI_Jayanagar', 'Bangalore', 9000000),
('SBI_Delhi', 'Delhi', 15000000),
('HDFC_MG_Road', 'Bangalore', 11000000),
('ICICI_CP', 'Delhi', 8000000);

INSERT INTO BankAccount VALUES
(1, 'SBI_ResidencyRoad', 50000),
(2, 'SBI_ResidencyRoad', 60000),
(3, 'SBI_Jayanagar', 40000),
(8, 'SBI_ResidencyRoad', 35000),
(10, 'SBI_ResidencyRoad', 70000);

INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

INSERT INTO Depositer VALUES
('Dinesh', 2),
('Avinash', 8),
('Nikil', 10),
('Mohan', 3),
('Ravi', 1);

INSERT INTO Loan VALUES
(101, 'SBI_ResidencyRoad', 200000),
(102, 'SBI_Jayanagar', 300000),
(103, 'SBI_Delhi', 500000),
(104, 'HDFC_MG_Road', 400000),
(105, 'ICICI_CP', 250000);

SELECT 
    branch_name,
    (assets / 100000) AS "assets_in_lakhs"
FROM Branch;

SELECT 
    d.customer_name, 
    b.branch_name,
    COUNT(*) AS account_count
FROM Depositer d
JOIN BankAccount a ON d.accno = a.accno
JOIN Branch b ON a.branch_name = b.branch_name
GROUP BY d.customer_name, b.branch_name
HAVING COUNT(*) >= 2;

CREATE VIEW BranchLoanSummary AS
SELECT 
    branch_name,
    SUM(amount) AS total_loan_amount
FROM Loan
GROUP BY branch_name;

SELECT * FROM BranchLoanSummary;

SELECT 
    d.customer_name,
    COUNT(d.accno) AS total_accounts
FROM Depositer d
JOIN BankAccount a ON d.accno = a.accno
WHERE a.branch_name = 'SBI_ResidencyRoad'
GROUP BY d.customer_name
HAVING COUNT(d.accno) >= 2;

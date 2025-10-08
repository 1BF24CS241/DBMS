DROP TABLE IF EXISTS OWNS;
DROP TABLE IF EXISTS ACCIDENT;
DROP TABLE IF EXISTS CAR;
DROP TABLE IF EXISTS PERSON;

CREATE TABLE PERSON (
    driver_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100)
);
CREATE TABLE CAR (
    reg_num VARCHAR(10) PRIMARY KEY,
    model VARCHAR(20),
    year INT
);
CREATE TABLE ACCIDENT (
    report_num INT PRIMARY KEY,
    accident_date DATE,
    location VARCHAR(50)
);
CREATE TABLE OWNS (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY (driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (reg_num) REFERENCES CAR(reg_num)
);
CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, reg_num, report_num),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (reg_num) REFERENCES CAR(reg_num),
    FOREIGN KEY (report_num) REFERENCES ACCIDENT(report_num)
);
INSERT INTO PERSON (driver_id, name, address) VALUES
('A01', 'Richard', 'Srinivas nagar'),
('A02', 'Pradeep', 'Rajaji nagar'),
('A03', 'Smith', 'Ashok nagar'),
('A04', 'Venu', 'N R Colony'),
('A05', 'Jhon', 'Hanumanth nagar');
INSERT INTO CAR (reg_num, model, year) VALUES
('KA052250', 'Indica', 1990),
('KA031181', 'Lancer', 1957),
('KA095477', 'Toyota', 1998),
('KA053408', 'Honda', 2008),
('KA041702', 'Audi', 2005);
INSERT INTO ACCIDENT (report_num, accident_date, location) VALUES
(11, '2003-01-01', 'Mysore Road'),
(12, '2004-02-02', 'South end Circle'),
(13, '2003-01-21', 'Bull temple Road'),
(14, '2008-02-17', 'Mysore Road'),
(15, '2004-03-05', 'Kanakpura Road');
INSERT INTO OWNS (driver_id, reg_num) VALUES
('A01', 'KA052250'),
('A02', 'KA031181'),
('A03', 'KA095477'),
('A04', 'KA053408'),
('A05', 'KA041702');
INSERT INTO PARTICIPATED (driver_id, reg_num, report_num, damage_amount) VALUES
('A01', 'KA052250', 11, 15000),
('A02', 'KA031181', 12, 25000),
('A03', 'KA095477', 13, 5000),
('A04', 'KA053408', 14, 10000),
('A05', 'KA041702', 15, 5000);

SELECT * FROM CAR ORDER BY year ASC;

SELECT COUNT(DISTINCT P.report_num)
FROM PARTICIPATED P
JOIN CAR C ON P.reg_num = C.reg_num
WHERE C.model = 'Lancer';

SELECT COUNT(DISTINCT T1.driver_id)
FROM PERSON T1
JOIN PARTICIPATED T2 ON T1.driver_id = T2.driver_id
JOIN ACCIDENT T3 ON T2.report_num = T3.report_num
WHERE T3.accident_date BETWEEN '2008-01-01' AND '2008-12-31';

SELECT * FROM PARTICIPATED ORDER BY damage_amount DESC;

SELECT AVG(damage_amount) FROM PARTICIPATED;

SELECT MAX(damage_amount) FROM PARTICIPATED;

DELETE FROM PARTICIPATED
WHERE damage_amount < (
    SELECT AVG(damage_amount)
    FROM PARTICIPATED
);

SELECT DISTINCT T1.name
FROM PERSON T1
JOIN PARTICIPATED T2 ON T1.driver_id = T2.driver_id
WHERE T2.damage_amount > (
    SELECT AVG(damage_amount)
    FROM PARTICIPATED
);

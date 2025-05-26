CREATE DATABASE zatx;
USE zatx;

-- Create ci_company table
CREATE TABLE ci_company (
    CompanyID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(45) NOT NULL
);

-- Create ci_operation table
CREATE TABLE ci_operation (
    Opcode VARCHAR(25) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Amount DECIMAL(15,2) CHECK (Amount > 0.00)
);

-- Create ci_customer table
CREATE TABLE ci_customer (
    CustID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45) NOT NULL
) AUTO_INCREMENT = 5001;

-- Create ci_TANK table
CREATE TABLE ci_TANK (
    TankID INT AUTO_INCREMENT PRIMARY KEY,
    TankType VARCHAR(1) CHECK (TankType IN ('L', 'M', 'S')),
    max_capacity DECIMAL(15,2),
    min_threshold DECIMAL(15,2),
    max_threshold DECIMAL(15,2),
    BalQty DECIMAL(15,2),
    Status VARCHAR(1) CHECK (Status IN ('F', 'C'))
) AUTO_INCREMENT = 9001;

-- Create ci_CONTRACT table
CREATE TABLE ci_CONTRACT (
    ContractID INT AUTO_INCREMENT PRIMARY KEY,
    CustID INT,
    TankID INT,
    StartDate DATE CHECK (StartDate >= '2024-11-01' AND StartDate <= '2025-03-31'),
    Duration INT,
    EndDate DATE,
    Status VARCHAR(1) DEFAULT 'A' CHECK (Status IN ('A', 'C')),
    FOREIGN KEY (CustID) REFERENCES ci_customer(CustID),
    FOREIGN KEY (TankID) REFERENCES ci_TANK(TankID)
) AUTO_INCREMENT = 7001;

-- Create ci_tankfill table
CREATE TABLE ci_tankfill (
    TXNID INT AUTO_INCREMENT PRIMARY KEY,
    TANKID INT,
    CustID INT,
    op_code VARCHAR(15) NOT NULL,
    trx_date DATE NOT NULL,
    ShipNo VARCHAR(15),
    Quantity DECIMAL(15,2) CHECK (Quantity > 0.00),
    Status VARCHAR(1) NOT NULL,
    FOREIGN KEY (TANKID) REFERENCES ci_TANK(TankID),
    FOREIGN KEY (CustID) REFERENCES ci_customer(CustID)
);

-- Create ci_truckload table
CREATE TABLE ci_truckload (
    TXNID INT AUTO_INCREMENT PRIMARY KEY,
    TANKID INT,
    CustID INT,
    opcode VARCHAR(15) NOT NULL,
    trx_date DATE NOT NULL,
    TruckNo VARCHAR(15) NOT NULL,
    entry_truck_wt DECIMAL(15,2),
    exit_truck_wt DECIMAL(15,2),
    net_wt DECIMAL(15,2),
    Status VARCHAR(1) DEFAULT 'A' NOT NULL,
    FOREIGN KEY (TANKID) REFERENCES ci_TANK(TankID),
    FOREIGN KEY (CustID) REFERENCES ci_customer(CustID)
);

-- Create ci_tranlog table
CREATE TABLE ci_tranlog (
    Txnid INT AUTO_INCREMENT PRIMARY KEY,
    Opcode VARCHAR(25) NOT NULL,
    CustID INT,
    TRX_DT DATE,
    trx_qty DECIMAL(15,2) CHECK (trx_qty > 0.00),
    FOREIGN KEY (CustID) REFERENCES ci_customer(CustID)
);

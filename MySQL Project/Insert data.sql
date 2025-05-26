-- Insert into ci_company
INSERT INTO ci_company (CompanyID, Name)
VALUES ('ZATX', 'ZATX Terminals');

-- Insert into ci_operation
INSERT INTO ci_operation (Opcode, Name, Amount) VALUES
('FILLTANK', 'Tank filling operation', 15.00),
('LOADTRUCK', 'Truck loading operation', 7.00),
('TRFTOTANK', 'Tank to tank transfer', 12.00),
('FLUSHPIPE', 'Pipe flushing operation', 5.50),
('CLEANTANK', 'Tank cleaning operation', 9.00),
('RENTAL', 'Tank rental charges', 15.00);

-- Insert into ci_customer
INSERT INTO ci_customer (Name) VALUES
('Dow Chemical Company'),
('ExxonMobil Chemical'),
('BASF'),
('Shell Chemicals'),
('Chevron Phillips Chemical'),
('LyondellBasell'),
('SABIC'),
('Ineos'),
('DuPont'),
('Air Liquide'),
('Linde'),
('Eastman Chemical Company'),
('Huntsman Corporation'),
('Solvay'),
('Sumitomo Chemical');

-- Insert into ci_TANK
INSERT INTO ci_TANK (TankType, max_capacity, min_threshold, max_threshold, BalQty, Status) VALUES
('S', 1000.00, 100.00, 950.00, 0.00, 'F'),
('S', 1200.00, 120.00, 1140.00, 0.00, 'C'),
('S', 1500.00, 150.00, 1425.00, 0.00, 'F'),
('L', 10000.00, 1000.00, 9500.00, 0.00, 'F'),
('L', 12000.00, 1200.00, 11400.00, 0.00, 'F'),
('L', 15000.00, 1500.00, 14250.00, 0.00, 'F'),
('L', 18000.00, 1800.00, 17100.00, 0.00, 'F'),
('M', 5000.00, 500.00, 4750.00, 0.00, 'F'),
('M', 6000.00, 600.00, 5700.00, 0.00, 'F'),
('M', 7500.00, 750.00, 7125.00, 0.00, 'F');

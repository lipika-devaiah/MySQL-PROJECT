-- List of All Tanks with Their Current Status and Balance
SELECT 
    TankID,
    TankType,
    max_capacity,
    min_threshold,
    max_threshold,
    BalQty AS current_balance,
    CASE 
        WHEN Status = 'F' THEN 'Free'
        WHEN Status = 'C' THEN 'Contracted'
        ELSE 'Unknown'
    END AS Status
FROM ci_TANK;

-- Active Contracts with Customer Details
SELECT 
    c.ContractID,
    cu.CustID,
    cu.Name AS CustomerName,
    t.TankID,
    t.TankType,
    c.StartDate,
    c.EndDate,
    c.Status
FROM ci_CONTRACT c
JOIN ci_customer cu ON c.CustID = cu.CustID
JOIN ci_TANK t ON c.TankID = t.TankID
WHERE c.Status = 'A';

-- Transaction History for a Specific Customer, Replace 5001 with the actual customer ID.
SELECT 
    tl.Txnid,
    tl.Opcode,
    c.Name AS CustomerName,
    tl.TRX_DT,
    tl.trx_qty
FROM ci_tranlog tl
JOIN ci_customer c ON tl.CustID = c.CustID
WHERE tl.CustID = 5001
ORDER BY tl.TRX_DT DESC;


-- Daily Summary of Tank Filling Operations
SELECT 
    trx_date,
    COUNT(*) AS fill_operations,
    SUM(Quantity) AS total_quantity_filled
FROM ci_tankfill
GROUP BY trx_date
ORDER BY trx_date DESC;

-- 




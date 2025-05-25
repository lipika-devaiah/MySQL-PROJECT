-- Report 1: List of all tanks with their current status and balance
SELECT 
    TankID,
    TankType,
    max_capacity,
    min_threshold,
    max_threshold,
    BalQty AS CurrentBalance,
    Status
FROM ci_TANK;

-- Report 2: Active contracts with customer details
SELECT 
    c.ContractID,
    cu.Name AS CustomerName,
    t.TankID,
    c.StartDate,
    c.EndDate,
    c.Status
FROM ci_CONTRACT c
JOIN ci_customer cu ON c.CustID = cu.CustID
JOIN ci_TANK t ON c.TankID = t.TankID
WHERE c.Status = 'A';

-- Report 3: Transaction history for a specific customer (replace 5001 with desired CustID)
SELECT 
    t.TXNID,
    t.Opcode,
    t.TRX_DT,
    t.trx_qty
FROM ci_tranlog t
WHERE t.CustID = 5001
ORDER BY t.TRX_DT DESC;

-- Report 4: Daily summary of tank filling operations
SELECT 
    trx_date,
    COUNT(*) AS FillCount,
    SUM(Quantity) AS TotalFilled
FROM ci_tankfill
GROUP BY trx_date
ORDER BY trx_date DESC;

-- Report 5: Daily summary of truck loading operations
SELECT 
    trx_date,
    COUNT(*) AS LoadCount,
    SUM(net_wt) AS TotalLoaded
FROM ci_truckload
WHERE exit_truck_wt IS NOT NULL
GROUP BY trx_date
ORDER BY trx_date DESC;





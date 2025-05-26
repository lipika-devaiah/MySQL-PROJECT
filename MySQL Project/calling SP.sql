
-- Purpose: Creates a new contract between customer and ZATX.
CALL add_new_contract(5001, 9001, '2024-11-15', 12);

-- Purpose: Records a tank fill from a ship for a given contract.
CALL fill_tank(9001, 5001, '2025-01-10', 'SHIP123', 500.00);

-- Purpose: Records truck entry (without product).
CALL entry_truck_weight(9001, 5001, '2025-01-15', 'TRUCK001', 8000.00);

-- Purpose: Completes truck load and records product loaded (net weight).
CALL fill_tank(9001, 5001, '2025-01-20', 'SHIP555', 300.00);


SELECT TankID, BalQty, max_threshold, (max_threshold - BalQty) AS Available_Capacity
FROM ci_TANK
WHERE TankID = 9001;




CALL add_new_contract(5001, 9001, '2024-11-15', 1);

CALL fill_tank(9001, 5001, '2024-11-16', 'SHIP-101', 800.00);
-- Insert into ci_tankfill
-- Update BalQty in ci_TANK
-- nsert into ci_tranlog via the upd_tank_bal trigger

-- Entry weight
CALL entry_truck_weight(9001, 5001, '2024-11-17', 'TRUCK-999', 5000.00);

SET SQL_SAFE_UPDATES = 0;

-- Exit weight
CALL exit_truck_weight('TRUCK-999', 5600.00);


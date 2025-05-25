-- update_tank_balance trigger where This trigger activates after an insert into the ci_tankfill table.
-- This trigger ensures:Real-time inventory updates in ci_TANK when a fill occurs
-- A corresponding transaction record in ci_tranlog

DELIMITER //

CREATE TRIGGER upd_tank_bal
AFTER INSERT ON ci_tankfill
FOR EACH ROW
BEGIN
    -- Update tank balance
    UPDATE ci_TANK
    SET BalQty = BalQty + NEW.Quantity
    WHERE TankID = NEW.TankID;

    -- Log the transaction
    INSERT INTO ci_tranlog (Opcode, CustID, TRX_DT, trx_qty)
    VALUES (NEW.op_code, NEW.CustID, NEW.trx_date, NEW.Quantity);
END;
//
DELIMITER ;

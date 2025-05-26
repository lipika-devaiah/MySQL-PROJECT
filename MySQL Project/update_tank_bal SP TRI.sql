DELIMITER $$

CREATE TRIGGER upd_tank_bal
AFTER INSERT ON ci_tankfill
FOR EACH ROW
BEGIN
    -- Update tank balance
    UPDATE ci_TANK
    SET BalQty = BalQty + NEW.Quantity
    WHERE TankID = NEW.TANKID;

    -- Log transaction
    INSERT INTO ci_tranlog (Opcode, CustID, TRX_DT, trx_qty)
    VALUES ('FILLTANK', NEW.CustID, NEW.trx_date, NEW.Quantity);
END$$

DELIMITER ;

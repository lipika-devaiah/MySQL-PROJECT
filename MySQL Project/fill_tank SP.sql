DELIMITER $$

CREATE PROCEDURE fill_tank (
    IN v_tankid INT,
    IN v_custid INT,
    IN v_trxdate DATE,
    IN v_shipno VARCHAR(15),
    IN v_quantity DECIMAL(15,2)
)
BEGIN
    DECLARE v_count INT;
    DECLARE v_capacity DECIMAL(15,2);
    DECLARE v_max_threshold DECIMAL(15,2);
    DECLARE v_balance DECIMAL(15,2);

    -- Validate contract exists
    SELECT COUNT(*) INTO v_count FROM ci_CONTRACT
    WHERE TankID = v_tankid AND CustID = v_custid AND Status = 'A' AND v_trxdate >= StartDate;
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No active contract found';
    END IF;

    -- Validate date
    IF v_trxdate > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction date cannot be in future';
    END IF;

    -- Validate ship number
    IF v_shipno IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ship number cannot be null';
    END IF;

    -- Check quantity limit
    SELECT max_threshold, BalQty INTO v_max_threshold, v_balance FROM ci_TANK WHERE TankID = v_tankid;
    IF (v_balance + v_quantity) > v_max_threshold THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exceeds max threshold';
    END IF;

    -- Insert record
    INSERT INTO ci_tankfill (TankID, CustID, op_code, trx_date, ShipNo, Quantity, Status)
    VALUES (v_tankid, v_custid, 'FILLTANK', v_trxdate, v_shipno, v_quantity, 'A');
END$$

DELIMITER ;

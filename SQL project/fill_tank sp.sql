-- fill_tank store procedure

DELIMITER //

CREATE PROCEDURE fill_tank (
    IN v_tankid INT,
    IN v_custid INT,
    IN v_trxdate DATE,
    IN v_shipno VARCHAR(15),
    IN v_quantity DECIMAL(15,2)
)
BEGIN
    DECLARE v_startdate DATE;
    DECLARE v_max DECIMAL(15,2);
    DECLARE v_balance DECIMAL(15,2);

    -- Verify active contract
    SELECT StartDate INTO v_startdate
    FROM ci_CONTRACT
    WHERE TankID = v_tankid AND CustID = v_custid AND Status = 'A'
    LIMIT 1;

    IF v_startdate IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No active contract';
    END IF;

    -- Validate transaction date
    IF v_trxdate < v_startdate OR v_trxdate > CURRENT_DATE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid transaction date';
    END IF;

    -- Validate ship number
    IF v_shipno IS NULL OR LENGTH(TRIM(v_shipno)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ship number is required';
    END IF;

    -- Check tank capacity
    SELECT max_threshold, BalQty INTO v_max, v_balance
    FROM ci_TANK WHERE TankID = v_tankid;

    IF v_balance + v_quantity > v_max THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity exceeds threshold';
    END IF;

    -- Insert tank fill record
    INSERT INTO ci_tankfill (TankID, CustID, op_code, trx_date, ShipNo, Quantity, Status)
    VALUES (v_tankid, v_custid, 'FILLTANK', v_trxdate, v_shipno, v_quantity, 'A');
END;
//
DELIMITER ;

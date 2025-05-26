DELIMITER $$

CREATE PROCEDURE entry_truck_weight (
    IN v_tankid INT,
    IN v_custid INT,
    IN v_trxdate DATE,
    IN v_truckno VARCHAR(15),
    IN v_entrywt DECIMAL(15,2)
)
BEGIN
    DECLARE v_count INT;

    -- Validate contract
    SELECT COUNT(*) INTO v_count FROM ci_CONTRACT
    WHERE CustID = v_custid AND TankID = v_tankid AND Status = 'A';
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No active contract found';
    END IF;

    -- Validate date
    IF v_trxdate > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid transaction date';
    END IF;

    -- Validate truck number
    IF v_truckno IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Truck number required';
    END IF;

    -- Validate entry weight
    IF v_entrywt <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid entry weight';
    END IF;

    -- Check for duplicate
    SELECT COUNT(*) INTO v_count FROM ci_truckload
    WHERE TruckNo = v_truckno AND exit_truck_wt IS NULL;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Truck already in yard';
    END IF;

    -- Insert record
    INSERT INTO ci_truckload (TANKID, CustID, opcode, trx_date, TruckNo, entry_truck_wt, Status)
    VALUES (v_tankid, v_custid, 'LOADTRUCK', v_trxdate, v_truckno, v_entrywt, 'A');
END$$

DELIMITER ;

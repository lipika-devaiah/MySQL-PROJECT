-- entry_truck store procedure

DELIMITER //

CREATE PROCEDURE entry_truck_weight (
    IN v_tankid INT,
    IN v_custid INT,
    IN v_trxdate DATE,
    IN v_truckno VARCHAR(15),
    IN v_entrywt DECIMAL(15,2)
)
BEGIN
    -- Validations
    IF NOT EXISTS (
        SELECT 1 FROM ci_CONTRACT
        WHERE TankID = v_tankid AND CustID = v_custid AND Status = 'A'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No active contract for this tank and customer';
    END IF;

    IF v_entrywt <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Entry weight must be > 0';
    END IF;

    IF EXISTS (
        SELECT 1 FROM ci_truckload
        WHERE TruckNo = v_truckno AND exit_truck_wt IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Truck has pending entry';
    END IF;

    -- Insert truck load entry
    INSERT INTO ci_truckload (TankID, CustID, opcode, trx_date, TruckNo, entry_truck_wt)
    VALUES (v_tankid, v_custid, 'LOADTRUCK', v_trxdate, v_truckno, v_entrywt);
END;
//
DELIMITER ;

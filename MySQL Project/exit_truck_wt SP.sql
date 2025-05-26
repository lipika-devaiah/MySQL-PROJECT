DELIMITER $$

CREATE PROCEDURE exit_truck_weight (
    IN v_truckno VARCHAR(15),
    IN v_exitwt DECIMAL(15,2)
)
BEGIN
    DECLARE v_entrywt DECIMAL(15,2);
    DECLARE v_netwt DECIMAL(15,2);
    DECLARE v_tankid INT;
    DECLARE v_custid INT;
    DECLARE v_trxdate DATE;
    DECLARE v_balance DECIMAL(15,2);

    -- Find pending entry
    SELECT entry_truck_wt, TankID, CustID, trx_date INTO v_entrywt, v_tankid, v_custid, v_trxdate
    FROM ci_truckload
    WHERE TruckNo = v_truckno AND exit_truck_wt IS NULL
    LIMIT 1;

    IF v_entrywt IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No pending truck found';
    END IF;

    -- Validate exit weight
    IF v_exitwt <= v_entrywt THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exit weight must be greater than entry weight';
    END IF;

    -- Calculate net weight
    SET v_netwt = v_exitwt - v_entrywt;

    -- Check tank balance
    SELECT BalQty INTO v_balance FROM ci_TANK WHERE TankID = v_tankid;
    IF v_netwt > v_balance THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient tank balance';
    END IF;

    -- Update truckload
    UPDATE ci_truckload
    SET exit_truck_wt = v_exitwt,
        net_wt = v_netwt
    WHERE TruckNo = v_truckno AND exit_truck_wt IS NULL;

    -- Update tank balance
    UPDATE ci_TANK
    SET BalQty = BalQty - v_netwt
    WHERE TankID = v_tankid;

    -- Log transaction
    INSERT INTO ci_tranlog (Opcode, CustID, TRX_DT, trx_qty)
    VALUES ('LOADTRUCK', v_custid, v_trxdate, v_netwt);
END$$

DELIMITER ;

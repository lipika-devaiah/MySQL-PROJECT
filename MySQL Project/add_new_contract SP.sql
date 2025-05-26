DELIMITER $$

CREATE PROCEDURE add_new_contract (
    IN v_custid INT,
    IN v_tankid INT,
    IN v_startdate DATE,
    IN v_duration INT
)
BEGIN
    DECLARE v_count INT;
    DECLARE v_enddate DATE;

    -- Check if customer exists
    SELECT COUNT(*) INTO v_count FROM ci_customer WHERE CustID = v_custid;
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer not found';
    END IF;

    -- Check if tank exists and is free
    SELECT COUNT(*) INTO v_count FROM ci_TANK WHERE TankID = v_tankid AND Status = 'F';
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tank is not available or does not exist';
    END IF;

    -- Check start date
    IF v_startdate < '2024-11-01' OR v_startdate > '2025-03-31' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Start date not within valid range';
    END IF;

    -- Compute end date
    SET v_enddate = DATE_ADD(v_startdate, INTERVAL v_duration MONTH);

    -- Insert contract
    INSERT INTO ci_CONTRACT (CustID, TankID, StartDate, Duration, EndDate, Status)
    VALUES (v_custid, v_tankid, v_startdate, v_duration, v_enddate, 'A');

    -- Update tank status
    UPDATE ci_TANK SET Status = 'C' WHERE TankID = v_tankid;
END$$

DELIMITER ;

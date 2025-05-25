-- add_new_contract stored procedure
DELIMITER //

CREATE PROCEDURE add_new_contract (
    IN v_custid INT,
    IN v_tankid INT,
    IN v_startdate DATE,
    IN v_duration INT
)
BEGIN
    DECLARE v_enddate DATE;
    DECLARE tank_status VARCHAR(1);

    -- Validate Customer
    IF NOT EXISTS (SELECT 1 FROM ci_customer WHERE CustID = v_custid) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer does not exist';
    END IF;

    -- Validate Tank
    SELECT Status INTO tank_status FROM ci_TANK WHERE TankID = v_tankid;
    IF tank_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tank does not exist';
    ELSEIF tank_status != 'F' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tank is not free';
    END IF;

    -- Validate Start Date
    IF v_startdate NOT BETWEEN '2024-11-01' AND '2025-03-31' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Start date not in allowed range';
    END IF;

    -- Compute End Date
    SET v_enddate = DATE_ADD(v_startdate, INTERVAL v_duration YEAR);

    -- Insert Contract
    INSERT INTO ci_CONTRACT (CustID, TankID, StartDate, Duration, EndDate, Status)
    VALUES (v_custid, v_tankid, v_startdate, v_duration, v_enddate, 'A');

    -- Update Tank Status
    UPDATE ci_TANK SET Status = 'C' WHERE TankID = v_tankid;
END;
//
DELIMITER ;

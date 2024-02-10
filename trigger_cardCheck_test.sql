DELIMITER //
CREATE TRIGGER checkCard AFTER INSERT ON Orders FOR EACH ROW
BEGIN
SET @cardDeets = (SELECT users.CardNum FROM Users WHERE User_ID = new.User_ID);
IF @cardDeets IS NULL THEN
DELETE FROM Orders WHERE OrderID = NEW.OrderID;
END IF;
END//
DELIMITER ;
-- _____           _       _ _          _     _      
--/  ___|         (_)     | (_)        | |   | |     
--\ `--.  ___ _ __ _  __ _| |_ ______ _| |__ | | ___ 
-- `--. \/ _ \ '__| |/ _` | | |_  / _` | '_ \| |/ _ \
--/\__/ /  __/ |  | | (_| | | |/ / (_| | |_) | |  __/
--\____/ \___|_|  |_|\__,_|_|_/___\__,_|_.__/|_|\___|
                                                   
--	Specifies the following conditions:
--    Statements can't read data that was modified but not yet committed by other transactions.
--    No other transactions can modify data that was read by the current transaction until the current transaction completes.
--    Other transactions can't insert new rows with key values that would fall in the range of keys read by any statements in the current transaction   until the current transaction completes.

-- The original state of the data
BEGIN TRAN
	UPDATE  LinkTypes
	SET     Type = 'Linked'
	WHERE   Id = 1;

	DELETE FROM LinkTypes
	WHERE Type = '👻';
COMMIT;

-- The Serializable isolation level ensures concurrent transactions are treated as if they had been run in serial.
-- Performance loss - concurent transactions are queued.❗
BEGIN TRAN
	INSERT INTO LinkTypes
	VALUES ('👻');
COMMIT;
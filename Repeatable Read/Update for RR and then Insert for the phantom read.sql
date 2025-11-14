--______                      _        _     _       ______               _ 
--| ___ \                    | |      | |   | |      | ___ \             | |
--| |_/ /___ _ __   ___  __ _| |_ __ _| |__ | | ___  | |_/ /___  __ _  __| |
--|    // _ \ '_ \ / _ \/ _` | __/ _` | '_ \| |/ _ \ |    // _ \/ _` |/ _` |
--| |\ \  __/ |_) |  __/ (_| | || (_| | |_) | |  __/ | |\ \  __/ (_| | (_| |
--\_| \_\___| .__/ \___|\__,_|\__\__,_|_.__/|_|\___| \_| \_\___|\__,_|\__,_|
--          | |                                                             
--          |_|                                                             

--	Specifies that statements can't read data that was modified but not yet committed by other transactions, and that no other transactions can modify data that was read by the current transaction until the current transaction completes.

-- The original state of the data
BEGIN TRAN
	UPDATE  LinkTypes
	SET     Type = 'Linked'
	WHERE   Id = 1;

	DELETE FROM LinkTypes
	WHERE Type = '👻';
COMMIT;

-- There will be a dirty read on the RC isolation level, and not on the RR.
BEGIN TRAN
	UPDATE  LinkTypes
	SET     Type = 'Dirty read!'
	WHERE   Id = 1;
COMMIT;

-- The spooky phantom read because data that matches the criteria can be inserted and the lock is shared.
BEGIN TRAN
	INSERT INTO LinkTypes
	VALUES ('👻');
COMMIT;
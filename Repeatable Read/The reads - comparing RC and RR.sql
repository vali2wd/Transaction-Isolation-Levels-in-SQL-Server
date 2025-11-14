--______                      _        _     _       ______               _ 
--| ___ \                    | |      | |   | |      | ___ \             | |
--| |_/ /___ _ __   ___  __ _| |_ __ _| |__ | | ___  | |_/ /___  __ _  __| |
--|    // _ \ '_ \ / _ \/ _` | __/ _` | '_ \| |/ _ \ |    // _ \/ _` |/ _` |
--| |\ \  __/ |_) |  __/ (_| | || (_| | |_) | |  __/ | |\ \  __/ (_| | (_| |
--\_| \_\___| .__/ \___|\__,_|\__\__,_|_.__/|_|\___| \_| \_\___|\__,_|\__,_|
--          | |                                                             
--          |_|                                                             

--	Specifies that statements can't read data that was modified but not yet committed by other transactions, and that no other transactions can modify data that was read by the current transaction until the current transaction completes.

-- Read Commited, midway transaction the Type is changing. WRONG use case!
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
SET NOCOUNT ON
GO
BEGIN TRAN
	SELECT  *
	FROM    LinkTypes 
	WHERE   Id = 1
WAITFOR DELAY '00:00:10'
	SELECT  *
	FROM    LinkTypes 
	WHERE   Id = 1
COMMIT;

-- Repeatable Read. Shared lock is issued, so the update is done only after the below transaction! This is also the reason why the Update transaction is blocked (the 10s).
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
SET NOCOUNT ON
GO
BEGIN TRAN
	SELECT  *
	FROM    LinkTypes 
	WHERE   Id = 1
WAITFOR DELAY '00:00:10'
	SELECT  *
	FROM    LinkTypes 
	WHERE   Id = 1
COMMIT;

-- Repeatable Read, but other transactions can insert data, this becomes a PHANTOM READ.
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
SET NOCOUNT ON
GO
BEGIN TRAN
	SELECT  *
	FROM    LinkTypes 
WAITFOR DELAY '00:00:10'
	SELECT  *
	FROM    LinkTypes 
COMMIT;
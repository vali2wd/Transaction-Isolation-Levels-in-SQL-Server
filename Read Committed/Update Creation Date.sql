--______               _   _____                           _ _   _           _ 
--| ___ \             | | /  __ \                         (_) | | |         | |
--| |_/ /___  __ _  __| | | /  \/ ___  _ __ ___  _ __ ___  _| |_| |_ ___  __| |
--|    // _ \/ _` |/ _` | | |    / _ \| '_ ` _ \| '_ ` _ \| | __| __/ _ \/ _` |
--| |\ \  __/ (_| | (_| | | \__/\ (_) | | | | | | | | | | | | |_| ||  __/ (_| |
--\_| \_\___|\__,_|\__,_|  \____/\___/|_| |_| |_|_| |_| |_|_|\__|\__\___|\__,_|

--	Specifies that statements can't read data that was modified but not committed by other transactions. This prevents dirty reads. Data can be changed by other transactions between individual statements within the current transaction, resulting in nonrepeatable reads or phantom data. This option is the SQL Server default.

--Comes in 2 flavours as shown:

--1. READ COMMITED isolation with locking
ALTER DATABASE StackOverflow2010 SET READ_COMMITTED_SNAPSHOT ON
GO
BEGIN TRAN
	UPDATE Comments
	SET CreationDate = DATEADD(YEAR, 1, CreationDate)
	WHERE UserId = 3 AND PostId = 35314;
ROLLBACK;

--2. READ COMMITTED with snapshot isolation
ALTER DATABASE StackOverflow2010 SET READ_COMMITTED_SNAPSHOT ON
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
	UPDATE Comments
	SET CreationDate = DATEADD(YEAR, 1, CreationDate)
	WHERE UserId = 3 AND PostId = 35314;
ROLLBACK;
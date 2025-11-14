-- _____                       _           _     _____          _       _   _             
--/  ___|                     | |         | |   |_   _|        | |     | | (_)            
--\ `--. _ __   __ _ _ __  ___| |__   ___ | |_    | | ___  ___ | | __ _| |_ _  ___  _ __  
-- `--. \ '_ \ / _` | '_ \/ __| '_ \ / _ \| __|   | |/ __|/ _ \| |/ _` | __| |/ _ \| '_ \ 
--/\__/ / | | | (_| | |_) \__ \ | | | (_) | |_   _| |\__ \ (_) | | (_| | |_| | (_) | | | |
--\____/|_| |_|\__,_| .__/|___/_| |_|\___/ \__|  \___/___/\___/|_|\__,_|\__|_|\___/|_| |_|
--                  | |                                                                   
--                  |_|                                                                 

-- Specifies that data read by any statement in a transaction is the transactionally consistent version of the data that existed at the start of the transaction. The transaction can only recognize data modifications that were committed before the start of the transaction. Data modifications made by other transactions after the start of the current transaction aren't visible to statements executing in the current transaction. The effect is as if the statements in a transaction get a snapshot of the committed data as it existed at the start of the transaction.

ALTER DATABASE StackOverflow2010 SET ALLOW_SNAPSHOT_ISOLATION ON;

SET TRANSACTION ISOLATION LEVEL SNAPSHOT
SET NOCOUNT ON
GO
BEGIN TRAN
	UPDATE  dbo.Comments
	SET Text = 'No dirty read! (Yet 😉). The effect is that the transaction gets a snapshot of the committed data at the TRAN beginning.'
	WHERE   Id = 35314;
ROLLBACK;
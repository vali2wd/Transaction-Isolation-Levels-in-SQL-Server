-- ______ _____  ___ ______   _   _ _   _ _____ ________  ______  ________ _____ ___________ 
-- | ___ \  ___|/ _ \|  _  \ | | | | \ | /  __ \  _  |  \/  ||  \/  |_   _|_   _|  ___|  _  \
-- | |_/ / |__ / /_\ \ | | | | | | |  \| | /  \/ | | | .  . || .  . | | |   | | | |__ | | | |
-- |    /|  __||  _  | | | | | | | | . ` | |   | | | | |\/| || |\/| | | |   | | |  __|| | | |
-- | |\ \| |___| | | | |/ /  | |_| | |\  | \__/\ \_/ / |  | || |  | |_| |_  | | | |___| |/ / 
-- \_| \_\____/\_| |_/___/    \___/\_| \_/\____/\___/\_|  |_/\_|  |_/\___/  \_/ \____/|___/  

-- Transactions running at the READ UNCOMMITTED level don't issue shared locks to prevent other transactions from modifying data read by the current transaction. READ UNCOMMITTED transactions are also not blocked by exclusive locks that would prevent the current transaction from reading rows that were modified but not committed by other transactions.     
 
 ALTER DATABASE StackOverflow2010 SET READ_COMMITTED_SNAPSHOT ON;


-- Provoke a dirty read.
BEGIN TRAN
	UPDATE dbo.Posts
	SET Body = '[The dirty read!]'
	WHERE Id IN (
		927378,
		927386,
		927397,
		3377569
	);
-- Please read the Ids and do not rollback as of yet. 
-- The dirty read should be noticeable when you run the next query, as the Score becomes -1, yet when we rollback the transaction, we get a different reading.
ROLLBACK;

-- IMPORTANT: observe the transactions using the helper script.
-- Read the answers from the post that has the most upvoted answer ever.
SELECT 
	p.*
FROM dbo.Posts AS p WITH (INDEX = PK_Posts__Id)
WHERE p.ParentId = 
(
	SELECT TOP(1)
		p2.ParentId
	FROM dbo.Posts AS p2
	WHERE p2.PostTypeId = 2
	ORDER BY
		p2.Score DESC,
		p2.Id DESC
)
OPTION(MAXDOP 1);
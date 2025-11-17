-- ______ _____  ___ ______   _   _ _   _ _____ ________  ______  ________ _____ ___________ 
-- | ___ \  ___|/ _ \|  _  \ | | | | \ | /  __ \  _  |  \/  ||  \/  |_   _|_   _|  ___|  _  \
-- | |_/ / |__ / /_\ \ | | | | | | |  \| | /  \/ | | | .  . || .  . | | |   | | | |__ | | | |
-- |    /|  __||  _  | | | | | | | | . ` | |   | | | | |\/| || |\/| | | |   | | |  __|| | | |
-- | |\ \| |___| | | | |/ /  | |_| | |\  | \__/\ \_/ / |  | || |  | |_| |_  | | | |___| |/ / 
-- \_| \_\____/\_| |_/___/    \___/\_| \_/\____/\___/\_|  |_/\_|  |_/\___/  \_/ \____/|___/  

 -- Transactions running at the READ UNCOMMITTED level don't issue shared locks to prevent other transactions from modifying data read by the current transaction. READ UNCOMMITTED transactions are also not blocked by exclusive locks that would prevent the current transaction from reading rows that were modified but not committed by other transactions. 

-- Tidy workspace first.
IF @@TRANCOUNT > 0
BEGIN 
	SELECT 
		tc = @@TRANCOUNT;
	ROLLBACK;
END;

-- Add a millisecond to a post's date.
BEGIN TRANSACTION;
	UPDATE p
	SET p.LastActivityDate = DATEADD(MILLISECOND, 1, p.LastActivityDate)
	FROM dbo.Posts AS p
	WHERE p.Id = 927386;
ROLLBACK;
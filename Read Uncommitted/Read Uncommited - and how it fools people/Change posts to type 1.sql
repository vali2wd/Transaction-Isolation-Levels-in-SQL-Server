-- ______ _____  ___ ______   _   _ _   _ _____ ________  ______  ________ _____ ___________ 
-- | ___ \  ___|/ _ \|  _  \ | | | | \ | /  __ \  _  |  \/  ||  \/  |_   _|_   _|  ___|  _  \
-- | |_/ / |__ / /_\ \ | | | | | | |  \| | /  \/ | | | .  . || .  . | | |   | | | |__ | | | |
-- |    /|  __||  _  | | | | | | | | . ` | |   | | | | |\/| || |\/| | | |   | | |  __|| | | |
-- | |\ \| |___| | | | |/ /  | |_| | |\  | \__/\ \_/ / |  | || |  | |_| |_  | | | |___| |/ / 
-- \_| \_\____/\_| |_/___/    \___/\_| \_/\____/\___/\_|  |_/\_|  |_/\___/  \_/ \____/|___/  

 -- Transactions running at the READ UNCOMMITTED level don't issue shared locks to prevent other transactions from modifying data read by the current transaction. READ UNCOMMITTED transactions are also not blocked by exclusive locks that would prevent the current transaction from reading rows that were modified but not committed by other transactions.     
 
-- Provoke a dirty read.
UPDATE p
SET p.PostTypeId = 1
FROM dbo.Posts p
WHERE p.Id IN (
	927378,
	927386,
	927397,
	3377569);

-- IMPORTANT.
-- Use this to update demo posts to back to type 2.
UPDATE p
SET p.PostTypeId = 2
FROM dbo.Posts p
WHERE p.Id IN (
		927378,
		927386,
		927397,
		3377569
);

-- Read the rows.
SELECT p.Id, p.PostTypeId
FROM dbo.Posts p
WHERE p.Id IN (
	927378,
	927386,
	927397,
	3377569);
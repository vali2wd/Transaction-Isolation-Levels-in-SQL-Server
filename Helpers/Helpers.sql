--Cancel all ongoing transactions.
IF @@TRANCOUNT > 0
BEGIN 
	SELECT 
		tc = @@TRANCOUNT;
	ROLLBACK;
END;

--Please follow http://whoisactive.com/docs/04_installation/
EXEC dbo.sp_WhoIsActive
	@get_plans = 1,
	@get_locks = 1;
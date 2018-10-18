CREATE TRIGGER EmailSchedule_After_Update ON EmailSchedule AFTER UPDATE
AS
	BEGIN
		DECLARE @V_TABLE varchar(10)
   
		SET @V_TABLE = 'EmailSchedule'
		
		INSERT INTO ChangeLog(
			LOG_TABLE,
			TABLE_KEY,
			LOG_DTTM,
			LOG_DATA)
		SELECT
			@V_TABLE,
			d.SCHEDULE_KEY,
			CURRENT_TIMESTAMP,
			CASE 
				WHEN COALESCE(i.ACCOUNTDATA_KEY,0) <> COALESCE(d.ACCOUNTDATA_KEY,0) 
				THEN 'Old Account Key: ' + COALESCE(CAST(d.ACCOUNTDATA_KEY as varchar(30)),'*NULL*') + ', New Account Key: ' + COALESCE(CAST(i.ACCOUNTDATA_KEY as varchar(30)),'*NULL*') + '  ' ELSE '' END
			+ CASE 
				WHEN COALESCE(i.RECORD_STATUS,'') <> COALESCE(d.RECORD_STATUS,'') 
				THEN 'Old Record Status: ' + COALESCE(d.RECORD_STATUS,'*NULL*') + ', New Record Status: ' + COALESCE(i.RECORD_STATUS,'*NULL*') + '  ' ELSE '' END
			+ CASE 
				WHEN COALESCE(CONVERT(varchar(20),i.SCHEDULED_TIME,8),'') <> COALESCE(CONVERT(varchar(20),d.SCHEDULED_TIME,8),'') 
				THEN 'Old Scheduled Time: ' + COALESCE(CONVERT(varchar(20),d.SCHEDULED_TIME,8),'*NULL*') + ', New Scheduled Time: ' + COALESCE(CONVERT(varchar(20),i.SCHEDULED_TIME,8),'*NULL*') + '  ' ELSE '' END
			+ CASE 
				WHEN COALESCE(CONVERT(varchar(30),i.RECURS_UNTIL_DTTM,21),'') <> COALESCE(CONVERT(varchar(30),d.RECURS_UNTIL_DTTM,21),'') 
				THEN 'Old Recurs Until Datetime: ' + COALESCE(CONVERT(varchar(30),d.RECURS_UNTIL_DTTM,21),'*NULL*') + ', New Recurs Until Datetime: ' + COALESCE(CONVERT(varchar(30),i.RECURS_UNTIL_DTTM,21),'*NULL*') + '  ' ELSE '' END
			+ CASE 
				WHEN COALESCE(i.RUN_INTERVAL,'') <> COALESCE(d.RUN_INTERVAL,'') 
				THEN 'Old Run Interval: ' + COALESCE(d.RUN_INTERVAL,'*NULL*') + ', New Run Interval: ' + COALESCE(i.RUN_INTERVAL,'*NULL*') + '  ' ELSE '' END
			+ CASE 
				WHEN COALESCE(i.INTERVAL_VALUE,0) <> COALESCE(d.INTERVAL_VALUE,0) 
				THEN 'Old Interval Value: ' + COALESCE(CAST(d.INTERVAL_VALUE as varchar(30)),'*NULL*') + ', New Interval Value: ' + COALESCE(CAST(i.INTERVAL_VALUE as varchar(30)),'*NULL*') + '  ' ELSE '' END
			+ CASE 
				WHEN COALESCE(i.DAY_SELECT,'') <> COALESCE(d.DAY_SELECT,'') 
				THEN 'Old Day Select: ' + COALESCE(d.DAY_SELECT,'*NULL*') + ', New Day Select: ' + COALESCE(i.DAY_SELECT,'*NULL*') + '  ' ELSE '' END
			+ CASE 
				WHEN COALESCE(i.EMAIL_MESSAGE,'') <> COALESCE(d.EMAIL_MESSAGE,'') 
				THEN 'Old Email Message: ' + COALESCE(d.EMAIL_MESSAGE,'*NULL*') + ', New Email Message: ' + COALESCE(i.EMAIL_MESSAGE,'*NULL*') + '  ' ELSE '' END
		FROM Inserted i Join Deleted d on i.SCHEDULE_KEY = d.SCHEDULE_KEY
		WHERE 
			i.ACCOUNTDATA_KEY <> d.ACCOUNTDATA_KEY
			or i.RECORD_STATUS <> d.RECORD_STATUS
			or COALESCE(CONVERT(varchar(20),i.SCHEDULED_TIME,8),'') <> COALESCE(CONVERT(varchar(20),d.SCHEDULED_TIME,8),'')
			or COALESCE(CONVERT(varchar(30),i.RECURS_UNTIL_DTTM,21),'') <> COALESCE(CONVERT(varchar(30),d.RECURS_UNTIL_DTTM,21),'')
			or i.RUN_INTERVAL <> d.RUN_INTERVAL
			or i.INTERVAL_VALUE <> d.INTERVAL_VALUE
			or i.DAY_SELECT <> d.DAY_SELECT
			or i.EMAIL_MESSAGE <> d.EMAIL_MESSAGE
	END
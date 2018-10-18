Insert into AccountData (EMAIL_ADDRESS, LOGIN_SECRET, LOGIN_SALT) Values ('test@test.com', 'asdasdasdasdad', '23faef3aef3adf3afafe');
Insert into AccountData (EMAIL_ADDRESS, LOGIN_SECRET, LOGIN_SALT) Values ('test2@test.com', 'asdasdasdsdfasdad', '23faesfasd3aef3adf3afafe');
Insert into EmailSchedule (ACCOUNTDATA_KEY, RECORD_STATUS, SCHEDULED_TIME, RUN_INTERVAL, INTERVAL_VALUE, DAY_SELECT, EMAIL_MESSAGE) Values ((Select Min(ACCOUNTDATA_KEY) From AccountData), 'A', '18:00:00', 'DAY', 1, 'YYYYYYY', 'Test Email Body');

--Test logging
Update EmailSchedule Set ACCOUNTDATA_KEY = (Select Max(ACCOUNTDATA_KEY) From AccountData) Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test@test.com')
Update EmailSchedule Set RECORD_STATUS = 'I' Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test2@test.com')
Update EmailSchedule Set SCHEDULED_TIME = '16:00:00' Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test2@test.com')
Update EmailSchedule Set RECURS_UNTIL_DTTM = '2020-01-01 00:00:00' Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test2@test.com')
Update EmailSchedule Set RUN_INTERVAL = 'WEEK' Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test2@test.com')
Update EmailSchedule Set INTERVAL_VALUE = 2 Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test2@test.com')
Update EmailSchedule Set DAY_SELECT = 'NYYYYYN' Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test2@test.com')
Update EmailSchedule Set EMAIL_MESSAGE = 'Email Body Test Change' Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test2@test.com')
Update EmailSchedule Set 
	ACCOUNTDATA_KEY = (Select Min(ACCOUNTDATA_KEY) From AccountData), 
	RECORD_STATUS = 'A', 
	SCHEDULED_TIME = '18:00:00',
	RECURS_UNTIL_DTTM = null,
	RUN_INTERVAL = 'DAY',
	INTERVAL_VALUE = 1,
	DAY_SELECT = 'YYYYYYY',
	EMAIL_MESSAGE = 'Test Email Body' 
Where ACCOUNTDATA_KEY = (Select ACCOUNTDATA_KEY From AccountData Where EMAIL_ADDRESS = 'test2@test.com')
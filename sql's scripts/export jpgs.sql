DECLARE CURSOR_PersonIds CURSOR FOR (SELECT TOP (10)  nCode FROM [dbo].[Person]  where Photo is not null)

DECLARE @PhotoId numeric;
DECLARE @PersonId numeric;

OPEN CURSOR_PersonIds

FETCH NEXT FROM CURSOR_PersonIds INTO @PersonId
WHILE (@@FETCH_STATUS <> -1)
BEGIN
  DECLARE @ImageData varbinary(max);
  SELECT @ImageData = (SELECT convert(varbinary(max), Photo, 1) FROM [dbo].[Person] where nCode = @PersonId );

  DECLARE @Path nvarchar(1024);
  SELECT @Path = 'C:\SqlExport';

  DECLARE @Filename VARCHAR(max);
  SELECT @Filename = (SELECT PersonFullName FROM [dbo].[Person] where nCode = @PersonId);

  DECLARE @FullPathToOutputFile NVARCHAR(2048);
  SELECT @FullPathToOutputFile = @Path + '\' + @Filename+'.jpg';

  DECLARE @ObjectToken INT
  EXEC sp_OACreate 'ADODB.Stream', @ObjectToken OUTPUT;
  EXEC sp_OASetProperty @ObjectToken, 'Type', 1;
  EXEC sp_OAMethod @ObjectToken, 'Open';
  EXEC sp_OAMethod @ObjectToken, 'Write', NULL, @ImageData;
  EXEC sp_OAMethod @ObjectToken, 'SaveToFile', NULL, @FullPathToOutputFile, 2;
  EXEC sp_OAMethod @ObjectToken, 'Close';
  EXEC sp_OADestroy @ObjectToken;

  FETCH NEXT FROM CURSOR_PersonIds INTO @PersonId
END
CLOSE CURSOR_PersonIds
DEALLOCATE CURSOR_PersonIds
go
-- Make sure the following statement is executed to enable file IO
-- From http://msdn.microsoft.com/en-us/library/ms191188.aspx
--------- --------- --------- --------- --------- --------- --------- 
--sp_configure 'show advanced options', 1;
--GO
--RECONFIGURE;
--GO
--sp_configure 'Ole Automation Procedures', 1;
--GO
--RECONFIGURE;
--GO
--EXEC sp_configure 'Ole Automation Procedures'; 
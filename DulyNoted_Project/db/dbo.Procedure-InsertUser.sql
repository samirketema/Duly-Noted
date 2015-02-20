CREATE PROCEDURE [dbo].[Insert_User]
      
      @email NCHAR(75),
      @password NCHAR(255),
      @firstName NCHAR(75),
      @lastName NCHAR(75),
      @displayName NCHAR(75)
AS
BEGIN
      SET NOCOUNT ON;
      IF EXISTS(SELECT userId FROM Users WHERE displayName = @displayName)
      BEGIN
            SELECT -1 -- displayName exists.
      END
      ELSE IF EXISTS(SELECT userId FROM Users WHERE email = @email)
      BEGIN
            SELECT -2 -- Email exists.
      END
      ELSE
      BEGIN
            INSERT INTO [Users]
                     ([email]
                     ,[password]
                     ,[firstName]
                     ,[lastName]
                     ,[displayName]
                     ,[banned]
                     ,[createdDate])
            VALUES
                     (@email
                     ,@password
                     ,@firstName
                     ,@lastName
                     ,@displayName
                     ,0
                     ,GETDATE())
           
            SELECT SCOPE_IDENTITY() -- userId                 
     END
END


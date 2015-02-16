CREATE PROCEDURE [dbo].[Insert_User]
      @Username NVARCHAR(20),
      @Password NVARCHAR(20),
      @Email NVARCHAR(30)
AS
BEGIN
      SET NOCOUNT ON;
      IF EXISTS(SELECT UserId FROM Users WHERE Username = @Username)
      BEGIN
            SELECT -1 -- Username exists.
      END
      ELSE IF EXISTS(SELECT UserId FROM Users WHERE Email = @Email)
      BEGIN
            SELECT -2 -- Email exists.
      END
      ELSE
      BEGIN
            INSERT INTO [Users]
                     ([Username]
                     ,[Password]
                     ,[Email]
                     ,[CreatedDate])
            VALUES
                     (@Username
                     ,@Password
                     ,@Email
                     ,GETDATE())
           
            SELECT SCOPE_IDENTITY() -- UserId                 
     END
END


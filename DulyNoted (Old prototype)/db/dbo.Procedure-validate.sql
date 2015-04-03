CREATE PROCEDURE [dbo].[Validate_User]
      @email NCHAR(75),
      @password NCHAR(255)
AS
BEGIN
      SET NOCOUNT ON;
      DECLARE @userId INT, @lastLoginDate DATETIME
     
      SELECT @userId = userId, @lastLoginDate = lastLoginDate
      FROM Users WHERE email = @email AND [password] = @password
     
      IF @userId IS NOT NULL
      BEGIN
            IF NOT EXISTS(SELECT userId FROM UserActivations WHERE userId = @userId) --no record in the activation table-> activated
            BEGIN
                  UPDATE Users
                  SET lastLoginDate = GETDATE()
                  WHERE userId = @userId
                  SELECT @userId [userId] -- User Valid
            END
            ELSE
            BEGIN
                  SELECT -2 -- User not activated.
            END
      END
      ELSE
      BEGIN
            SELECT -1 -- User invalid.
      END
END
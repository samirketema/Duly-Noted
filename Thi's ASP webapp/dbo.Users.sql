CREATE TABLE [dbo].[Users]
(
	[UserID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Username] NVARCHAR(10) NOT NULL, 
    [Password] NVARCHAR(10) NOT NULL, 
    [Email] NVARCHAR(10) NOT NULL, 
    [CreatedDate] DATETIME NOT NULL, 
    [LastLoginDate] DATETIME NULL
)
CREATE TABLE [dbo].[Users]
(
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[email] [nchar](75) NOT NULL,
	[password] [nchar](255) NOT NULL,
	[firstName] [nchar](75) NOT NULL,
	[lastName] [nchar](75) NOT NULL,
	[displayName] [nchar](75) NOT NULL,
	[banned] [bit] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[lastLoginDate] [datetime] NOT NULL,
	[salt] [nchar] (75) NOT NULL,
	CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
	(
		[userId] ASC
	),
	 CONSTRAINT [IX_Users] UNIQUE NONCLUSTERED 
	(
		[email] ASC
	)
);

CREATE TABLE [dbo].[UserActivations]
(
	[userId] [int] NOT NULL,
	[activationCode] [uniqueidentifier] NOT NULL,
	 CONSTRAINT [PK_UserActivations] PRIMARY KEY CLUSTERED 
	(
		[userId] ASC
	),
	CONSTRAINT [FK_UserActivations_Users] FOREIGN KEY([userId]) REFERENCES [dbo].[Users] ([userId])
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE [dbo].[Courses]
(
	[courseId] [int] IDENTITY (1, 1) NOT NULL,
	[subject] [nchar](3) NOT NULL,
	[courseNumber] [nchar](5) NOT NULL,
	[coursename] [nchar](75) NOT NULL,
	 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
	(
		[courseId] ASC
	)
);

CREATE TABLE [dbo].[Professors]
(
	[professorId] [int] IDENTITY (1, 1) NOT NULL,
	[email] [nvarchar](75) NOT NULL,
	[firstName] [nvarchar](75) NOT NULL,
	[lastName] [nvarchar](75) NOT NULL,
	 CONSTRAINT [PK_Professors] PRIMARY KEY CLUSTERED 
	(
		[professorId] ASC
	),
	CONSTRAINT [IX_Professors] UNIQUE NONCLUSTERED
	(
		[email] ASC
	)
);

CREATE TABLE [dbo].[Sections]
(
	[sId] [int] IDENTITY (1, 1) NOT NULL,
	[courseId] [int] NOT NULL,
	[sectionNumber] [nchar](4) NOT NULL,
	[professorId] [int] NULL,
	[daysMeet] [nchar](3) NULL,
	[startTime] [time](7) NULL,
	[endTime] [time](7) NULL,
	 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
	(
		[sId] ASC
	),
	CONSTRAINT [IX_Sections] UNIQUE NONCLUSTERED
	(
		[sectionNumber] ASC
	),
	CONSTRAINT [FK_Sections_Courses] FOREIGN KEY([courseId]) REFERENCES [dbo].[Courses] ([courseId])
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT [FK_Sections_Professors] FOREIGN KEY([professorId]) REFERENCES [dbo].[Professors] ([professorId])
		ON UPDATE CASCADE
		ON DELETE SET NULL
);

CREATE TABLE [dbo].[PasswordRecoveries]
(
	[userId] [int] NOT NULL,
	[validCode] [nchar](50) NOT NULL,
	 CONSTRAINT [PK_PasswordRecoveries] PRIMARY KEY CLUSTERED 
	(
		[userId] ASC
	),
	CONSTRAINT [FK_PasswordRecoveries_Users] FOREIGN KEY([userId]) REFERENCES [dbo].[Users] ([userId])
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE [dbo].[BannedEmails]
(
	[email] [nchar](75) NOT NULL,
	 CONSTRAINT [PK_bannedEmails] PRIMARY KEY CLUSTERED 
	(
		[email] ASC
	),
); 

CREATE TABLE [dbo].[Admins]
(
	[adminId] [int] IDENTITY (1, 1) NOT NULL,
	[password] [nchar](255) NOT NULL,
	[email] [nchar](75) NOT NULL,
	 CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED 
	(
		[adminId] ASC
	)
);

CREATE TABLE [dbo].[Notes] 
(
	[noteId] [int] IDENTITY (1, 1) NOT NULL,
	[sId] [int] NOT NULL,
	[userId] [int],
	[numberTimesFlagged] [int] DEFAULT 0,
	[upVoteCounter] [int] DEFAULT 0,
	[downVoteCounter] [int] DEFAULT 0,
	[source] VARBINARY(MAX) FILESTREAM NULL,
	[UI] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE,
	CONSTRAINT [PK_Notes] PRIMARY KEY CLUSTERED 
	(
		[noteId] ASC
	),
	
	CONSTRAINT [FK_Notes_Sections] FOREIGN KEY([sId]) REFERENCES [dbo].[Sections]([sId])
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT [FK_Notes_Users] FOREIGN KEY([userId]) REFERENCES [dbo].[Users] ([userId])
		ON UPDATE CASCADE
		ON DELETE SET NULL
);

CREATE TABLE [dbo].[Comments]
(
	[commentId] [int] IDENTITY (1, 1) NOT NULL,
	[userId] [int],
	[noteId] [int] NOT NULL,
	[commentedTime] [datetime] NOT NULL,
	[comment] varchar(max) NOT NULL,
	CONSTRAINT [FK_Comments_Users] FOREIGN KEY([userId]) REFERENCES [dbo].[Users]([userId])
		ON UPDATE CASCADE
		ON DELETE SET NULL,
	CONSTRAINT [FK_Comments_Notes] FOREIGN KEY([noteId]) REFERENCES [dbo].[Notes] ([noteId])
);


/****** Object:  Table [dbo].[Users]    Script Date: 2/27/2015 3:05:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nchar](75) NOT NULL,
	[password] [nchar](255) NOT NULL,
	[firstName] [nchar](75) NOT NULL,
	[lastName] [nchar](75) NOT NULL,
	[displayName] [nchar](75) NOT NULL,
	[banned] [bit] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[lastLoginDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Users] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[UserActivations]    Script Date: 2/27/2015 3:05:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserActivations](
	[id] [int] NOT NULL,
	[activationCode] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserActivations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[UserActivations]  WITH CHECK ADD  CONSTRAINT [FK_UserActivations_Users] FOREIGN KEY([id])
REFERENCES [dbo].[Users] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[UserActivations] CHECK CONSTRAINT [FK_UserActivations_Users]
GO

/****** Object:  Table [dbo].[Courses]    Script Date: 2/27/2015 3:05:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Courses](
	[subject] [nchar](3) NOT NULL,
	[courseNumber] [nchar](5) NOT NULL,
	[coursename] [nchar](75) NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[subject] ASC,
	[courseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Professors]    Script Date: 2/27/2015 3:06:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Professors](
	[email] [nvarchar](75) NOT NULL,
	[firstName] [nvarchar](75) NOT NULL,
	[lastName] [nvarchar](75) NOT NULL,
 CONSTRAINT [PK_Professors] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Sections]    Script Date: 2/27/2015 3:06:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sections](
	[subject] [nchar](3) NOT NULL,
	[courseNumber] [nchar](5) NOT NULL,
	[sectionNumber] [nchar](4) NOT NULL,
	[professorEmail] [nvarchar](75) NULL,
	[daysMeet] [nchar](3) NULL,
	[startTime] [time](7) NULL,
	[endTime] [time](7) NULL,
 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
(
	[sectionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Courses] FOREIGN KEY([subject], [courseNumber])
REFERENCES [dbo].[Courses] ([subject], [courseNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Courses]
GO

ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Professors] FOREIGN KEY([professorEmail])
REFERENCES [dbo].[Professors] ([email])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Professors]
GO

/****** Object:  Table [dbo].[PasswordRecoveries]    Script Date: 2/27/2015 3:07:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PasswordRecoveries](
	[userId] [int] NOT NULL,
	[validCode] [nchar](50) NOT NULL,
 CONSTRAINT [PK_PasswordRecoveries] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PasswordRecoveries]  WITH CHECK ADD  CONSTRAINT [FK_PasswordRecoveries_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[PasswordRecoveries] CHECK CONSTRAINT [FK_PasswordRecoveries_Users]
GO

/****** Object:  Table [dbo].[BannedEmails]    Script Date: 2/27/2015 3:07:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BannedEmails](
	[email] [nchar](75) NOT NULL,
 CONSTRAINT [PK_bannedEmails] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[BannedEmails]  WITH CHECK ADD  CONSTRAINT [FK_Use_bannedEmails] FOREIGN KEY([email])
REFERENCES [dbo].[Users] ([email])
GO

ALTER TABLE [dbo].[BannedEmails] CHECK CONSTRAINT [FK_Use_bannedEmails]
GO

/****** Object:  Table [dbo].[Admins]    Script Date: 2/27/2015 3:07:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Admins](
	[id] [int] NOT NULL,
	[password] [nchar](255) NOT NULL,
	[email] [nchar](75) NOT NULL,
 CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



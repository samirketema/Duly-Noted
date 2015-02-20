-- GO is not recognized by the hosting service

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[userId] [int] IDENTITY (1, 1) NOT NULL,
	[email] [nchar](75) NOT NULL,
	[password] [nchar](255) NOT NULL,
	[firstName] [nchar](75) NOT NULL,
	[lastName] [nchar](75) NOT NULL,
	[displayName] [nchar](75) NOT NULL,
	[banned] [bit] NOT NULL,
	[createdDate]   DATETIME NOT NULL,
	[lastLoginDate] DATETIME NULL,

 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([userID] ASC)
)

GO

CREATE TABLE [dbo].[UserActivations](
	[userId] [int] NOT NULL,
	[activationCode] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserActivations] PRIMARY KEY CLUSTERED ([userID] ASC)
)

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

CREATE TABLE [dbo].[Sections](
	[subject] [nchar](3) NOT NULL,
	[courseNumber] [nchar](5) NOT NULL,
	[sectionNumber] [nchar](4) NOT NULL,
	[professorEmail] [nvarchar](75) NULL,
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


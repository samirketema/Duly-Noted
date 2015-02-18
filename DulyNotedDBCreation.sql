IF EXISTS (SELECT * FROM sys.table_types where name = 'Courses')
BEGIN
	DROP TABLE Courses
END
GO

IF EXISTS (SELECT * FROM sys.table_types where name = 'Professors')
BEGIN
	DROP TABLE Professors
END
GO

IF EXISTS (SELECT * FROM sys.table_types where name = 'Sections')
BEGIN
	DROP TABLE Sections
END
GO

IF EXISTS (SELECT * FROM sys.table_types where name = 'UserActivations')
BEGIN
	DROP TABLE UserActivations
END
GO

IF EXISTS (SELECT * FROM sys.table_types where name = 'Users')
BEGIN
	DROP TABLE Users
END
GO

/****** Object:  Table [dbo].[Users]    Script Date: 2/18/2015 3:08:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[email] [nchar](75) NOT NULL,
	[password] [nchar](255) NOT NULL,
	[firstName] [nchar](75) NOT NULL,
	[lastName] [nchar](75) NOT NULL,
	[displayName] [nchar](75) NULL,
	[banned] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[UserActivations]    Script Date: 2/18/2015 3:08:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserActivations](
	[userEmail] [nchar](75) NOT NULL,
	[activationCode] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserActivations] PRIMARY KEY CLUSTERED 
(
	[userEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[UserActivations]  WITH CHECK ADD  CONSTRAINT [FK_UserActivations_UserActivations] FOREIGN KEY([userEmail])
REFERENCES [dbo].[Users] ([email])
GO

ALTER TABLE [dbo].[UserActivations] CHECK CONSTRAINT [FK_UserActivations_UserActivations]
GO

/****** Object:  Table [dbo].[Sections]    Script Date: 2/18/2015 3:08:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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

/****** Object:  Table [dbo].[Professors]    Script Date: 2/18/2015 3:08:09 PM ******/
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

/****** Object:  Table [dbo].[Courses]    Script Date: 2/18/2015 3:08:05 PM ******/
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





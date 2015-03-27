CREATE DATABASE [DulyNoted]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DulyNoted', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS2014\MSSQL\DATA\DulyNoted.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FileStreamFileGroup] CONTAINS FILESTREAM  DEFAULT
( NAME = N'FileStreamDBFile2', FILENAME = N'C:\FileStreamDBFile2' , MAXSIZE = UNLIMITED)
 LOG ON 
( NAME = N'DulyNoted_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS2014\MSSQL\DATA\DulyNoted_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [DulyNoted] SET FILESTREAM( NON_TRANSACTED_ACCESS = FULL, DIRECTORY_NAME = N'FileDBFileStreamDirectory5' ) 
GO

CREATE TABLE DulyNotedFileTable AS FileTable
WITH (
 FileTable_Directory = 'DulyNotedFileTable',
 FileTable_Collate_Filename = database_default
)
USE [master]
GO
/****** Object:  Database [TravelAgency]    Script Date: 10.11.2024 0:37:31 ******/
CREATE DATABASE [TravelAgency]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TravelAgency', FILENAME = N'C:\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TravelAgency.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TravelAgency_log', FILENAME = N'C:\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TravelAgency_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TravelAgency].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TravelAgency] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TravelAgency] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TravelAgency] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TravelAgency] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TravelAgency] SET ARITHABORT OFF 
GO
ALTER DATABASE [TravelAgency] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TravelAgency] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TravelAgency] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TravelAgency] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TravelAgency] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TravelAgency] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TravelAgency] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TravelAgency] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TravelAgency] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TravelAgency] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TravelAgency] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TravelAgency] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TravelAgency] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TravelAgency] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TravelAgency] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TravelAgency] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TravelAgency] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TravelAgency] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TravelAgency] SET  MULTI_USER 
GO
ALTER DATABASE [TravelAgency] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TravelAgency] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TravelAgency] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TravelAgency] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TravelAgency] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TravelAgency]
GO
/****** Object:  User [TravelTourManagerUser]    Script Date: 10.11.2024 0:37:31 ******/
CREATE USER [TravelTourManagerUser] FOR LOGIN [TravelTourManager] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [TravelManagerUser]    Script Date: 10.11.2024 0:37:31 ******/
CREATE USER [TravelManagerUser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [TravelClientManagerUser]    Script Date: 10.11.2024 0:37:31 ******/
CREATE USER [TravelClientManagerUser] FOR LOGIN [TravelClientManager] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [TravelAdminUser]    Script Date: 10.11.2024 0:37:31 ******/
CREATE USER [TravelAdminUser] FOR LOGIN [TravelAdmin] WITH DEFAULT_SCHEMA=[db_owner]
GO
ALTER ROLE [db_datareader] ADD MEMBER [TravelTourManagerUser]
GO
ALTER ROLE [db_datareader] ADD MEMBER [TravelManagerUser]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [TravelManagerUser]
GO
ALTER ROLE [db_datareader] ADD MEMBER [TravelClientManagerUser]
GO
ALTER ROLE [db_owner] ADD MEMBER [TravelAdminUser]
GO
/****** Object:  UserDefinedFunction [dbo].[Calculator]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Calculator]
(@Opd1 bigint,
@Opd2 bigint,
@Oprt varchar(1) = '*')
RETURNS bigint
AS
BEGIN
DECLARE @Result bigint
SET @Result = CASE @Oprt
WHEN '+' THEN @Opd1 + @Opd2
WHEN '-' THEN @Opd1 - @Opd2
WHEN '*' THEN @Opd1 * @Opd2
WHEN '/' THEN @Opd1 / @Opd2
ELSE 0
END
Return @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[FullAddress]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FullAddress] (@Id INT)
RETURNS VARCHAR(1000)
AS
BEGIN
 DECLARE @num int;
 DECLARE @FullAddress VARCHAR(1000);
 SELECT @FullAddress = PensionCountry + ', г.' + 
 PensionCity + ', ' + PensionAddress
 FROM Pension RETURN(@FullAddress);
END
GO
/****** Object:  UserDefinedFunction [dbo].[MonthArriv]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MonthArriv] (@Id INT)
RETURNS CHAR(15)
WITH EXECUTE AS CALLER
AS
BEGIN
 DECLARE @num int;
 DECLARE @DateArriv date;
 SELECT @DateArriv = TravelPackArrivData 
 FROM TravelPack
 DECLARE @Month char(15);
 SET @num = MONTH(@DateArriv)
 IF (@num=1) SET @Month='Январь';
 IF (@num=2) SET @Month='Февраль';
 IF (@num=3) SET @Month='Март';
 IF (@num=4) SET @Month='Апрель';
 IF (@num=5) SET @Month='Май';
 IF (@num=6) SET @Month='Июнь';
 IF (@num=7) SET @Month='Июль';
 IF (@num=8) SET @Month='Август';
 IF (@num=9) SET @Month='Сентябрь';
 IF (@num=10) SET @Month='Октябрь';
 IF (@num=11) SET @Month='Ноябрь';
 IF (@num=12) SET @Month='Декабрь'; RETURN(@Month);
END
GO
/****** Object:  UserDefinedFunction [dbo].[ParseStr]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ParseStr] (@String nvarchar(500))
RETURNS @table TABLE
(Number int IDENTITY (1,1) NOT NULL,
Substr nvarchar (30))
AS
BEGIN
DECLARE @Str1 nvarchar(500), @Pos int,
@Count int, @PosCount int
SET @Count = 0
SET @PosCount = 1
SET @Str1 = @String
WHILE @Count < LEN(@Str1)
	BEGIN
	SET @Pos = CHARINDEX(' ', @Str1)
	IF @POS > 0
		BEGIN
		SET @Count = @Count + 1
		INSERT INTO @table
		VALUES (SUBSTRING (@Str1, 1, @Pos))
		--SET @PosCount = @PosCount + @Pos
		SET @Str1 = REPLACE(@Str1, SUBSTRING (@Str1, 1, @Pos), '')
		END
	ELSE
		BEGIN
		INSERT INTO @table
		VALUES (@Str1)
		BREAK
		END
	END
RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[popularMonth]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[popularMonth] (@Id INT)
RETURNS CHAR(15)
WITH EXECUTE AS CALLER
AS
BEGIN
 DECLARE @num int;
 DECLARE @DateArriv date;
 SELECT @DateArriv = TravelPackArrivData 
 FROM TravelPack
 DECLARE @Month char(15);
 SET @num = MONTH(@DateArriv)
 IF (@num=1) SET @Month='Январь';
 IF (@num=2) SET @Month='Февраль';
 IF (@num=3) SET @Month='Март';
 IF (@num=4) SET @Month='Апрель';
 IF (@num=5) SET @Month='Май';
 IF (@num=6) SET @Month='Июнь';
 IF (@num=7) SET @Month='Июль';
 IF (@num=8) SET @Month='Август';
 IF (@num=9) SET @Month='Сентябрь';
 IF (@num=10) SET @Month='Октябрь';
 IF (@num=11) SET @Month='Ноябрь';
 IF (@num=12) SET @Month='Декабрь'; RETURN(@Month);
END
GO
/****** Object:  Table [dbo].[Client]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[ClientFirstName] [nvarchar](250) NOT NULL,
	[ClientLastName] [nvarchar](250) NOT NULL,
	[ClientPatronymic] [nvarchar](250) NULL,
	[ClientPasSeries] [nvarchar](40) NULL,
	[ClientPasNumb] [nchar](6) NULL,
	[ClientBirthday] [date] NOT NULL,
	[ClientCity] [nvarchar](100) NOT NULL,
	[ClientAddress] [nvarchar](250) NOT NULL,
	[ClientPhone] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientCopy]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientCopy](
	[ClientID] [int] NOT NULL,
	[ClientFirstName] [nvarchar](250) NOT NULL,
	[ClientLastName] [nvarchar](250) NOT NULL,
	[ClientPatronymic] [nvarchar](250) NULL,
	[ClientPassData] [nvarchar](250) NOT NULL,
	[ClientBirthday] [date] NOT NULL,
	[ClientCity] [nvarchar](100) NOT NULL,
	[ClientAddress] [nvarchar](250) NOT NULL,
	[ClientPhone] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_ClientCopy] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Housing]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Housing](
	[HousingID] [int] IDENTITY(1,1) NOT NULL,
	[HousingName] [nvarchar](250) NOT NULL,
	[HousingCategory] [nvarchar](100) NOT NULL,
	[HousingLiveCondDiscript] [nvarchar](max) NULL,
	[HousingDayPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Housing] PRIMARY KEY CLUSTERED 
(
	[HousingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HousingType]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HousingType](
	[HousingTypeID] [int] IDENTITY(1,1) NOT NULL,
	[HousingTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_HousingType] PRIMARY KEY CLUSTERED 
(
	[HousingTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pension]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pension](
	[PensionID] [int] IDENTITY(1,1) NOT NULL,
	[PensionName] [nvarchar](250) NOT NULL,
	[PensionCountry] [nvarchar](100) NOT NULL,
	[PensionCity] [nvarchar](100) NOT NULL,
	[PensionAddress] [nvarchar](250) NOT NULL,
	[PensionPhone] [nvarchar](20) NOT NULL,
	[PensionTerritoryDiscription] [nvarchar](max) NULL,
	[PensionRoomCount] [int] NULL,
	[PensionPool] [bit] NOT NULL,
	[PensionMedService] [nvarchar](250) NOT NULL,
	[PensionSpa] [bit] NOT NULL,
	[PensionLvl] [nvarchar](100) NOT NULL,
	[PensionSeaDistanceKm] [float] NULL,
	[HousingID] [int] NOT NULL,
 CONSTRAINT [PK_Pension] PRIMARY KEY CLUSTERED 
(
	[PensionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tour]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tour](
	[TourID] [int] IDENTITY(1,1) NOT NULL,
	[TourName] [nvarchar](250) NOT NULL,
	[TourEatType] [nvarchar](250) NOT NULL,
	[TourDayPrice] [decimal](18, 2) NOT NULL,
	[TourCity] [nvarchar](100) NOT NULL,
	[TourPhoto] [nvarchar](max) NULL,
	[HousingTypeID] [int] NOT NULL,
	[TransportID] [int] NOT NULL,
 CONSTRAINT [PK_Tour] PRIMARY KEY CLUSTERED 
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TourSell]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourSell](
	[TourSellID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[TourID] [int] NOT NULL,
	[TourSellPrice] [decimal](18, 2) NULL,
	[TourSellDurationDay] [int] NOT NULL,
 CONSTRAINT [PK_TourSell] PRIMARY KEY CLUSTERED 
(
	[TourSellID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transport]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transport](
	[TransportID] [int] IDENTITY(1,1) NOT NULL,
	[TransportName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Transport] PRIMARY KEY CLUSTERED 
(
	[TransportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TravelPack]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TravelPack](
	[TravelPackID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[PensionID] [int] NOT NULL,
	[TravelPackArrivData] [date] NOT NULL,
	[TravelPackDepartDate] [date] NOT NULL,
	[TravelPackChild] [bit] NOT NULL,
	[TravelPackMedInsur] [bit] NOT NULL,
	[TravelPackPeopleCount] [int] NOT NULL,
	[TravelPackPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_TravelPack] PRIMARY KEY CLUSTERED 
(
	[TravelPackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PensionSea_View8_1]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PensionSea_View8_1] AS
SELECT PensionID AS 'ID Пансионата', 
PensionName AS 'Название пансионата', 
PensionCountry AS 'Страна',
PensionCity AS 'Город',
PensionAddress AS 'Адрес',
PensionPhone AS 'Номер телефона',
PensionTerritoryDiscription AS 'Описание территории',
PensionRoomCount AS 'Кол-во комнат',
PensionPool AS 'Наличие бассейна',
PensionMedService AS 'Мед. услуги',
PensionSpa AS 'Наличие спа',
PensionLvl AS 'Уровень пансионата',
PensionSeaDistanceKm AS 'Расстояние до моря',
HousingID AS 'ID вида жилья'
FROM Pension
WHERE NOT PensionSeaDistanceKm IS NULL
WITH CHECK OPTION
GO
/****** Object:  View [dbo].[PensionSea_View8_2]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PensionSea_View8_2] AS
SELECT PensionID AS 'ID Пансионата', 
ClientID AS 'ID Клиента',
[Название пансионата] , 
[Страна], [Город],
[Адрес], [Номер телефона],
TravelPackArrivData AS 'Дата въезда',
TravelPackDepartDate AS 'Дата выезда',
TravelPackPrice AS 'Стоимость'
FROM PensionSea_View8_1, TravelPack
WHERE [ID Пансионата] = PensionID
GO
/****** Object:  View [dbo].[View4]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View4]
AS
SELECT 
TravelPack.PensionID AS 'ID Пансионата', 
TravelPack.ClientID AS 'ID Клиента', 
PensionSea_View8_1.[Название пансионата],
PensionSea_View8_1.Страна, 
PensionSea_View8_1.Город, 
PensionSea_View8_1.Адрес, 
PensionSea_View8_1.[Номер телефона], 
TravelPack.TravelPackArrivData AS 'Дата въезда', 
TravelPack.TravelPackDepartDate AS 'Дата выезда', 
TravelPack.TravelPackPrice AS 'Стоимость'
FROM PensionSea_View8_1 
INNER JOIN TravelPack ON PensionSea_View8_1.[ID Пансионата] = TravelPack.PensionID
WHERE [Наличие бассейна] = 1
GO
/****** Object:  UserDefinedFunction [dbo].[DYNTAB]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DYNTAB] (@transport VARCHAR(10))
RETURNS Table
AS
RETURN SELECT TourID, TourName, TourDayPrice, TourCity FROM Tour
WHERE TourTransport = @transport
GO
/****** Object:  UserDefinedFunction [dbo].[tourActionTable]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[tourActionTable](@transport varchar(50))
RETURNS TABLE
AS
RETURN 
(SELECT TourID AS 'ID тура', 
TourName AS 'Название тура',
TourTransport AS 'Транспорт тура',
TourHousingCategory AS 'Категория жилья',
TourDayPrice AS 'Стоимость в день до повышения',
TourDayPrice + (TourDayPrice * 0.05) AS 'Стоимость в день после повышения',
TourCity AS 'Город' FROM Tour WHERE TourTransport = @transport);
GO
/****** Object:  UserDefinedFunction [dbo].[tourUpPriceTable]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[tourUpPriceTable](@transport varchar(50))
RETURNS TABLE
AS
RETURN 
(SELECT TourID AS 'ID тура', 
TourName AS 'Название тура',
TourTransport AS 'Транспорт тура',
TourHousingCategory AS 'Категория жилья',
TourDayPrice AS 'Стоимость в день до повышения',
TourDayPrice + (TourDayPrice * 0.05) AS 'Стоимость в день после повышения',
TourCity AS 'Город' FROM Tour WHERE TourTransport = @transport);
GO
/****** Object:  View [dbo].[PensionSea_View3]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PensionSea_View3] AS
SELECT PensionID AS 'ID Пансионата', 
PensionName AS 'Название пансионата', PensionCity AS 'Город',
PensionPhone AS 'Номер телефона',PensionPool AS 'Наличие бассейна',
PensionSpa AS 'Наличие спа' FROM Pension
WHERE PensionSeaDistanceKm IS NULL;
GO
/****** Object:  View [dbo].[PensionView_1]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PensionView_1]
AS
SELECT PensionID AS 'ID пансионата', PensionName AS 'Название пансионата', PensionCity AS 'Город', PensionPhone AS 'Номер телефона', PensionPool AS 'Наличие бассейна', PensionSpa AS 'Наличие спа'
FROM     dbo.Pension
WHERE  (PensionPool = 1) AND (PensionSpa = 1)
GO
/****** Object:  View [dbo].[TourAndClient_View4]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TourAndClient_View4] AS
SELECT TourSell.TourSellID AS 'ID Проданного тура', 
TourSell.TourID AS 'ID Тура', Tour.TourName AS 'Название тура', 
TourSell.ClientID AS 'ID Клиента', Client.ClientFirstName AS 'Фамилия', 
ClientLastName AS 'Имя', ClientPatronymic AS 'Отчество', 
ClientPhone AS 'Телефон' FROM Client
INNER JOIN TourSell ON TourSell.ClientID = Client.ClientID
INNER JOIN Tour ON Tour.TourID = TourSell.TourID
GO
/****** Object:  View [dbo].[TourSellView_2]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TourSellView_2]
AS
SELECT dbo.TourSell.TourSellID AS [ID Проданного тура], dbo.TourSell.ClientID AS [ID Клиента], dbo.Client.ClientFirstName AS Фамилия, dbo.Client.ClientLastName AS Имя, dbo.Client.ClientPatronymic AS Отчество, 
                  dbo.Client.ClientPhone AS Телефон
FROM     dbo.Client INNER JOIN
                  dbo.TourSell ON dbo.TourSell.ClientID = dbo.Client.ClientID
GO
/****** Object:  View [dbo].[View3]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View3] AS
SELECT PensionID AS 'ID Пансионата', 
PensionName AS 'Название пансионата', 
PensionCountry AS 'Страна',
PensionCity AS 'Город',
PensionAddress AS 'Адрес',
PensionPhone AS 'Номер телефона',
PensionTerritoryDiscription AS 'Описание территории',
PensionRoomCount AS 'Кол-во комнат',
PensionPool AS 'Наличие бассейна',
PensionMedService AS 'Мед. услуги',
PensionSpa AS 'Наличие спа',
PensionLvl AS 'Уровень пансионата',
PensionSeaDistanceKm AS 'Расстояние до моря',
HousingID AS 'ID вида жилья'
FROM Pension
WHERE PensionSeaDistanceKm IS NULL;
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (1, N'Бобров', N'Сергей', N'Дмитриевич', N'1845', N'981878', CAST(N'1987-04-20' AS Date), N'Самара', N'ул. Гагарина, 5', N'89745456987')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (2, N'Голубев', N'Иосиф', N'Тимофеевич', N'9178', N'561818', CAST(N'1982-05-06' AS Date), N'Брянск', N'пр. Ломоносова, 91', N'89458546547')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (3, N'Ермакова', N'Алла', N'Мироновна', N'9785', N'456314', CAST(N'1976-01-22' AS Date), N'Москва', N'ул. Ленина, 23', N'87455642565')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (4, N'Селиверстов', N'Глеб', N'Максимович', N'5616', N'515245', CAST(N'1999-06-20' AS Date), N'Владимир', N'ул. Космонавтов, 5', N'82345787865')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (5, N'Агафонов', N'Юстиниан', N'Олегович', N'7891', N'594565', CAST(N'1997-02-02' AS Date), N'Уфа', N'ул. Летчиков, 8', N'89456548785')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (6, N'Колобова', N'Злата', N'Романовна', N'1237', N'894589', CAST(N'1994-08-25' AS Date), N'Казань', N'ул. Пушкина, 9', N'89458524514')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (7, N'Сысоева', N'Дарина', N'Ярославовна', N'3218', N'529647', CAST(N'1982-02-03' AS Date), N'Москва', N'ул. Гоголя, 12', N'89456542585')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (8, N'Некрасов', N'Варлам', N'Михайлович', N'1223', N'664578', CAST(N'2000-11-12' AS Date), N'Волгоград', N'ул. Московская, 34', N'84759655412')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (9, N'Крюков', N'Наум', N'Ильяович', N'4587', N'561230', CAST(N'1993-11-17' AS Date), N'Брянск', N'ул. Революционная, 18', N'85642319654')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (10, N'Сидорова', N'Татьяна', N'Михайловна', N'4857', N'531818', CAST(N'1974-04-24' AS Date), N'Москва', N'пр. Октября, 123', N'84561459645')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (11, N'Трофимова', N'Альжбета', N'Якововна', N'4858', N'526974', CAST(N'1988-10-22' AS Date), N'Туймазы', N'ул. Гагарина, 78', N'84562255465')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (12, N'Новиков', N'Адриан', N'Аркадьевич', N'6565', N'842547', CAST(N'1974-01-15' AS Date), N'Уфа', N'ул. Героев, 36', N'84651234565')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (13, N'Мишина', N'Иветта', N'Андреевна', N'4857', N'891818', CAST(N'2002-10-05' AS Date), N'Владивосток', N'ул. Сибирская, 65', N'89994562587')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (14, N'Шестаков', N'Геннадий', N'Рубенович', N'8456', N'444848', CAST(N'2001-07-01' AS Date), N'Казань', N'ул. Ленина, 61', N'89456996606')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (15, N'Зуев', N'Матвей', N'Иванович', N'4564', N'561818', CAST(N'1981-03-28' AS Date), N'Ямал', N'ул. Левитана, 67', N'89665666606')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (16, N'Турова', N'Георгина', N'Семёновна', N'5465', N'625487', CAST(N'1974-05-28' AS Date), N'Нижний Новгород', N'ул. Писателей, 23', N'84558557565')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (17, N'Анисимов', N'Валентин', N'Пантелеймонович', N'1234', N'567894', CAST(N'2000-12-10' AS Date), N'Белгород', N'ул. Речная, 67', N'84443334565')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (18, N'Анисимова', N'Тамара', N'Витальевна', N'1254', N'856051', CAST(N'1988-06-16' AS Date), N'Уфа', N'ул. Прибрежная, 6', N'89994446611')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (19, N'Колобов', N'Орест', N'Юлианович', N'4158', N'618818', CAST(N'2001-07-14' AS Date), N'Москва', N'ул. Московская, 5', N'89457856895')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (20, N'Филатов', N'Аристарх', N'Дмитриевич', N'5155', N'415545', CAST(N'1989-05-29' AS Date), N'Тольяти', N'ул. Великая, 9', N'89376578797')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (21, N'Орлова', N'Влада', N'Мартыновна', N'5612', N'541125', CAST(N'1990-06-26' AS Date), N'Казань', N'ул. Петровская, 18', N'89749549614')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (22, N'Алексеева', N'Элина', N'Матвеевна', N'1487', N'569245', CAST(N'2002-05-07' AS Date), N'Владивосток', N'ул. Владимирская, 87', N'89457841978')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (23, N'Бобров', N'Агафон', N'Лаврентьевич', N'4587', N'569125', CAST(N'1995-07-29' AS Date), N'Москва', N'ул. Советская, 89', N'89654788035')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (24, N'Бирюкова', N'Инара', N'Улебовна', N'4523', N'058416', CAST(N'1978-07-21' AS Date), N'Стерлитамак', N'ул. Цветочная, 56', N'89002543664')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (25, N'Панфилов', N'Марк', N'Рудольфович', N'5645', N'627139', CAST(N'1991-04-13' AS Date), N'Москва', N'ул. Центральная, 15', N'89456581010')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (26, N'Колесникова', N'Алина', N'Еремеевна', N'5917', N'354842', CAST(N'2001-04-19' AS Date), N'Владимир', N'ул. Восточная, 5', N'89111012578')
INSERT [dbo].[Client] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPasSeries], [ClientPasNumb], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (30, N'Колосков', N'Леонид', N'Дмитриевич', N'5658', N'941574', CAST(N'2005-03-18' AS Date), N'Уфа', N'ул. Советская, 5', N'895254147585')
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (1, N'Бобров', N'Анатолий', N'Дмитриевич', N'184598 1878', CAST(N'1987-04-20' AS Date), N'Самара', N'ул. Гагарина, 5', N'89745456987')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (2, N'Голубев', N'Иосиф', N'Тимофеевич', N'9178561818', CAST(N'1982-05-06' AS Date), N'Брянск', N'пр. Ломоносова, 91', N'89458546547')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (3, N'Ермакова', N'Алла', N'Мироновна', N'9785456314', CAST(N'1976-01-22' AS Date), N'Москва', N'ул. Ленина, 23', N'87455642565')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (4, N'Селиверстов', N'Глеб', N'Максимович', N'5616515245', CAST(N'1999-06-20' AS Date), N'Владимир', N'ул. Космонавтов, 5', N'82345787865')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (5, N'Агафонов', N'Юстиниан', N'Олегович', N'7891594565', CAST(N'1997-02-02' AS Date), N'Уфа', N'ул. Летчиков, 8', N'89456548785')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (6, N'Колобова', N'Злата', N'Романовна', N'1237894589', CAST(N'1994-08-25' AS Date), N'Казань', N'ул. Пушкина, 9', N'89458524514')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (8, N'Некрасов', N'Варлам', N'Михайлович', N'1223664578', CAST(N'2000-11-12' AS Date), N'Волгоград', N'ул. Московская, 34', N'84759655412')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (9, N'Крюков', N'Наум', N'Ильяович', N'4587561230', CAST(N'1993-11-17' AS Date), N'Брянск', N'ул. Революционная, 18', N'85642319654')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (10, N'Сидорова', N'Татьяна', N'Михайловна', N'4857531818', CAST(N'1974-04-24' AS Date), N'Москва', N'пр. Октября, 123', N'84561459645')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (11, N'Трофимова', N'Альжбета', N'Якововна', N'4858526974', CAST(N'1988-10-22' AS Date), N'Туймазы', N'ул. Гагарина, 78', N'84562255465')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (12, N'Новиков', N'Адриан', N'Аркадьевич', N'6565842547', CAST(N'1974-01-15' AS Date), N'Уфа', N'ул. Героев, 36', N'84651234565')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (13, N'Мишина', N'Иветта', N'Андреевна', N'4857891818', CAST(N'2002-10-05' AS Date), N'Владивосток', N'ул. Сибирская, 65', N'89994562587')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (14, N'Шестаков', N'Геннадий', N'Рубенович', N'8456444848', CAST(N'2001-07-01' AS Date), N'Казань', N'ул. Ленина, 61', N'89456996606')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (15, N'Зуев', N'Матвей', N'Иванович', N'4564561818', CAST(N'1981-03-28' AS Date), N'Ямал', N'ул. Левитана, 67', N'89665666606')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (16, N'Турова', N'Георгина', N'Семёновна', N'5465625487', CAST(N'1974-05-28' AS Date), N'Нижний Новгород', N'ул. Писателей, 23', N'84558557565')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (17, N'Анисимов', N'Валентин', N'Пантелеймонович', N'1234567894', CAST(N'2000-12-10' AS Date), N'Белгород', N'ул. Речная, 67', N'84443334565')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (18, N'Анисимова', N'Тамара', N'Витальевна', N'1254856051', CAST(N'1988-06-16' AS Date), N'Уфа', N'ул. Прибрежная, 6', N'89994446611')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (19, N'Колобов', N'Орест', N'Юлианович', N'4158618818', CAST(N'2001-07-14' AS Date), N'Москва', N'ул. Московская, 5', N'89457856895')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (20, N'Филатов', N'Аристарх', N'Дмитриевич', N'5155415545', CAST(N'1989-05-29' AS Date), N'Тольяти', N'ул. Великая, 9', N'89376578797')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (21, N'Орлова', N'Влада', N'Мартыновна', N'5612541125', CAST(N'1990-06-26' AS Date), N'Казань', N'ул. Петровская, 18', N'89749549614')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (22, N'Алексеева', N'Элина', N'Матвеевна', N'1487569245', CAST(N'2002-05-07' AS Date), N'Владивосток', N'ул. Владимирская, 87', N'89457841978')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (23, N'Бобров', N'Агафон', N'Лаврентьевич', N'4587569125', CAST(N'1995-07-29' AS Date), N'Москва', N'ул. Советская, 89', N'89654788035')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (24, N'Бирюкова', N'Инара', N'Улебовна', N'4523058416', CAST(N'1978-07-21' AS Date), N'Стерлитамак', N'ул. Цветочная, 56', N'89002543664')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (26, N'Колесникова', N'Алина', N'Еремеевна', N'5917354842', CAST(N'2001-04-19' AS Date), N'Владимир', N'ул. Восточная, 5', N'89111012578')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (30, N'Колосков', N'Леонид', N'Дмитриевич', N'5658941574', CAST(N'2005-03-18' AS Date), N'Уфа', N'ул. Советская, 5', N'895254147585')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (55, N'Панфилов', N'Павел', N'Рудольфович', N'5645627139', CAST(N'1991-04-13' AS Date), N'Москва', N'ул. Центральная, 15', N'89456581010')
INSERT [dbo].[ClientCopy] ([ClientID], [ClientFirstName], [ClientLastName], [ClientPatronymic], [ClientPassData], [ClientBirthday], [ClientCity], [ClientAddress], [ClientPhone]) VALUES (77, N'Сысоева', N'Анастасия', N'Ярославовна', N'3218529647', CAST(N'1982-02-03' AS Date), N'Москва', N'ул. Гоголя, 12', N'89456542585')
GO
SET IDENTITY_INSERT [dbo].[Housing] ON 

INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (1, N'Бунгало', N'Комфорт', N'Опрятность владельца', CAST(1000.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (2, N'Дом', N'Люкс', N'Аккуратность, порядочность, не более 4 человек', CAST(4200.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (3, N'Комната', N'Комфорт', NULL, CAST(560.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (4, N'1 комнатная квартира', N'Комфорт', N'Аккуратность, чистота, не более 2 человек', CAST(2400.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (5, N'2 комнатная квартира', N'Люкс', NULL, CAST(3500.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (6, N'3 комнатная квартира', N'Комфорт', N'Не более 4 человек', CAST(2000.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (7, N'Дом', N'Комфорт', NULL, CAST(2000.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (8, N'Бунгало', N'Эконом', N'Не более 4 человек', CAST(840.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (9, N'Комната ', N'Эконом', NULL, CAST(350.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (10, N'Дом', N'Эконом', NULL, CAST(660.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (11, N'1 комнатная квартира', N'Эконом', N'Опрятность владельца', CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (12, N'3 комнатная квартира', N'Люкс', N'Аккуратность, порядочность, не более 4 человек', CAST(2000.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (13, N'2 комнатная квартира', N'Комфорт', NULL, CAST(2500.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (14, N'2 комнатная квартира', N'Эконом', N'Соблюдение порядка', CAST(1000.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (15, N'3 комнатная квартира', N'Эконом', N'Аккуратность, порядочность, не более 4 человек', CAST(1500.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (16, N'1 комнатная квартира', N'Люкс', N'Опрятность владельца', CAST(1800.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (17, N'Комната', N'Эконом', NULL, CAST(200.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (18, N'Хижина', N'Комфорт', N'Опрятность владельца', CAST(1200.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (19, N'Дом', N'Комфорт', N'Соблюдение порядка', CAST(880.00 AS Decimal(18, 2)))
INSERT [dbo].[Housing] ([HousingID], [HousingName], [HousingCategory], [HousingLiveCondDiscript], [HousingDayPrice]) VALUES (20, N'Хижина', N'Эконом', NULL, CAST(350.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Housing] OFF
GO
SET IDENTITY_INSERT [dbo].[HousingType] ON 

INSERT [dbo].[HousingType] ([HousingTypeID], [HousingTypeName]) VALUES (1, N'Гостиница')
INSERT [dbo].[HousingType] ([HousingTypeID], [HousingTypeName]) VALUES (2, N'Отель')
SET IDENTITY_INSERT [dbo].[HousingType] OFF
GO
SET IDENTITY_INSERT [dbo].[Pension] ON 

INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (1, N'Лазурь', N'Россия', N'Сочи', N'ул. Гагарина, 7', N'89994445566', NULL, 1, 0, N'Массаж', 0, N'Средний', 1, 13)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (2, N'Дубовая роща', N'Россия', N'Калуга', N'ул. Пригородная, 1', N'89745641010', N'Чистая природа', 2, 0, N'Профилактика дыхательных путей', 0, N'Высокий', NULL, 2)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (3, N'Тихое место', N'Россия', N'Воркута', N'ул. Дубовая, 3', N'89176664587', N'Пансионат недалеко от леса, в дали от всего', 1, 0, N'Психологическое лечение', 0, N'Средний', NULL, 1)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (4, N'Райский берег', N'Россия', N'Крым', N'ул. Ясная, 6', N'89976675487', N'Недалеко от моря', 3, 1, N'Массаж, профилакти дыхательных путей, хирург - костоправ', 1, N'Высокий', 0.4, 10)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (5, N'Здравие', N'Россия', N'Казань', N'ул. Моряков, 4', N'8954525554', NULL, 2, 1, N'Массаж, профилактика дыхательных путей, хирург, ортопед, диетолог', 1, N'Средний', 1, 11)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (6, N'Великие дубы', N'Россия', N'Калуга', N'ул. Зимняя, 7', N'89897845516', N'Чистый воздух', 2, 0, N'Профилактика дыхательных путей', 0, N'Средний', NULL, 17)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (7, N'Песочная крепость', N'Россия', N'Сочи', N'ул. Домодедовская, 31', N'84616886392', NULL, 3, 1, N'Массаж', 1, N'Средний', 0.2, 3)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (8, N'Кленовый лист', N'Россия', N'Самара', N'ул. Бухарестская, 23', N'89807952306', N'Чистый воздух, чистая огороженная территория', 1, 1, N'Массаж, профилактика дыхательных путей', 1, N'Эконом', NULL, 6)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (9, N'Крепкое здоровье', N'Россия', N'Москва', N'ул. Космонавтов, 73', N'85557856153', NULL, 1, 1, N'Массаж, профилактика дыхательных путей, хирург, ортопед, диетолог', 0, N'Средний', NULL, 9)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (10, N'Долгожитель', N'Россия', N'Казань', N'ул. Гоголя, 60', N'81522160291', N'Чистая и просторная территория, красивая архитектура', 2, 0, N'Массаж, профилактика дыхательных путей, хирург, ортопед, диетолог', 1, N'Высокий', NULL, 12)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (11, N'Чистые легкие', N'Россия', N'Челябинск', N'ул. Чехова, 38', N'87304869180', N'Множество древесных насаждений', 1, 0, N'Профилактика курения', 1, N'Средний', NULL, 14)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (12, N'Крепкие ноги', N'Россия', N'Уфа', N'ул. Балканская, 93', N'88900037185', NULL, 3, 1, N'Костоправ, ортопед', 0, N'Средний', NULL, 16)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (13, N'Здоровье', N'Россия', N'Москва', N'ул. Славы, 93', N'86997801978', NULL, 3, 0, N'Массаж, профилактика дыхательных путей, диетолог', 0, N'Эконом', NULL, 15)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (14, N'Доктор', N'Россия', N'Владивосток', N'ул. Ладыгина, 27', N'81887442027', N'Просторная территория недалеко от моря', 1, 1, N'Массаж, профилактика дыхательных путей, хирург, ортопед, диетолог', 0, N'Средний', 0.2, 18)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (15, N'Счастье', N'Россия', N'Магадан', N'ул. Ломоносова, 18', N'83860077357', NULL, 2, 0, N'Массаж', 1, N'Высокий', NULL, 20)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (16, N'Зоркий глаз', N'Россия', N'Иркутск', N'ул. Бухарестская, 19', N'85363805001', N'Чистая территория', 3, 1, N'Профилактика зрения', 0, N'Эконом', NULL, 19)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (17, N'Долгий путь', N'Россия', N'Норильск', N'ул. Будапештсткая, 72', N'88163051047', N'Красивая архитектура, большая территория', 2, 1, N'Массаж, профилактика дыхательных путей, диетолог', 0, N'Средний', NULL, 4)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (18, N'Твое счастье', N'Россия', N'Хабаровск', N'ул. Сталина, 98', N'84032096456', NULL, 1, 0, N'Массаж', 1, N'Высокий', NULL, 5)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (19, N'Луч солнца', N'Россия', N'Чита', N'ул. Славы, 48', N'83796880335', NULL, 3, 0, N'Массаж', 0, N'Средний', NULL, 8)
INSERT [dbo].[Pension] ([PensionID], [PensionName], [PensionCountry], [PensionCity], [PensionAddress], [PensionPhone], [PensionTerritoryDiscription], [PensionRoomCount], [PensionPool], [PensionMedService], [PensionSpa], [PensionLvl], [PensionSeaDistanceKm], [HousingID]) VALUES (20, N'Облако', N'Россия', N'Сочи', N'ул. Ленина, 51', N'83801536237', NULL, 1, 1, N'Профилактика дыхательных путей', 1, N'Средний', NULL, 7)
SET IDENTITY_INSERT [dbo].[Pension] OFF
GO
SET IDENTITY_INSERT [dbo].[Tour] ON 

INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (1, N'Тур в Казань 1', N'Завтрак в отеле', CAST(4061.69 AS Decimal(18, 2)), N'Казань', N'\imges\kazan1.jpg', 2, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (2, N'Тур в Сочи 1', N'Завтрак в отеле, обед и ужин клиент ищет сам', CAST(5209.31 AS Decimal(18, 2)), N'Сочи', N'\imges\sochi1.jpg', 2, 3)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (5, N'Тур во Владивосток', N'Завтрак, обед и ужин в гостинице', CAST(4398.98 AS Decimal(18, 2)), N'Владивосток', N'\imges\vladivostok.jpg', 1, 3)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (6, N'Тур в Калининград', N'Завтрак в гостинице, обед и ужин ищет клиент', CAST(5775.00 AS Decimal(18, 2)), N'Калининград', NULL, 1, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (7, N'Тур в Крым', N'Завтрак, обед и ужин в отеле', CAST(7245.00 AS Decimal(18, 2)), N'Севастополь', N'\imges\sevastopl1.jpg', 2, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (8, N'Тур в Казань', N'Завтрак, обед и ужин в отеле', CAST(3472.88 AS Decimal(18, 2)), N'Казань', N'\imges\kazan2.jpg', 2, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (9, N'Тур в Сочи', N'Завтрак в отеле, обед и ужин клиент ищет сам', CAST(5209.31 AS Decimal(18, 2)), N'Сочи', NULL, 2, 3)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (10, N'Тур во Владивосток', N'Завтрак, обед и ужин в гостинице', CAST(4398.98 AS Decimal(18, 2)), N'Владивосток', NULL, 1, 3)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (11, N'Тур в Калининград', N'Завтрак в гостинице, обед и ужин ищет клиент', CAST(5775.00 AS Decimal(18, 2)), N'Калининград', N'\imges\piter2.jpg', 1, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (12, N'Тур в Крым', N'Завтрак, обед и ужин в отеле', CAST(7245.00 AS Decimal(18, 2)), N'Севастополь', NULL, 2, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (13, N'Тур в Санкт-Петербург', N'Завтрак, обед и ужин в гостинице', CAST(3820.16 AS Decimal(18, 2)), N'Санкт-Петербург', N'\imges\piter1.jpg', 1, 3)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (14, N'Тур в Екатеринбург', N'Завтрак, обед и ужин в гостинице', CAST(3241.35 AS Decimal(18, 2)), N'Екатеринбург', NULL, 1, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (15, N'Тур в Псков', N'Завтрак в отеле, обед и ужин клиент ищет сам', CAST(2546.78 AS Decimal(18, 2)), N'Псков', NULL, 2, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (16, N'Тур в Петрозаводск', N'Завтрак в гостинице, обед и ужин ищет клиент', CAST(1896.20 AS Decimal(18, 2)), N'Петрозаводск', NULL, 1, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (17, N'Тур на Байкал', N'Завтрак, обед и ужин в отеле', CAST(4051.69 AS Decimal(18, 2)), N'Иркутск', NULL, 2, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (18, N'Тур в Волгоград', N'Завтрак, обед и ужин в гостинице', CAST(2431.01 AS Decimal(18, 2)), N'Волгоград', NULL, 1, 3)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (19, N'Тур в Нижний Новгород', N'Завтрак в отеле, обед и ужин клиент ищет сам', CAST(2778.30 AS Decimal(18, 2)), N'Нижний Новгород', NULL, 2, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (20, N'Тур в Рязань', N'Завтрак, обед и ужин в гостинице', CAST(1914.42 AS Decimal(18, 2)), N'Рязань', NULL, 1, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (21, N'Тур в Смоленск', N'Завтрак в гостинице, обед и ужин ищет клиент', CAST(1902.26 AS Decimal(18, 2)), N'Смоленск', NULL, 1, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (22, N'Тур во Владимир', N'Завтрак в отеле, обед и ужин клиент ищет сам', CAST(2662.54 AS Decimal(18, 2)), N'Владимир', NULL, 2, 3)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (23, N'Тур Гармония воды и ветра', N'Завтрак, обед и ужин в гостинице', CAST(3820.16 AS Decimal(18, 2)), N'Рыбинск', NULL, 1, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (24, N'Тур Святая Русь', N'Завтрак, обед и ужин в отеле', CAST(3241.35 AS Decimal(18, 2)), N'Мурманск', NULL, 2, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (25, N'Тур На Волжских берегах', N'Завтрак, обед и ужин в гостинице', CAST(1932.66 AS Decimal(18, 2)), N'Рыбинск', N'\imges\ribinsk1.jpg', 1, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (26, N'Тур Волжские просторы', N'Завтрак, обед и ужин в гостинице', CAST(3820.16 AS Decimal(18, 2)), N'Кострома', NULL, 1, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (27, N'Тур Аппетитная Ярославия', N'Завтрак, обед и ужин в разных заведениях города', CAST(4051.69 AS Decimal(18, 2)), N'Ярославль', NULL, 2, 2)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (39, N'ррпорр', N'геенг', CAST(120.00 AS Decimal(18, 2)), N'егн', N'C:\Users\marat\Downloads\(.png', 1, 1)
INSERT [dbo].[Tour] ([TourID], [TourName], [TourEatType], [TourDayPrice], [TourCity], [TourPhoto], [HousingTypeID], [TransportID]) VALUES (41, N'мв', N'авы', CAST(10.00 AS Decimal(18, 2)), N'ва', NULL, 1, 2)
SET IDENTITY_INSERT [dbo].[Tour] OFF
GO
SET IDENTITY_INSERT [dbo].[TourSell] ON 

INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (1, 5, 1, CAST(12185.07 AS Decimal(18, 2)), 3)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (2, 17, 5, CAST(21994.90 AS Decimal(18, 2)), 5)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (3, 20, 6, CAST(40425.00 AS Decimal(18, 2)), 7)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (4, 15, 2, CAST(26046.55 AS Decimal(18, 2)), 5)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (5, 14, 2, CAST(36465.17 AS Decimal(18, 2)), 7)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (6, 19, 7, CAST(43470.00 AS Decimal(18, 2)), 6)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (10, 20, 9, CAST(20837.24 AS Decimal(18, 2)), 4)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (11, 13, 20, CAST(5743.26 AS Decimal(18, 2)), 3)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (12, 17, 15, CAST(17827.46 AS Decimal(18, 2)), 7)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (13, 11, 11, CAST(11550.00 AS Decimal(18, 2)), 2)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (15, 15, 17, CAST(16206.76 AS Decimal(18, 2)), 4)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (16, 19, 16, CAST(1896.20 AS Decimal(18, 2)), 1)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (17, 21, 11, CAST(28875.00 AS Decimal(18, 2)), 5)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (18, 22, 10, CAST(26393.88 AS Decimal(18, 2)), 6)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (19, 13, 18, CAST(9724.04 AS Decimal(18, 2)), 4)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (20, 11, 12, CAST(36225.00 AS Decimal(18, 2)), 5)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (21, 25, 21, CAST(17120.34 AS Decimal(18, 2)), 9)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (22, 14, 1, CAST(12185.07 AS Decimal(18, 2)), 3)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (23, 7, 5, CAST(17595.92 AS Decimal(18, 2)), 4)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (25, 21, 5, CAST(35191.84 AS Decimal(18, 2)), 8)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (26, 24, 7, CAST(36225.00 AS Decimal(18, 2)), 5)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (27, 26, 9, CAST(15627.93 AS Decimal(18, 2)), 3)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (28, 20, 20, CAST(5743.26 AS Decimal(18, 2)), 3)
INSERT [dbo].[TourSell] ([TourSellID], [ClientID], [TourID], [TourSellPrice], [TourSellDurationDay]) VALUES (29, 6, 7, CAST(28980.00 AS Decimal(18, 2)), 4)
SET IDENTITY_INSERT [dbo].[TourSell] OFF
GO
SET IDENTITY_INSERT [dbo].[Transport] ON 

INSERT [dbo].[Transport] ([TransportID], [TransportName]) VALUES (1, N'Автобус')
INSERT [dbo].[Transport] ([TransportID], [TransportName]) VALUES (2, N'Поезд')
INSERT [dbo].[Transport] ([TransportID], [TransportName]) VALUES (3, N'Самолёт')
SET IDENTITY_INSERT [dbo].[Transport] OFF
GO
SET IDENTITY_INSERT [dbo].[TravelPack] ON 

INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (12, 4, 10, CAST(N'2024-04-12' AS Date), CAST(N'2024-04-15' AS Date), 0, 1, 3, CAST(12500.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (13, 5, 2, CAST(N'2023-03-19' AS Date), CAST(N'2023-03-21' AS Date), 1, 1, 2, CAST(9000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (14, 12, 7, CAST(N'2023-02-02' AS Date), CAST(N'2023-02-09' AS Date), 0, 0, 1, CAST(19000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (16, 13, 5, CAST(N'2024-01-20' AS Date), CAST(N'2024-01-22' AS Date), 1, 0, 2, CAST(5000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (19, 20, 15, CAST(N'2024-03-01' AS Date), CAST(N'2024-03-05' AS Date), 1, 1, 2, CAST(8200.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (20, 25, 16, CAST(N'2023-09-18' AS Date), CAST(N'2023-09-20' AS Date), 0, 1, 3, CAST(12000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (21, 19, 9, CAST(N'2022-10-10' AS Date), CAST(N'2022-10-15' AS Date), 1, 0, 3, CAST(18200.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (22, 1, 2, CAST(N'2024-01-01' AS Date), CAST(N'2024-01-04' AS Date), 0, 1, 3, CAST(21250.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (24, 7, 11, CAST(N'2024-02-02' AS Date), CAST(N'2024-02-05' AS Date), 0, 0, 1, CAST(7200.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (25, 16, 14, CAST(N'2023-06-24' AS Date), CAST(N'2024-06-27' AS Date), 1, 0, 2, CAST(9500.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (27, 22, 1, CAST(N'2023-07-06' AS Date), CAST(N'2023-07-09' AS Date), 1, 1, 3, CAST(10300.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (28, 23, 5, CAST(N'2023-09-09' AS Date), CAST(N'2023-09-12' AS Date), 0, 0, 1, CAST(9000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (29, 9, 17, CAST(N'2023-12-15' AS Date), CAST(N'2023-12-19' AS Date), 1, 1, 3, CAST(21000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (33, 24, 19, CAST(N'2024-04-04' AS Date), CAST(N'2024-04-09' AS Date), 1, 0, 2, CAST(15000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (34, 26, 20, CAST(N'2023-06-05' AS Date), CAST(N'2023-06-09' AS Date), 0, 0, 1, CAST(9000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (35, 8, 18, CAST(N'2022-10-10' AS Date), CAST(N'2022-10-13' AS Date), 1, 0, 3, CAST(17900.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (36, 23, 19, CAST(N'2023-10-19' AS Date), CAST(N'2023-10-23' AS Date), 0, 1, 1, CAST(16500.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (37, 3, 9, CAST(N'2024-02-20' AS Date), CAST(N'2024-02-23' AS Date), 0, 0, 1, CAST(9500.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (38, 16, 14, CAST(N'2022-04-20' AS Date), CAST(N'2022-04-24' AS Date), 1, 1, 2, CAST(16000.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (39, 19, 20, CAST(N'2023-03-14' AS Date), CAST(N'2023-03-17' AS Date), 0, 1, 1, CAST(7500.00 AS Decimal(18, 2)))
INSERT [dbo].[TravelPack] ([TravelPackID], [ClientID], [PensionID], [TravelPackArrivData], [TravelPackDepartDate], [TravelPackChild], [TravelPackMedInsur], [TravelPackPeopleCount], [TravelPackPrice]) VALUES (40, 11, 16, CAST(N'2024-01-15' AS Date), CAST(N'2024-01-19' AS Date), 1, 0, 2, CAST(12000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[TravelPack] OFF
GO
ALTER TABLE [dbo].[Pension]  WITH CHECK ADD  CONSTRAINT [FK_Pension_Housing] FOREIGN KEY([HousingID])
REFERENCES [dbo].[Housing] ([HousingID])
GO
ALTER TABLE [dbo].[Pension] CHECK CONSTRAINT [FK_Pension_Housing]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_HousingType] FOREIGN KEY([HousingTypeID])
REFERENCES [dbo].[HousingType] ([HousingTypeID])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [FK_Tour_HousingType]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_Transport] FOREIGN KEY([TransportID])
REFERENCES [dbo].[Transport] ([TransportID])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [FK_Tour_Transport]
GO
ALTER TABLE [dbo].[TourSell]  WITH CHECK ADD  CONSTRAINT [FK_TourSell_Client] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ClientID])
GO
ALTER TABLE [dbo].[TourSell] CHECK CONSTRAINT [FK_TourSell_Client]
GO
ALTER TABLE [dbo].[TourSell]  WITH CHECK ADD  CONSTRAINT [FK_TourSell_Tour] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tour] ([TourID])
GO
ALTER TABLE [dbo].[TourSell] CHECK CONSTRAINT [FK_TourSell_Tour]
GO
ALTER TABLE [dbo].[TravelPack]  WITH CHECK ADD  CONSTRAINT [FK_TravelPack_Client] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ClientID])
GO
ALTER TABLE [dbo].[TravelPack] CHECK CONSTRAINT [FK_TravelPack_Client]
GO
ALTER TABLE [dbo].[TravelPack]  WITH CHECK ADD  CONSTRAINT [FK_TravelPack_Pension] FOREIGN KEY([PensionID])
REFERENCES [dbo].[Pension] ([PensionID])
GO
ALTER TABLE [dbo].[TravelPack] CHECK CONSTRAINT [FK_TravelPack_Pension]
GO
ALTER TABLE [dbo].[Housing]  WITH CHECK ADD  CONSTRAINT [DayPrice] CHECK  (([HousingDayPrice]>(0)))
GO
ALTER TABLE [dbo].[Housing] CHECK CONSTRAINT [DayPrice]
GO
ALTER TABLE [dbo].[Pension]  WITH CHECK ADD  CONSTRAINT [RoomCount] CHECK  (([PensionRoomCount]>=(0)))
GO
ALTER TABLE [dbo].[Pension] CHECK CONSTRAINT [RoomCount]
GO
ALTER TABLE [dbo].[Pension]  WITH CHECK ADD  CONSTRAINT [SeaDistance] CHECK  (([PensionSeaDistanceKm]>=(0)))
GO
ALTER TABLE [dbo].[Pension] CHECK CONSTRAINT [SeaDistance]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [TourDayPrice] CHECK  (([TourDayPrice]>(0)))
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [TourDayPrice]
GO
ALTER TABLE [dbo].[TourSell]  WITH CHECK ADD  CONSTRAINT [TourSellDurationDay] CHECK  (([TourSellDurationDay]>(0)))
GO
ALTER TABLE [dbo].[TourSell] CHECK CONSTRAINT [TourSellDurationDay]
GO
ALTER TABLE [dbo].[TourSell]  WITH CHECK ADD  CONSTRAINT [TourSellPrice] CHECK  (([TourSellPrice]>(0)))
GO
ALTER TABLE [dbo].[TourSell] CHECK CONSTRAINT [TourSellPrice]
GO
ALTER TABLE [dbo].[TravelPack]  WITH CHECK ADD  CONSTRAINT [ArrivDate] CHECK  (([TravelPackArrivData]<[TravelPackDepartDate]))
GO
ALTER TABLE [dbo].[TravelPack] CHECK CONSTRAINT [ArrivDate]
GO
ALTER TABLE [dbo].[TravelPack]  WITH CHECK ADD  CONSTRAINT [DepartDate] CHECK  (([TravelPackDepartDate]>[TravelPackArrivData]))
GO
ALTER TABLE [dbo].[TravelPack] CHECK CONSTRAINT [DepartDate]
GO
ALTER TABLE [dbo].[TravelPack]  WITH CHECK ADD  CONSTRAINT [PeopleCount] CHECK  (([TravelPackPeopleCount]>(0)))
GO
ALTER TABLE [dbo].[TravelPack] CHECK CONSTRAINT [PeopleCount]
GO
ALTER TABLE [dbo].[TravelPack]  WITH CHECK ADD  CONSTRAINT [Price] CHECK  (([TravelPackPrice]>(0)))
GO
ALTER TABLE [dbo].[TravelPack] CHECK CONSTRAINT [Price]
GO
/****** Object:  StoredProcedure [dbo].[checkClient]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkClient] @param int AS
IF (SELECT ClientBirthday FROM Client WHERE ClientID = @param) > '01-01-2006 '
RETURN 1
ELSE
RETURN 0
DECLARE @return_status int
EXECUTE @return_status = checkClient 14
SELECT 'Return Status' = @return_status
GO
/****** Object:  StoredProcedure [dbo].[checkname]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkname] @param int AS
IF (SELECT ClientBirthday FROM Client WHERE ClientID = @param) > '01-01-2000 '
RETURN 1
ELSE
RETURN 2
DECLARE @return_status int
EXECUTE @return_status = checkname 15
SELECT 'Return Status' = @return_status
GO
/****** Object:  StoredProcedure [dbo].[CountSell]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CountSell]
AS
SELECT COUNT(*) FROM TourSell ts, Tour t
WHERE ts.TourID = t.TourID AND TourCity = 'Владивосток'
RETURN
GO
/****** Object:  StoredProcedure [dbo].[SelectTour]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectTour] AS
SELECT * FROM Tour
WHERE TourDayPrice < 2000
GO
/****** Object:  StoredProcedure [dbo].[SumSell]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SumSell]
@idSell as int
AS
SELECT SUM(TourSellPrice) FROM TourSell
WHERE @idSell = TourID
GO
/****** Object:  StoredProcedure [dbo].[TourSell_TotalPrice]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TourSell_TotalPrice] AS
UPDATE TourSell
SET TourSell.TourSellPrice = TourSell.TourSellDurationDay * Tour.TourDayPrice
FROM TourSell
INNER JOIN Tour ON Tour.TourID = TourSell.TourID

GO
/****** Object:  StoredProcedure [dbo].[TourUpd]    Script Date: 10.11.2024 0:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TourUpd] AS
UPDATE Tour
SET TourDayPrice = TourDayPrice + (TourDayPrice * 0.05)
FROM TourSell
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[24] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Pension"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1284
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2196
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 624
         SortOrder = 528
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PensionView_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PensionView_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[24] 2[27] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Client"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TourSell"
            Begin Extent = 
               Top = 7
               Left = 303
               Bottom = 170
               Right = 536
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TourSellView_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TourSellView_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[38] 2[31] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Pension"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[37] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PensionSea_View8_1"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 300
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TravelPack"
            Begin Extent = 
               Top = 7
               Left = 348
               Bottom = 170
               Right = 598
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View4'
GO
USE [master]
GO
ALTER DATABASE [TravelAgency] SET  READ_WRITE 
GO

IF DB_ID(N'Tourism') IS NOT NULL
BEGIN
    ALTER DATABASE Tourism SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Tourism;
END
GO

CREATE DATABASE Tourism;
GO

USE Tourism;
GO

CREATE TABLE Countries
(
    CountryID INT IDENTITY(1,1) PRIMARY KEY,
    CountryName NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Cities
(
    CityID INT IDENTITY(1,1) PRIMARY KEY,
    CityName NVARCHAR(100) NOT NULL,
    CountryID INT NOT NULL,

    CONSTRAINT FK_Cities_Countries
        FOREIGN KEY (CountryID)
        REFERENCES Countries(CountryID)
);
GO

CREATE TABLE TourTypes
(
    TypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Tourists
(
    TouristID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(150) NOT NULL,
    Phone NVARCHAR(30),
    Email NVARCHAR(100)
);
GO

CREATE TABLE Tours
(
    TourID INT IDENTITY(1,1) PRIMARY KEY,
    TouristID INT NOT NULL,
    CityID INT NOT NULL,
    TypeID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(12,2) NOT NULL,

    CONSTRAINT FK_Tours_Tourists
        FOREIGN KEY (TouristID)
        REFERENCES Tourists(TouristID),

    CONSTRAINT FK_Tours_Cities
        FOREIGN KEY (CityID)
        REFERENCES Cities(CityID),

    CONSTRAINT FK_Tours_Types
        FOREIGN KEY (TypeID)
        REFERENCES TourTypes(TypeID)
);
GO

INSERT INTO Countries (CountryName)
VALUES
(N'Россия'),
(N'Турция'),
(N'Италия'),
(N'Франция');
GO

INSERT INTO Cities (CityName, CountryID)
VALUES
(N'Москва', 1),
(N'Санкт-Петербург', 1),
(N'Анталья', 2),
(N'Рим', 3),
(N'Париж', 4);
GO

INSERT INTO TourTypes (TypeName)
VALUES
(N'Пляжный'),
(N'Экскурсионный'),
(N'Познавательный'),
(N'Горный');
GO

INSERT INTO Tourists (FullName, Phone, Email)
VALUES
(N'Иванов Иван Иванович', N'+79990000001', N'ivanov@mail.ru'),
(N'Петров Петр Петрович', N'+79990000002', N'petrov@mail.ru'),
(N'Сидорова Анна Сергеевна', N'+79990000003', N'sidorova@mail.ru');
GO

INSERT INTO Tours
(
    TouristID,
    CityID,
    TypeID,
    StartDate,
    EndDate,
    Price
)
VALUES
(1, 3, 1, '2026-06-10', '2026-06-20', 85000),
(2, 4, 2, '2026-07-05', '2026-07-12', 120000),
(3, 5, 3, '2026-08-15', '2026-08-22', 135000),
(1, 2, 2, '2026-09-01', '2026-09-07', 55000);
GO
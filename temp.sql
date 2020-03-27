CREATE TABLE TypyPojazdow (id_typu_pojazdu INT PRIMARY KEY IDENTITY(1, 1), typ_pojazdu NVARCHAR(30))

CREATE TABLE Pojazdy (
	id_pojazdu INT PRIMARY KEY IDENTITY(1, 1),
	id_typu_pojazdu INT REFERENCES TypyPojazdow(id_typu_pojazdu),
	marka NVARCHAR(30),
	model NVARCHAR(30),
	rok_produkcji INT,
	liczba_miejsc INT,
	maksymlana_predkosc INT,
	przebieg INT,
	rodzaj_uprawnien NVARCHAR(10),
	id_parkingu INT,
	id_linii INT,
	id_wymaganych_uprawnien INT,

	FOREIGN KEY (id_wymaganych_uprawnien) REFERENCES Uprawnienia(id_uprawnien),
	FOREIGN KEY (id_linii) REFERENCES LinieInfo(id_linii),
	FOREIGN KEY (id_parkingu) REFERENCES Parkingi(id_parkingu),
	CONSTRAINT typ_pojazdu_cs UNIQUE (id_pojazdu, id_typu_pojazdu)
)

CREATE TABLE Autobusy (
	id_pojazdu INT PRIMARY KEY IDENTITY(1, 1),
	id_typu_pojazdu AS 1 PERSISTED,
	dlugosc INT,
	czy_przegubowy BIT,
	czy_pietrowy BIT,
	wysokosc_podlogi NVARCHAR(30),

	FOREIGN KEY (id_pojazdu, id_typu_pojazdu) REFERENCES Pojazdy(id_pojazdu, id_typu_pojazdu)
)

CREATE TABLE Tramwaje (
	id_pojazdu INT PRIMARY KEY IDENTITY(1, 1),
	id_typu_pojazdu AS 2 PERSISTED,
	ilosc_wagonow INT,
	miejsce_dla_rowerow BIT,
	miejsce_dla_wozkow BIT,
	
	FOREIGN KEY (id_pojazdu, id_typu_pojazdu) REFERENCES Pojazdy(id_pojazdu, id_typu_pojazdu)
)

CREATE TABLE Trolejbus (
	id_pojazdu INT PRIMARY KEY IDENTITY(1, 1),
	id_typu_pojazdu AS 3 PERSISTED,
	ilosc_miejsc_na_bagaze INT,
	pojemnosc_baterii INT,

	FOREIGN KEY (id_pojazdu, id_typu_pojazdu) REFERENCES Pojazdy(id_pojazdu, id_typu_pojazdu)
)

CREATE TABLE Naprawy (
	id_naprawy INT PRIMARY KEY IDENTITY(1, 1),
	id_pojazdu INT,
	id_pracownika INT,
	czas_rozpoczecia_naprawy DATE,
	czas_zakonczenia_naprawy DATE,
	opis_usterki NVARCHAR(255),

	FOREIGN KEY (id_pojazdu) REFERENCES Pojazdy(id_pojazdu),
	FOREIGN KEY (id_pracownika) REFERENCES Serwisanci(id_pracownika)
)

CREATE TABLE TypyBiletow (
	id_typu_biletu INT PRIMARY KEY IDENTITY(1, 1),
	typ_biletu NVARCHAR(30),
	cena_biletu INT,
	czy_ulgowy BIT
)

CREATE TABLE Uzytkownicy (
	id_uzytkownika INT PRIMARY KEY IDENTITY(1, 1),
	nazwa_uzytkownina NVARCHAR(30),
	haslo_uzytkownika NVARCHAR(30),
	email_uzytkownika NVARCHAR(30),
	data_urodzenia DATE
)

CREATE TABLE SprzedazBiletow (
	id_sprzedazy INT PRIMARY KEY IDENTITY(1, 1),
	id_uzytkownika INT,
	id_typu_biletu INT,
	data_sprzedazy DATE
)

CREATE TABLE Parkingi (
	id_parkingu INT PRIMARY KEY IDENTITY(1, 1),
	ilosc_miejsc_postojowych INT,
	adres_parking NVARCHAR(30),
	id_strefy TINYINT,
	FOREIGN KEY (id_strefy) REFERENCES Strefy(id_strefy)
)

INSERT INTO TypyBiletow VALUES
('miesieczny', 30, 1),
('miesieczny', 70, 0),
('kwartalny', 80, 1),
('kwartalny', 150, 0),
('semestralny', 300, 1),
('roczny', 350, 0)

go
create procedure DodajPracownika
(
    @id_typu_pracownika int,
    @imie nvarchar(30),
    @nazwisko nvarchar(30),
    @data_urodzenia date,
    @plec char,
    @data_zatrudnienia date,
    @pensja_podstawowa money,

    @var1 nvarchar(255) = null,
    @var2 nvarchar(255) = null,
    @var3 nvarchar(255) = null
)
as 
begin
    insert into Pracownicy values
    (
        @id_typu_pracownika, @imie, @nazwisko, @data_urodzenia,
        @plec, @data_zatrudnienia, @pensja_podstawowa
    )

        if @id_typu_pracownika = 1
            begin
            print 'Dodanie pracownika powiodlo sie'
            insert into PracownicyAdministracji values
            (SCOPE_IDENTITY(), convert(int, @var1))
            end

        else if @id_typu_pracownika = 2
            begin
            print 'Dodanie pracownika powiodlo sie'
            insert into Kierowcy values
            (SCOPE_IDENTITY(), convert(int, @var1), convert(date, @var2), convert(bit, @var3))
            end

        else if @id_typu_pracownika = 3
            begin
            print 'Dodanie pracownika powiodlo sie'
            insert into Motorniczowie values
            (SCOPE_IDENTITY(), convert(date, @var1))
            end

        else if @id_typu_pracownika = 4
            begin
            print 'Dodanie pracownika powiodlo sie'
            insert into Serwisanci values
            (SCOPE_IDENTITY(), convert(int, @var1))
            end

        else if @id_typu_pracownika = 5
            begin
            print 'Dodanie pracownika powiodlo sie'
            insert into SerwisSprzatajacy values
            (SCOPE_IDENTITY(), convert(int, @var1))
            end

        if @@error <> 0
            RAISERROR('Dodanie pracownika nie powiodlo sie', 16, 1)
end
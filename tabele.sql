create table TypyPracownikow
(
    id_typu_pracownika int primary key,
    typ_pracownika nvarchar(50) not null
)

create table Pracownicy
(
    id_pracownika int primary key identity(1, 1),
    id_typu_pracownika int references TypyPracownikow(id_typu_pracownika),
    imie nvarchar(30) not null,
    nazwisko nvarchar(30)not null,
    data_urodzenia date not null,
    plec char not null,
    data_zatrudnienia date not null,
    pensja_podstawowa money not null,

    check (plec = 'M' or plec = 'K'),
    check (pensja_podstawowa >= 2500),
    check (year(getdate()) - year(data_urodzenia) >= 18),

    constraint typ_pracownika_cs unique (id_pracownika, id_typu_pracownika)
)

alter table pracownicy
add constraint pracownicy_pelnoletni_ck
check (datediff(year, data_urodzenia, data_zatrudnienia) >= 18)

create table PracownicyAdministracji
(
    id_pracownika int primary key,
    id_typu_pracownika as 1 persisted,

    id_biura int,

    foreign key (id_biura) references Biura(id_biura),
    foreign key (id_pracownika, id_typu_pracownika) references Pracownicy(id_pracownika, id_typu_pracownika)
)

create table Kierowcy
(
    id_pracownika int primary key,
    id_typu_pracownika as 2 persisted,

    do_kiedy_badania date,
    czy_wada_wzroku bit,

    foreign key (id_pracownika, id_typu_pracownika) references Pracownicy(id_pracownika, id_typu_pracownika)
)

create table Motorniczowie
(
    id_pracownika int primary key,
    id_typu_pracownika as 3 persisted,

    do_kiedy_badania date,

    foreign key (id_pracownika, id_typu_pracownika) references Pracownicy(id_pracownika, id_typu_pracownika)    
)

create table Serwisanci
(
    id_pracownika int primary key,
    id_typu_pracownika as 4 persisted,

    foreign key (id_pracownika, id_typu_pracownika) references Pracownicy(id_pracownika, id_typu_pracownika)
)

create table SerwisSprzatajacy
(
    id_pracownika int primary key,
    id_typu_pracownika as 5 persisted,

    id_obslugiwanego_biura int,

    foreign key (id_pracownika, id_typu_pracownika) references Pracownicy(id_pracownika, id_typu_pracownika)
)

create table Certyfikaty
(
    id_certyfikatu int primary key,
    opis_certyfikatu nvarchar(256)
)

create table CertyfikatySerwisantow
(
    id_pracownika int,
    id_certyfikatu int, 
    do_kiedy date

    primary key(id_pracownika, id_certyfikatu),
    foreign key (id_certyfikatu) references Certyfikaty(id_certyfikatu)
)


create table Uprawnienia
(
    id_uprawnien int primary key,
    kod_uprawnien nvarchar(10),
    opis_uprawnien nvarchar(50),
    wymagany_wiek int
)

create table Biura
(
    id_biura int primary key,
    adres nvarchar(50),
    telefon nvarchar(12),
)

create table UprawnieniaKierujacychPojazdami
(
    id_uprawnien int,
    id_pracownika int, 
    do_kiedy date,

    primary key(id_uprawnien, id_pracownika),
    foreign key (id_pracownika) references Pracownicy(id_pracownika),
    foreign key (id_uprawnien) references uprawnienia(id_uprawnien)
)

create table Kursy
(
    id_kursu int primary key identity(1, 1),
    id_linii int,
    id_pracownika int,
    id_pojazdu int,
    data_wykonania_kursu date,

    foreign key (id_linii) references LinieInfo(id_linii),
    foreign key (id_pracownika) references Kierowcy(id_pracownika),
    foreign key (id_pojazdu) references Pojazdy(id_pojazdu) 
)

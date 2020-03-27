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


insert into TypyPracownikow VALUES
(1, 'administracja'),
(2, 'kierowca'),
(3, 'motorniczy'),
(4, 'serwisant'),
(5, 'serwis sprzatajacy')

create table PracownicyAdministracji
(
    id_pracownika int primary key,
    id_typu_pracownika as 1 persisted,

    id_biura int,

    foreign key (id_pracownika, id_typu_pracownika) references Pracownicy(id_pracownika, id_typu_pracownika)
)

create table Kierowcy
(
    id_pracownika int primary key,
    id_typu_pracownika as 2 persisted,

    id_uprawnien int,
    do_kiedy_badania date,
    czy_wada_wzroku bit,

    foreign key (id_uprawnien) references Uprawnienia(id_uprawnien),
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

    id_uprawnienia int,

    foreign key (id_uprawnienia) references UprawnieniaSerwisantow(id_uprawnienia),
    foreign key (id_pracownika, id_typu_pracownika) references Pracownicy(id_pracownika, id_typu_pracownika)
)


create table SerwisSprzatajacy
(
    id_pracownika int primary key,
    id_typu_pracownika as 5 persisted,

    id_obslugiwanego_biura int,

    foreign key (id_pracownika, id_typu_pracownika) references Pracownicy(id_pracownika, id_typu_pracownika)
)

create table UprawnieniaSerwisantow
(
    id_uprawnienia int primary key,
    opis_uprawnienia nvarchar(256)
)

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




select * from pracownicy p
join Kierowcy k on k.id_pracownika = p.id_pracownika
join Motorniczowie m on m.id_pracownika = p.id_pracownika

create table Uprawnienia
(
    id_uprawnien int primary key,
    kod_uprawnien nvarchar(10),
    opis_uprawnien nvarchar(50),
    wymagany_wiek int
)


insert into uprawnienia values 
(1, 'B', 'samochody osobowe do 3,5 tony', 18),
(2, 'B+E', 'samochody osobowe z przyczepa do 3,5 tony lacznie', 18),
(3, 'C', 'samochody ciezarowe powyzej 3,5 tony', 21),
(4, 'D', 'autobus', 24),
(5, 'D+E', 'autobus + przyczepa', 24),
(6, 'T', 'tramwaj', 21)

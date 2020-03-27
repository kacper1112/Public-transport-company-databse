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
begin tran
    insert into Pracownicy values
    (
        @id_typu_pracownika, @imie, @nazwisko, @data_urodzenia,
        @plec, @data_zatrudnienia, @pensja_podstawowa
    )
        if @@error <> 0
            begin
            RAISERROR('Dodanie pracownika nie powiodlo sie', 16, 1)
            rollback
            end

        if @id_typu_pracownika = 1
            begin
            insert into PracownicyAdministracji values
            (SCOPE_IDENTITY(), convert(int, @var1))
            end

        else if @id_typu_pracownika = 2
            begin
            insert into Kierowcy values
            (SCOPE_IDENTITY(), convert(date, @var1), convert(bit, @var2))
            end

        else if @id_typu_pracownika = 3
            begin
            insert into Motorniczowie values
            (SCOPE_IDENTITY(), convert(date, @var1))
            end

        else if @id_typu_pracownika = 4
            begin
            insert into Serwisanci values
            (SCOPE_IDENTITY())
            end

        else if @id_typu_pracownika = 5
            begin
            insert into SerwisSprzatajacy values
            (SCOPE_IDENTITY(), convert(int, @var1))
            end

        if @@error <> 0
            begin
            RAISERROR('Dodanie pracownika nie powiodlo sie', 16, 1)
            rollback
            end
        else
            print 'Dodanie pracownika powiodlo sie'
commit


go
create trigger odpowiednieUprawnienia on Kursy
after insert
as 
begin
    declare @id int
    declare @wymagane int
    set @id = (select id_pracownika from inserted)
    set @wymagane = (select id_wymaganych_uprawnien from pojazdy
                     where id_pojazdu = (select id_pojazdu from inserted))

    --print('Wymagane uprawnienia: ' + convert(nvarchar(30), @wymagane))


    if not exists (select * from UprawnieniaKierujac
    
    ychPojazdami
               where (id_pracownika = @id and @wymagane = id_uprawnien))
    begin
        print('Kierowca nie posiada odpowiednich uprawnien')
        rollback
    end
end

go
create trigger wazneUprawnienia on Kursy
after insert 
as 
begin
    
    declare @id int
    declare @typ int
    declare @termin date

    set @id = (select id_pracownika from inserted)
    set @typ = (select id_typu_pracownika from Pracownicy
                where id_pracownika = @id)

    if @typ = 2 --kierowca
    begin 
        set @termin = (select do_kiedy_badania from kierowcy
                       where id_pracownika = @id)
    end

    else if @typ = 3
    begin 
        set @termin = (select do_kiedy_badania from kierowcy
                       where id_pracownika = @id)
    end

    if @termin < (select data_wykonania_kursu from inserted)
    begin
        print('Kierowca ma niewazne badania!')
        rollback
    end
    
end 


select * from Kierowcy
select * from LinieInfo
select * from pojazdy
select * from kursy

drop trigger odpowiednieuprawnienia
drop trigger wazneuprawnienia

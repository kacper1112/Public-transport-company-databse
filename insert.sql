insert into TypyPracownikow VALUES
(1, 'administracja'),
(2, 'kierowca'),
(3, 'motorniczy'),
(4, 'serwisant'),
(5, 'serwis sprzatajacy')

insert into Uprawnienia values 
(1, 'B', 'samochody osobowe do 3,5 tony', 18),
(2, 'B+E', 'samochody osobowe z przyczepa do 3,5 tony lacznie', 18),
(3, 'C', 'samochody ciezarowe powyzej 3,5 tony', 21),
(4, 'D', 'autobus', 24),
(5, 'D+E', 'autobus + przyczepa', 24),
(6, 'T', 'tramwaj', 21),
(7, 'TB', 'Trolejbus', 24)

insert into Biura values
(1, 'Pogodna 15', '372819473'),
(2, 'Zwirowa 19', '635213792')

exec DodajPracownika 1, 'Janina', 'Nowak', '1977-09-13', 'K', '1999-10-11', 2800, 1
exec DodajPracownika 1, 'Stanislaw', 'Kowalski', '1965-11-10', 'M', '2003-11-10', 3500, 1
exec DodajPracownika 1, 'Pawel', 'Baran', '1983-03-19', 'M', '2007-11-15', 8700, 2
exec DodajPracownika 1, 'Gawel', 'Gwozdz', '1978-10-23', 'M', '1997-02-01', 3800, 2

exec DodajPracownika 2, 'Marian', 'Pazdzioch', '1964-06-01', 'M', '1986-06-03', 4500, '2030-01-01', 1
exec DodajPracownika 2, 'Jan', 'Widera', '1990-10-10', 'M', '2008-11-07', 3400, '2020-01-01', 0
exec DodajPracownika 2, 'Maria', 'Polak', '1998-05-08', 'K', '2019-02-03', 2500, '2025-01-01', 0  
exec DodajPracownika 2, 'Stanislaw', 'Bujakowski', '1975-03-30', 'M', '2000-02-03', 2600, '2025-01-01', 1  
exec DodajPracownika 2, 'Marta', 'Niemiec', '1977-05-08', 'K', '2005-02-03', 4000, '2030-01-01', 1 
exec DodajPracownika 2, 'Jozef', 'Janusz', '2001-04-18', 'M', '2020-01-20', 2500, '2025-01-01', 0  
exec DodajPracownika 2, 'Eustachy', 'Piorun', '1968-09-12', 'M', '2004-09-11', 6800, '2028-01-01', 1  
exec DodajPracownika 2, 'Wieslaw', 'Walczak', '2000-01-02', 'M', '2018-05-03', 2500, '2030-01-01', 0  
exec DodajPracownika 2, 'Zofia', 'Kasprzak', '1979-11-18', 'K', '1998-01-15', 4500, '2035-01-01', 1  

exec DodajPracownika 3, 'Karol', 'Krawczyk', '1969-12-18', 'M', '1990-03-19', 4500, '2035-01-01'
exec DodajPracownika 3, 'Tadeusz', 'Norek', '1970-05-20', 'M', '1992-04-10', 4000, '2040-01-01'
exec DodajPracownika 3, 'Stanislaw', 'Wesolowski', '1957-01-10', 'M', '1982-04-10', 5000, '2025-01-01'
exec DodajPracownika 3, 'Marian', 'Szkatulka', '1970-04-13', 'M', '1989-06-19', 4700, '2030-01-01'


exec DodajPracownika 4, 'Zenon', 'Krasnal', '1999-03-25', 'M', '2019-04-15', 2700
exec DodajPracownika 4, 'Jozef', 'Panek', '1970-08-13', 'M', '1989-02-15', 4700
exec DodajPracownika 4, 'Mariusz', 'Autobusowy', '1990-09-30', 'M', '2011-09-11', 4000

exec DodajPracownika 5, 'Genowefa', 'Stara', '1950-03-01', 'K', '1970-04-18', 2700, 1
exec DodajPracownika 5, 'Stanislaw', 'Stary', '1951-07-29', 'M', '1970-04-18', 2700, 2



insert into UprawnieniaKierujacychPojazdami values
(1, 5, '2030-01-01'),
(1,	6, '2020-01-01'),
(1,	7, '2025-01-01'),
(1,	8, '2025-01-01'),
(1,	9, '2030-01-01'),
(1,	10, '2025-01-01'),
(1,	11, '2028-01-01'),
(1,	12, '2030-01-01'),
(1,	13, '2035-01-01'), 
(1,	14, '2030-01-01'),
(1,	15, '2030-01-01'),
(1,	16, '2030-01-01'), --prawo jazdy B dla wszystkich

(4, 5, '2030-01-01'),
(4,	6, '2020-01-01'),
(4,	7, '2025-01-01'),
(5,	8, '2025-01-01'),
(5,	9, '2030-01-01'),
(7,	10, '2025-01-01'),
(7,	11, '2028-01-01'),
(7,	12, '2030-01-01'),
(7,	13, '2035-01-01'),  --autobusy + trolejbusy

(6, 14, '2035-01-01'),
(6, 15, '2040-01-01'),
(6, 16, '2025-01-01'),
(6, 17, '2030-01-01') --motornicznowie



select * from pracownicy 
select * from Kierowcy
select * from Motorniczowie

select * from Uprawnienia
select * from UprawnieniaKierujacychPojazdami
select * from Kierowcy

DBCC CHECKIDENT ('Pracownicy', RESEED, 21); 


/*
Created: 11/22/2020
Modified: 11/28/2020
Model: Jednostka Akademicka BDBT
Database: Oracle 12c
*/


-- Create sequences section -------------------------------------------------

CREATE SEQUENCE UczelnieSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE WydzialySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE PracownicySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE StudenciSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE InstytutySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE RektorzySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE PocztySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE WynagrodzeniaSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE JezykiSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE Poziomy_jezykowSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE Biura_dziekanatuSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE PrzedmiotySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE AdresySeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE StanowiskaSeq1
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

-- Create tables section -------------------------------------------------

-- Table Uczelnie

CREATE TABLE Uczelnie(
  Nr_uczelni Integer NOT NULL,
  Nazwa Varchar2(60 ) NOT NULL,
  Typ_uczelni Varchar2(20 ) NOT NULL
        CHECK (Typ_uczelni IN ('Politechnika','Uniwersytet','Rolnicza','Ekonomiczna','Medyczna','Wojskowa','Inna')),
  Rodzaj Varchar2(10 ) NOT NULL
        CHECK (Rodzaj IN ('Prywatna','Publiczna')),
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Uczelnie

CREATE INDEX Uczelnia_ma_adres ON Uczelnie (Nr_adresu)
/

-- Add keys for table Uczelnie

ALTER TABLE Uczelnie ADD CONSTRAINT Uczelnia_PK PRIMARY KEY (Nr_uczelni)
/

-- Table and Columns comments section

COMMENT ON COLUMN Uczelnie.Nr_uczelni IS 'Unikalny identyfikator uczelni
'
/
COMMENT ON COLUMN Uczelnie.Nazwa IS 'Nazwa uczelni'
/
COMMENT ON COLUMN Uczelnie.Typ_uczelni IS 'Typ uczelni, czyli: uniwersytet, politechnika  itp'
/
COMMENT ON COLUMN Uczelnie.Rodzaj IS 'Rodzaj uczelni czyli, prywatna lub publiczna'
/

-- Table Pracownicy

CREATE TABLE Pracownicy(
  Nr_pracownika Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(20 ) NOT NULL,
  Data_urodzenia Date NOT NULL,
  Plec Char(1 ) NOT NULL
        CHECK (Plec IN ('K','M')),
  PESEL Char(11 ),
  Data_zatrudnienia Date NOT NULL,
  Data_zwolnienia Date,
  Nr_telefonu Varchar2(9 ) NOT NULL,
  Email Varchar2(50 ) NOT NULL,
  Nr_uczelni Integer NOT NULL,
  Nr_wydzialu Integer NOT NULL,
  Nr_adresu Integer NOT NULL,
  Nr_stanowiska Integer NOT NULL,
  Jezyk Char(20 )
)
/

-- Create indexes for table Pracownicy

CREATE INDEX IX_Zatrudnia ON Pracownicy (Nr_uczelni)
/

CREATE INDEX IX_Pracuje ON Pracownicy (Nr_wydzialu)
/

CREATE INDEX Pracownik_ma_adres ON Pracownicy (Nr_adresu)
/

CREATE INDEX Pracownik_ma_stanowisko ON Pracownicy (Nr_stanowiska)
/

-- Add keys for table Pracownicy

ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_PK PRIMARY KEY (Nr_pracownika)
/

-- Table and Columns comments section

COMMENT ON COLUMN Pracownicy.Nr_pracownika IS 'Unikalny identyfikator pracownika
'
/
COMMENT ON COLUMN Pracownicy.Imie IS 'Imie pracownika'
/
COMMENT ON COLUMN Pracownicy.Nazwisko IS 'Nazwisko pracownika'
/
COMMENT ON COLUMN Pracownicy.Data_urodzenia IS 'Data urodzenia pracownika'
/
COMMENT ON COLUMN Pracownicy.Plec IS 'Plec pracownika'
/
COMMENT ON COLUMN Pracownicy.PESEL IS 'Pesel pracownika'
/
COMMENT ON COLUMN Pracownicy.Data_zatrudnienia IS 'Data zatrudnienia pracownika'
/
COMMENT ON COLUMN Pracownicy.Data_zwolnienia IS 'Data zwolnienia pracownika'
/
COMMENT ON COLUMN Pracownicy.Nr_telefonu IS 'Numer telefonu pracownika'
/
COMMENT ON COLUMN Pracownicy.Email IS 'Email pracownika'
/

-- Table Naukowo_dydaktyczni

CREATE TABLE Naukowo_dydaktyczni(
  Nr_pracownika Integer NOT NULL,
  Tytul_naukowy Varchar2(30 ) NOT NULL,
  Jezyk Varchar2(60 ) NOT NULL,
  OKNO Char(1 ) NOT NULL
        CHECK (OKNO IN ('T','N'))
)
/

-- Add keys for table Naukowo_dydaktyczni

ALTER TABLE Naukowo_dydaktyczni ADD CONSTRAINT Unique_Identifier9 PRIMARY KEY (Nr_pracownika)
/

-- Table and Columns comments section

COMMENT ON COLUMN Naukowo_dydaktyczni.Tytul_naukowy IS 'Tytul naukowy'
/
COMMENT ON COLUMN Naukowo_dydaktyczni.Jezyk IS 'Jezyk, pole segmentowe {jezyk, poziom znajomosci}, pole wielowartosciowe'
/
COMMENT ON COLUMN Naukowo_dydaktyczni.OKNO IS 'Czy dany pracownik wyklada przedmiot zdalnie , np w przypadku PW przez OKNO'
/

-- Table Administracyjni

CREATE TABLE Administracyjni(
  Nr_pracownika Integer NOT NULL,
  Jezyk Varchar2(60 ) NOT NULL,
  MS_Office Char(1 ) NOT NULL
        CHECK (MS_Office IN ('T','N')),
  Nr_biura_dziekanatu Integer NOT NULL
)
/

-- Create indexes for table Administracyjni

CREATE INDEX IX_Dziekanat_zatrudnia ON Administracyjni (Nr_biura_dziekanatu)
/

-- Add keys for table Administracyjni

ALTER TABLE Administracyjni ADD CONSTRAINT Unique_Identifier10 PRIMARY KEY (Nr_pracownika)
/

-- Table and Columns comments section

COMMENT ON COLUMN Administracyjni.Jezyk IS 'Jezyk, pole segmentowe {jezyk, poziom znajomosci}, pole wielowartosciowe'
/
COMMENT ON COLUMN Administracyjni.MS_Office IS 'Czy pracownik ma znajomosc pakietu MS Office'
/

-- Table Wydzialy

CREATE TABLE Wydzialy(
  Nr_wydzialu Integer NOT NULL,
  Nazwa Varchar2(60 ) NOT NULL,
  Nr_uczelni Integer NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Wydzialy

CREATE INDEX IX_Jest_w_posiadaniu ON Wydzialy (Nr_uczelni)
/

CREATE INDEX Wydzial_ma_adres ON Wydzialy (Nr_adresu)
/

-- Add keys for table Wydzialy

ALTER TABLE Wydzialy ADD CONSTRAINT Wydzial_PK PRIMARY KEY (Nr_wydzialu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Wydzialy.Nr_wydzialu IS 'Unikatowy identyfikator wydzialu'
/
COMMENT ON COLUMN Wydzialy.Nazwa IS 'Nazwa wydzialu'
/

-- Table Studenci

CREATE TABLE Studenci(
  Nr_studenta Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(20 ) NOT NULL,
  PESEL Char(11 ),
  Nr_indeksu Varchar2(6 ) NOT NULL,
  Plec Char(1 ) NOT NULL
        CHECK (Plec IN ('K','M')),
  Data_urodzenia Date NOT NULL,
  Email Varchar2(50 ) NOT NULL,
  Nr_telefonu Varchar2(9 ) NOT NULL,
  Stopien_studiow Varchar2(50 ) NOT NULL,
  Kierunek_studiow Varchar2(60 ) NOT NULL,
  Nr_uczelni Integer NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Studenci

CREATE INDEX IX_Przyjmuje ON Studenci (Nr_uczelni)
/

CREATE INDEX Student_ma_adres ON Studenci (Nr_adresu)
/

-- Add keys for table Studenci

ALTER TABLE Studenci ADD CONSTRAINT Student_PK PRIMARY KEY (Nr_studenta)
/

ALTER TABLE Studenci ADD CONSTRAINT Nr_indeksu UNIQUE (Nr_indeksu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Studenci.Nr_studenta IS 'Unikatowy identyfikator studenta'
/
COMMENT ON COLUMN Studenci.Imie IS 'Imie studenta'
/
COMMENT ON COLUMN Studenci.Nazwisko IS 'Nazwisko studenta'
/
COMMENT ON COLUMN Studenci.PESEL IS 'Pesel studenta'
/
COMMENT ON COLUMN Studenci.Nr_indeksu IS 'Numer indeksu studenta'
/
COMMENT ON COLUMN Studenci.Plec IS 'Plec studenta'
/
COMMENT ON COLUMN Studenci.Data_urodzenia IS 'Data urodzenia studenta'
/
COMMENT ON COLUMN Studenci.Email IS 'Email studenta'
/
COMMENT ON COLUMN Studenci.Nr_telefonu IS 'Numer telefonu studenta'
/
COMMENT ON COLUMN Studenci.Stopien_studiow IS 'Stopien studiow '
/
COMMENT ON COLUMN Studenci.Kierunek_studiow IS 'Kierunek studiow'
/

-- Table Przedmioty

CREATE TABLE Przedmioty(
  Nr_przedmiotu Integer NOT NULL,
  Nazwa Varchar2(60 ) NOT NULL,
  Liczba_godzin Integer NOT NULL,
  ECTS Integer NOT NULL,
  Nr_pracownika Integer NOT NULL,
  Nr_instytutu Integer NOT NULL
)
/

-- Create indexes for table Przedmioty

CREATE INDEX IX_Relationship111 ON Przedmioty (Nr_pracownika)
/

CREATE INDEX IX_Relationship11 ON Przedmioty (Nr_instytutu)
/

-- Add keys for table Przedmioty

ALTER TABLE Przedmioty ADD CONSTRAINT Przedmiot_PK PRIMARY KEY (Nr_przedmiotu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Przedmioty.Nr_przedmiotu IS 'Unikatowy identyfikator przedmiotu'
/
COMMENT ON COLUMN Przedmioty.Nazwa IS 'Nazwa przedmiotu'
/
COMMENT ON COLUMN Przedmioty.Liczba_godzin IS 'Liczba godzin'
/
COMMENT ON COLUMN Przedmioty.ECTS IS 'ECTS za dany przedmiot'
/

-- Table Biura_dziekanatu

CREATE TABLE Biura_dziekanatu(
  Nr_biura_dziekanatu Integer NOT NULL,
  Pokoj Integer NOT NULL,
  Nr_telefonu Varchar2(9 ) NOT NULL,
  Sekcja Varchar2(100 ) NOT NULL,
  Nr_wydzialu Integer NOT NULL
)
/

-- Create indexes for table Biura_dziekanatu

CREATE INDEX IX_Wydzial_posiada_biuro_dziek ON Biura_dziekanatu (Nr_wydzialu)
/

-- Add keys for table Biura_dziekanatu

ALTER TABLE Biura_dziekanatu ADD CONSTRAINT Dziekanat_PK PRIMARY KEY (Nr_biura_dziekanatu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Biura_dziekanatu.Nr_biura_dziekanatu IS 'Unikatowy identyfikator biura dziekanatu'
/
COMMENT ON COLUMN Biura_dziekanatu.Pokoj IS 'Pokoj danego biura dziekanatu'
/
COMMENT ON COLUMN Biura_dziekanatu.Nr_telefonu IS 'numer telefonu do danego biura dziekanatu
'
/
COMMENT ON COLUMN Biura_dziekanatu.Sekcja IS 'Sekcja dziekanatu np: do spraw studenckich itp'
/

-- Table Instytuty

CREATE TABLE Instytuty(
  Nr_instytutu Integer NOT NULL,
  Nazwa Varchar2(60 ) NOT NULL,
  Nr_wydzialu Integer NOT NULL
)
/

-- Create indexes for table Instytuty

CREATE INDEX Wydzial_posiada_instytut ON Instytuty (Nr_wydzialu)
/

-- Add keys for table Instytuty

ALTER TABLE Instytuty ADD CONSTRAINT Instytut_PK PRIMARY KEY (Nr_instytutu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Instytuty.Nr_instytutu IS 'Unikatowy identyfikator instytutu'
/
COMMENT ON COLUMN Instytuty.Nazwa IS 'Nazwa instytutu'
/

-- Table Wydzialy_studenci

CREATE TABLE Wydzialy_studenci(
  Nr_wydzialu Integer NOT NULL,
  Nr_indeksu Integer NOT NULL
)
/

-- Table Zapisy

CREATE TABLE Zapisy(
  Nr_indeksu Integer NOT NULL,
  Nr_przedmiotu Integer NOT NULL,
  Ocena_koncowa Number(1,1)
)
/

-- Table Prowadzacy

CREATE TABLE Prowadzacy(
  Nr_przedmiotu Integer NOT NULL,
  Nr_pracownika Integer NOT NULL
)
/

-- Table Adresy

CREATE TABLE Adresy(
  Nr_adresu Integer NOT NULL,
  Miasto Varchar2(30 ) NOT NULL,
  Ulica Varchar2(30 ) NOT NULL,
  Nr_lokalu Varchar2(5 ) NOT NULL,
  Nr_poczty Integer NOT NULL
)
/

-- Create indexes for table Adresy

CREATE INDEX IX_Relationship21 ON Adresy (Nr_poczty)
/

-- Add keys for table Adresy

ALTER TABLE Adresy ADD CONSTRAINT PK_Adresy PRIMARY KEY (Nr_adresu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Adresy.Nr_adresu IS 'Unikatowy identyfikator adresu'
/
COMMENT ON COLUMN Adresy.Miasto IS 'Miasto'
/
COMMENT ON COLUMN Adresy.Ulica IS 'Ulica'
/
COMMENT ON COLUMN Adresy.Nr_lokalu IS 'Numer lokalu'
/

-- Table Poczty

CREATE TABLE Poczty(
  Nr_poczty Integer NOT NULL,
  Kod_poczty Varchar2(6 ) NOT NULL,
  Poczta Varchar2(20 ) NOT NULL
)
/

-- Add keys for table Poczty

ALTER TABLE Poczty ADD CONSTRAINT PK_Poczty PRIMARY KEY (Nr_poczty)
/

ALTER TABLE Poczty ADD CONSTRAINT Kod_poczty UNIQUE (Kod_poczty)
/

-- Table and Columns comments section

COMMENT ON COLUMN Poczty.Nr_poczty IS 'Unikalny identyfikator poczty'
/
COMMENT ON COLUMN Poczty.Kod_poczty IS 'Kod poczty'
/
COMMENT ON COLUMN Poczty.Poczta IS 'Lokalizacja poczty'
/

-- Table Stanowiska

CREATE TABLE Stanowiska(
  Nr_stanowiska Integer NOT NULL,
  Nazwa_stanowiska Varchar2(50 ) NOT NULL,
  Opis Varchar2(400 ) NOT NULL
)
/

-- Add keys for table Stanowiska

ALTER TABLE Stanowiska ADD CONSTRAINT PK_Stanowiska PRIMARY KEY (Nr_stanowiska)
/

ALTER TABLE Stanowiska ADD CONSTRAINT Nazwa_stanowiska UNIQUE (Nazwa_stanowiska)
/

-- Table and Columns comments section

COMMENT ON COLUMN Stanowiska.Nr_stanowiska IS 'Unikatowy identyfikator stanowiska'
/
COMMENT ON COLUMN Stanowiska.Nazwa_stanowiska IS 'Nazwa stanowiska '
/
COMMENT ON COLUMN Stanowiska.Opis IS 'Opis stanowiska'
/

-- Table Wynagrodzenia

CREATE TABLE Wynagrodzenia(
  Nr_wynagrodzenia Integer NOT NULL,
  Data Date NOT NULL,
  Kwoda_pod Number(8,2) NOT NULL,
  Kwoda_dod Number(8,2),
  Nr_pracownika Integer NOT NULL
)
/

-- Create indexes for table Wynagrodzenia

CREATE INDEX Otrzymuje_wynagrodzenie ON Wynagrodzenia (Nr_pracownika)
/

-- Add keys for table Wynagrodzenia

ALTER TABLE Wynagrodzenia ADD CONSTRAINT PK_Wynagrodzenia PRIMARY KEY (Nr_wynagrodzenia)
/

-- Table and Columns comments section

COMMENT ON COLUMN Wynagrodzenia.Nr_wynagrodzenia IS 'Unikatowy identyfikator wynagrodzenia'
/
COMMENT ON COLUMN Wynagrodzenia.Data IS 'Data wyplaty wynagrodzenia'
/
COMMENT ON COLUMN Wynagrodzenia.Kwoda_pod IS 'Kwota podstawowa'
/
COMMENT ON COLUMN Wynagrodzenia.Kwoda_dod IS 'Kwota dodatkowa'
/

-- Table Rektorzy

CREATE TABLE Rektorzy(
  Nr_rektora Integer NOT NULL,
  Imie Varchar2(30 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Data_urodzenia Date NOT NULL,
  Nr_uczelni Integer NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Rektorzy

CREATE INDEX Rektor_ma_adres ON Rektorzy (Nr_adresu)
/

CREATE INDEX Uczelnia_ma_rektora ON Rektorzy (Nr_uczelni)
/

-- Add keys for table Rektorzy

ALTER TABLE Rektorzy ADD CONSTRAINT PK_Rektorzy PRIMARY KEY (Nr_rektora)
/

-- Table and Columns comments section

COMMENT ON COLUMN Rektorzy.Nr_rektora IS 'Unikalny identyfikator rektora'
/
COMMENT ON COLUMN Rektorzy.Imie IS 'Imie rektora'
/
COMMENT ON COLUMN Rektorzy.Nazwisko IS 'Nazwisko rektora'
/
COMMENT ON COLUMN Rektorzy.Data_urodzenia IS 'Data urodzenia'
/

-- Table Jezyki

CREATE TABLE Jezyki(
  Nr_jezyka Integer NOT NULL,
  Kod_jezyka Varchar2(2 ) NOT NULL,
  Nazwa Varchar2(20 ) NOT NULL
)
/

-- Add keys for table Jezyki

ALTER TABLE Jezyki ADD CONSTRAINT PK_Jezyki PRIMARY KEY (Nr_jezyka)
/

-- Table and Columns comments section

COMMENT ON COLUMN Jezyki.Nr_jezyka IS 'Unikatowy identyfikator jezyka'
/
COMMENT ON COLUMN Jezyki.Kod_jezyka IS 'Kod jezyka zgodnie ze standardem ISO'
/
COMMENT ON COLUMN Jezyki.Nazwa IS 'Nazwa jezyka'
/

-- Table Poziomy_jezykow

CREATE TABLE Poziomy_jezykow(
  Nr_poziomu Integer NOT NULL,
  Kod_poziomu Varchar2(3 ) NOT NULL,
  Opis Varchar2(800 ) NOT NULL
)
/

-- Add keys for table Poziomy_jezykow

ALTER TABLE Poziomy_jezykow ADD CONSTRAINT PK_Poziomy_jezykow PRIMARY KEY (Nr_poziomu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Poziomy_jezykow.Nr_poziomu IS 'Unikatowy identyfikator poziomu znajomosci jezyka'
/
COMMENT ON COLUMN Poziomy_jezykow.Kod_poziomu IS 'Kod poziomu znajomosci jezyka'
/
COMMENT ON COLUMN Poziomy_jezykow.Opis IS 'Opis wymagan'
/

-- Table Znajomosc_jezykow

CREATE TABLE Znajomosc_jezykow(
  Nr_poziomu Integer NOT NULL,
  Attribute1 Integer NOT NULL,
  Nr_pracownika Integer NOT NULL
)
/

-- Create indexes for table Znajomosc_jezykow

CREATE INDEX Jest_znany_na_poziomie ON Znajomosc_jezykow (Nr_poziomu)
/

-- Add keys for table Znajomosc_jezykow

ALTER TABLE Znajomosc_jezykow ADD CONSTRAINT PK_Znajomosc_jezykow PRIMARY KEY (Attribute1,Nr_pracownika)
/

-- Trigger for sequence UczelnieSeq1 for column Nr_uczelni in table Uczelnie ---------
CREATE OR REPLACE TRIGGER ts_Uczelnie_UczelnieSeq1 BEFORE INSERT
ON Uczelnie FOR EACH ROW
BEGIN
  :new.Nr_uczelni := UczelnieSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Uczelnie_UczelnieSeq1 AFTER UPDATE OF Nr_uczelni
ON Uczelnie FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_uczelni in table Uczelnie as it uses sequence.');
END;
/

-- Trigger for sequence PracownicySeq1 for column Nr_pracownika in table Pracownicy ---------
CREATE OR REPLACE TRIGGER ts_Pracownicy_PracownicySeq1 BEFORE INSERT
ON Pracownicy FOR EACH ROW
BEGIN
  :new.Nr_pracownika := PracownicySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Pracownicy_PracownicySeq1 AFTER UPDATE OF Nr_pracownika
ON Pracownicy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_pracownika in table Pracownicy as it uses sequence.');
END;
/

-- Trigger for sequence WydzialySeq1 for column Nr_wydzialu in table Wydzialy ---------
CREATE OR REPLACE TRIGGER ts_Wydzialy_WydzialySeq1 BEFORE INSERT
ON Wydzialy FOR EACH ROW
BEGIN
  :new.Nr_wydzialu := WydzialySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Wydzialy_WydzialySeq1 AFTER UPDATE OF Nr_wydzialu
ON Wydzialy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_wydzialu in table Wydzialy as it uses sequence.');
END;
/

-- Trigger for sequence StudenciSeq1 for column Nr_studenta in table Studenci ---------
CREATE OR REPLACE TRIGGER ts_Studenci_StudenciSeq1 BEFORE INSERT
ON Studenci FOR EACH ROW
BEGIN
  :new.Nr_studenta := StudenciSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Studenci_StudenciSeq1 AFTER UPDATE OF Nr_studenta
ON Studenci FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_studenta in table Studenci as it uses sequence.');
END;
/

-- Trigger for sequence PrzedmiotySeq1 for column Nr_przedmiotu in table Przedmioty ---------
CREATE OR REPLACE TRIGGER ts_Przedmioty_PrzedmiotySeq1 BEFORE INSERT
ON Przedmioty FOR EACH ROW
BEGIN
  :new.Nr_przedmiotu := PrzedmiotySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Przedmioty_PrzedmiotySeq1 AFTER UPDATE OF Nr_przedmiotu
ON Przedmioty FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_przedmiotu in table Przedmioty as it uses sequence.');
END;
/

-- Trigger for sequence Biura_dziekanatuSeq1 for column Nr_biura_dziekanatu in table Biura_dziekanatu ---------
CREATE OR REPLACE TRIGGER ts_Biura_dziekanatu_Biura_dz_0 BEFORE INSERT
ON Biura_dziekanatu FOR EACH ROW
BEGIN
  :new.Nr_biura_dziekanatu := Biura_dziekanatuSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Biura_dziekanatu_Biura_d_0 AFTER UPDATE OF Nr_biura_dziekanatu
ON Biura_dziekanatu FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_biura_dziekanatu in table Biura_dziekanatu as it uses sequence.');
END;
/

-- Trigger for sequence InstytutySeq1 for column Nr_instytutu in table Instytuty ---------
CREATE OR REPLACE TRIGGER ts_Instytuty_InstytutySeq1 BEFORE INSERT
ON Instytuty FOR EACH ROW
BEGIN
  :new.Nr_instytutu := InstytutySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Instytuty_InstytutySeq1 AFTER UPDATE OF Nr_instytutu
ON Instytuty FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_instytutu in table Instytuty as it uses sequence.');
END;
/

-- Trigger for sequence AdresySeq1 for column Nr_adresu in table Adresy ---------
CREATE OR REPLACE TRIGGER ts_Adresy_AdresySeq1 BEFORE INSERT
ON Adresy FOR EACH ROW
BEGIN
  :new.Nr_adresu := AdresySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Adresy_AdresySeq1 AFTER UPDATE OF Nr_adresu
ON Adresy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_adresu in table Adresy as it uses sequence.');
END;
/

-- Trigger for sequence PocztySeq1 for column Nr_poczty in table Poczty ---------
CREATE OR REPLACE TRIGGER ts_Poczty_PocztySeq1 BEFORE INSERT
ON Poczty FOR EACH ROW
BEGIN
  :new.Nr_poczty := PocztySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Poczty_PocztySeq1 AFTER UPDATE OF Nr_poczty
ON Poczty FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_poczty in table Poczty as it uses sequence.');
END;
/

-- Trigger for sequence StanowiskaSeq1 for column Nr_stanowiska in table Stanowiska ---------
CREATE OR REPLACE TRIGGER ts_Stanowiska_StanowiskaSeq1 BEFORE INSERT
ON Stanowiska FOR EACH ROW
BEGIN
  :new.Nr_stanowiska := StanowiskaSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Stanowiska_StanowiskaSeq1 AFTER UPDATE OF Nr_stanowiska
ON Stanowiska FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_stanowiska in table Stanowiska as it uses sequence.');
END;
/

-- Trigger for sequence WynagrodzeniaSeq1 for column Nr_wynagrodzenia in table Wynagrodzenia ---------
CREATE OR REPLACE TRIGGER ts_Wynagrodzenia_Wynagrodzen_0 BEFORE INSERT
ON Wynagrodzenia FOR EACH ROW
BEGIN
  :new.Nr_wynagrodzenia := WynagrodzeniaSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Wynagrodzenia_Wynagrodze_0 AFTER UPDATE OF Nr_wynagrodzenia
ON Wynagrodzenia FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_wynagrodzenia in table Wynagrodzenia as it uses sequence.');
END;
/

-- Trigger for sequence RektorzySeq1 for column Nr_rektora in table Rektorzy ---------
CREATE OR REPLACE TRIGGER ts_Rektorzy_RektorzySeq1 BEFORE INSERT
ON Rektorzy FOR EACH ROW
BEGIN
  :new.Nr_rektora := RektorzySeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Rektorzy_RektorzySeq1 AFTER UPDATE OF Nr_rektora
ON Rektorzy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_rektora in table Rektorzy as it uses sequence.');
END;
/

-- Trigger for sequence JezykiSeq1 for column Nr_jezyka in table Jezyki ---------
CREATE OR REPLACE TRIGGER ts_Jezyki_JezykiSeq1 BEFORE INSERT
ON Jezyki FOR EACH ROW
BEGIN
  :new.Nr_jezyka := JezykiSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Jezyki_JezykiSeq1 AFTER UPDATE OF Nr_jezyka
ON Jezyki FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_jezyka in table Jezyki as it uses sequence.');
END;
/

-- Trigger for sequence Poziomy_jezykowSeq1 for column Nr_poziomu in table Poziomy_jezykow ---------
CREATE OR REPLACE TRIGGER ts_Poziomy_jezykow_Poziomy_j_0 BEFORE INSERT
ON Poziomy_jezykow FOR EACH ROW
BEGIN
  :new.Nr_poziomu := Poziomy_jezykowSeq1.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Poziomy_jezykow_Poziomy__0 AFTER UPDATE OF Nr_poziomu
ON Poziomy_jezykow FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Nr_poziomu in table Poziomy_jezykow as it uses sequence.');
END;
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE Pracownicy ADD CONSTRAINT Zatrudnia FOREIGN KEY (Nr_uczelni) REFERENCES Uczelnie (Nr_uczelni)
/



ALTER TABLE Studenci ADD CONSTRAINT Przyjmuje FOREIGN KEY (Nr_uczelni) REFERENCES Uczelnie (Nr_uczelni)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracuje FOREIGN KEY (Nr_wydzialu) REFERENCES Wydzialy (Nr_wydzialu)
/



ALTER TABLE Administracyjni ADD CONSTRAINT Dziekanat_zatrudnia FOREIGN KEY (Nr_biura_dziekanatu) REFERENCES Biura_dziekanatu (Nr_biura_dziekanatu)
/



ALTER TABLE Wydzialy ADD CONSTRAINT Uczelnia_posiada_wydzial FOREIGN KEY (Nr_uczelni) REFERENCES Uczelnie (Nr_uczelni)
/



ALTER TABLE Instytuty ADD CONSTRAINT Wydzial_posiada_instytut FOREIGN KEY (Nr_wydzialu) REFERENCES Wydzialy (Nr_wydzialu)
/



ALTER TABLE Biura_dziekanatu ADD CONSTRAINT Wydzial_posiada_biuro_dziekanatu FOREIGN KEY (Nr_wydzialu) REFERENCES Wydzialy (Nr_wydzialu)
/



ALTER TABLE Uczelnie ADD CONSTRAINT Uczelnia_ma_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Adresy ADD CONSTRAINT Adresy_maja_poczty FOREIGN KEY (Nr_poczty) REFERENCES Poczty (Nr_poczty)
/



ALTER TABLE Wydzialy ADD CONSTRAINT Wydzial_ma_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Studenci ADD CONSTRAINT Student_ma_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_ma_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_ma_stanowisko FOREIGN KEY (Nr_stanowiska) REFERENCES Stanowiska (Nr_stanowiska)
/



ALTER TABLE Wynagrodzenia ADD CONSTRAINT Otrzymuje_wynagrodzenie FOREIGN KEY (Nr_pracownika) REFERENCES Pracownicy (Nr_pracownika)
/



ALTER TABLE Przedmioty ADD CONSTRAINT Prowadzi_przedmiot FOREIGN KEY (Nr_pracownika) REFERENCES Naukowo_dydaktyczni (Nr_pracownika)
/



ALTER TABLE Rektorzy ADD CONSTRAINT Rektor_ma_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Rektorzy ADD CONSTRAINT Uczelnia_ma_rektora FOREIGN KEY (Nr_uczelni) REFERENCES Uczelnie (Nr_uczelni)
/



ALTER TABLE Zapisy ADD CONSTRAINT Zapis_na_przedmiot FOREIGN KEY (Nr_przedmiotu) REFERENCES Przedmioty (Nr_przedmiotu)
/



ALTER TABLE Przedmioty ADD CONSTRAINT Instytut_prowadzi_przedmiot FOREIGN KEY (Nr_instytutu) REFERENCES Instytuty (Nr_instytutu)
/



ALTER TABLE Znajomosc_jezykow ADD CONSTRAINT Jest_znany_na_poziomie FOREIGN KEY (Nr_poziomu) REFERENCES Poziomy_jezykow (Nr_poziomu)
/



ALTER TABLE Znajomosc_jezykow ADD CONSTRAINT Jezyk_jest_znany FOREIGN KEY (Attribute1) REFERENCES Jezyki (Nr_jezyka)
/



ALTER TABLE Administracyjni ADD CONSTRAINT Pracownik_administracyjny FOREIGN KEY (Nr_pracownika) REFERENCES Pracownicy (Nr_pracownika)
/



ALTER TABLE Znajomosc_jezykow ADD CONSTRAINT Naukowo_dydaktyczny_zna_jezyk FOREIGN KEY (Nr_pracownika) REFERENCES Naukowo_dydaktyczni (Nr_pracownika)
/



ALTER TABLE Znajomosc_jezykow ADD CONSTRAINT Administracyjny_zna_jezyk FOREIGN KEY (Nr_pracownika) REFERENCES Administracyjni (Nr_pracownika)
/






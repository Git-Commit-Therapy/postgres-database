DO $$
    BEGIN
    CREATE TYPE "Severity" AS ENUM ('WHITE', 'GREEN', 'YELLOW', 'ORANGE', 'RED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE TABLE IF NOT EXISTS "Ward" (
    "WardID" SERIAL PRIMARY KEY,
    "Name" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "User" (
    "ID" CHAR(16) PRIMARY KEY,
    "Name" TEXT NOT NULL,
    "Surname" TEXT NOT NULL,
    "DateOfBirth" DATE NOT NULL,
    "SID" CHAR(50) NOT NULL UNIQUE,
    "PhoneNumber" CHAR(15)
);

CREATE INDEX IF NOT EXISTS idx_user_id ON "User"("ID");
CREATE INDEX IF NOT EXISTS idx_user_sid ON "User"("SID");

CREATE TABLE IF NOT EXISTS "Staff" (
    "StaffID" CHAR(16) REFERENCES "User"("ID") PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS "Patient" (
    "PatientID" CHAR(16) REFERENCES "User"("ID") PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS "Doctor" (
    "DoctorID" CHAR(16) REFERENCES "User"("ID") PRIMARY KEY,
    "MedSpecialization" TEXT,
    "OfficePhoneNumber" CHAR(15),
    "WardID" SERIAL REFERENCES "Ward"("WardID")
);

CREATE TABLE IF NOT EXISTS "MedicalInfo" (
    "MedicalInfoID" SERIAL PRIMARY KEY,
    "PatientID" CHAR(16) REFERENCES "Patient"("PatientID"),
    "Description" TEXT
);

CREATE TABLE IF NOT EXISTS "Appointment" (
    "AppointmentID" SERIAL PRIMARY KEY,
    "DateTime" TIMESTAMPTZ NOT NULL,
    "StaffID" CHAR(16) REFERENCES "Staff"("StaffID"),
    "DoctorID" CHAR(16) REFERENCES "Doctor"("DoctorID"),
    "PatientID" CHAR(16) REFERENCES "Patient"("PatientID")
);

CREATE TABLE IF NOT EXISTS "MedicalEvent" (
    "EventID" SERIAL PRIMARY KEY,
    "FromDateTime" TIMESTAMPTZ NOT NULL,
    "ToDateTime" TIMESTAMPTZ CHECK ( "ToDateTime" >= "MedicalEvent"."FromDateTime" ),
    "SeverityCode" "Severity",
    "DischargeLetter" TEXT,
    "PatientID" CHAR(16) REFERENCES "Patient"("PatientID"),
    "WardID" SERIAL REFERENCES "Ward"("WardID")
);

CREATE TABLE IF NOT EXISTS "MedicalExam" (
    "ExamID" SERIAL PRIMARY KEY,
    "DateTime" TIMESTAMPTZ NOT NULL,
    "MedicalReport" TEXT,
    "ExamType" TEXT,
    "DoctorID" CHAR(16) REFERENCES "Doctor"("DoctorID"),
    "PatientID" CHAR(16) REFERENCES "Patient"("PatientID"),
    "MedicalEvent" SERIAL REFERENCES "MedicalEvent"("EventID")
);
DO $$
BEGIN
INSERT INTO "Ward" ("WardID", "Name") VALUES (1, 'Psychiatry');
INSERT INTO "Ward" ("WardID", "Name") VALUES (2, 'Post-Operative Recovery');
INSERT INTO "Ward" ("WardID", "Name") VALUES (3, 'Infectious Diseases');
INSERT INTO "Ward" ("WardID", "Name") VALUES (4, 'Rehabilitation Unit');
INSERT INTO "Ward" ("WardID", "Name") VALUES (5, 'Psychiatry');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('NDRPLA550802NJ', 'Paul', 'Anderson', '1955-08-02', 'bhmMigIY9AVTU88AICLvnfR5ffrMq5EByAuSMauerMFr46z6JL', '+39334576805');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('DWRMLY800118WY', 'Emily', 'Edwards', '1980-01-18', 'cKxtieGFFkQrBE2cc8QKUc3D6jlBewB0eBIAtaE4kpk3MOgy2m', '+39306042672');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('JHNNDR811114WY', 'Andrew', 'Johnson', '1981-11-14', '5jVsSKoeXZwHQzGWiIK9sjTLFDSX0CU9kdRBchCnAnVGyqfIGD', '+39313758095');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('WRRDWR440915AS', 'Edward', 'Warren', '1944-09-15', 'p1HkaQ9wgfVW2YDOshAtLK2NynMMrusLSbX6Io0bP2CFdd97An', '+39396847275');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HLLRCE441248AS', 'Eric', 'Hall', '1944-12-08', 'xJdWOKeqUf96N9qpruLjnkXka7Ijz90gpFxt3q50QfsluO32KD', '+39334346105');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HWRSTV460704NV', 'Steven', 'Howard', '1946-07-04', 'D0ogchY7C4HI77bLgMQtcu7aRpvKLyrvS63FddL4WggDdKA19c', '+39325964395');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('SWNJNN050252WI', 'Jennifer', 'Swanson', '2005-02-12', 'dOCIRH2dbJ7HqmejvqpFUq2NhFHHt5gBaNksgha1OVFzsKvlJ8', '+39385224331');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('FLRCND921170IL', 'Cindy', 'Flores', '1992-11-30', '7e6Q4pTDo67AW5dhKQ2FTvt4r48hgHIhk4tKKQAs9kDcfYDsCJ', '+39372727782');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('FLYSTV470855MI', 'Steven', 'Flynn', '1947-08-15', 'uOPdTDQHMoTYOMPDfy7H9o82c2R1SRu7DSaEqwBGmzOQlF7j2P', '+39367559174');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('RDDMLS970657NJ', 'Melissa', 'Riddle', '1997-06-17', 'fOShzt5R6tRKiy95OE9XlDWKzqn2mtJ4R5tRScu9lH9bYXLian', '+39325247441');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CLRPML490364IA', 'Pamela', 'Clark', '1949-03-24', 'IsHIIVvFlBtlcdzB8cVPGJ5UPivecQIO5FH5wGgMqA7UjzsOQh', '+39359844666');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('WLTMCH961153MA', 'Michele', 'Walton', '1996-11-13', 'XqeG0eM2JJNnpoBbvT7mRNCaFuWSVeMUl21WZSpciWjxYzXw1D', '+39396306224');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('STOJLU830929WY', 'Julie', 'Soto', '1983-09-29', '9G2IMHSJAsEDft35DQFwBchtunQk30ASUyOX1gn3YDEZkVXPMK', '+39356700430');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('VGEKNN520157CA', 'Kenneth', 'Vega', '1952-01-17', 'JFlLsVZGh58df9JAilZqgzjkhiu2EaD8urPKUIeduIJtV7scrb', '+39300305114');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LTTLCA920219CA', 'Alicia', 'Little', '1992-02-19', 'l0lQfkQzQGGNFUNblprUZ0p7IClWYL2KrW3GCblvkMu5iC7v7m', '+39385566043');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('SMTMCH740710PR', 'Michelle', 'Smith', '1974-07-10', 'Dre7ay8TA6vi5IrRDT5L0BLZd54HELyJRFxJjfKzMxpJcIM9NY', '+39334121956');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HRTMLS630454FL', 'Melissa', 'Hartman', '1963-04-14', 'BoJLYes5GH41Hn4MANAl21MjpCPQ7EpIx0zPfbVWhtE9USWBlR', '+39387870846');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('PRZDNL850943GU', 'Daniel', 'Perez', '1985-09-03', 'KqVZvVDOvFGYfozm0LmXWJIZI9n7023mTBOZisPXwXkuVZOx7H', '+39363587744');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('NDRJSH711229TX', 'Joshua', 'Anderson', '1971-12-29', 'gMevejnOc1Lk7KBP3d5gPGkwbTD1vuKNYk3p2UvFcli85pOOVw', '+39355152446');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('WLLKRN721059CO', 'Karen', 'Williams', '1972-10-19', 'mJuJLHIikabYE33NB16KMJ7wfJ1HysWDMj6NXvbuJtcTTOfwil', '+39307802099');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GDOCHR861042OR', 'Christopher', 'Good', '1986-10-02', '5ZXYTj2WxiGp9cLy40eomMJCdAq3vpvNoMrXmfbo9HLom5SVEA', '+39324564521');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('THMNTH490363VA', 'Nathan', 'Thomas', '1949-03-23', 'XsTh48T9nCibjXB24jTK1SYRIcxvDV6483Lu2oE5Dcrvb8BfMF', '+39389249517');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GDMJRM000843LA', 'Jeremy', 'Goodman', '2000-08-03', 's3xarpVqlYtVgADiuIfHOXlbOQHAnKmfVVcQmWg0GtSGElVu47', '+39362706615');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('DVDTRC920130OH', 'Tracy', 'David', '1992-01-30', 'oFMZPJx55ET5wqQ1VUQhUL58m8f0Pt6bl88F8unvotbkagLAwl', '+39314070866');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CRTBRN021166MA', 'Brian', 'Carter', '2002-11-26', 'luu6NMOSsLWpZT5mJGKRV1j7zgIZ28SFJzqocryUMuY8huo5pT', '+39395511563');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('WTTLRA570515NC', 'Laura', 'Watts', '1957-05-15', 'o8k596zYWZ4NO1OY44g6CAMcPwh4EliBNPAxA8ZxofH0zvvqte', '+39331681856');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CRDBRN850524HI', 'Brianna', 'Cardenas', '1985-05-24', 'PA0hVfMh8R8HnMStfoQa5R8T5goR2QOYvMbIRELsmDWibz24oj', '+39371664962');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HNDJSH550863NM', 'Joshua', 'Henderson', '1955-08-23', 'nyEnFBjai2UONVqcdUBBmFIuyolVjZ3SnSuvoo83flwqjZsBAd', '+39314912326');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('JHNMRG940306FL', 'Margaret', 'Johnston', '1994-03-06', 'TMREursoCWWDbduXo3HGghvB9mC4pydFlf9776MS3r5uOfuqbK', '+39311320188');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LWRJMS901226MT', 'James', 'Lawrence', '1990-12-26', 'NTUUrZgmeIXxAJpjlpp4Z4SbJaMxOHe2elxAJ8RSIDSaisz6gL', '+39310993866');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HNRDNI511263AK', 'Diane', 'Henry', '1951-12-23', 'YpWO99xJ5rdgbpplThIfXLle48NenLCjNlfcMyoy4VICLxyleC', '+39372987071');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('KLNJNT001201SC', 'Janet', 'Kline', '2000-12-01', 'UFHfylQDCmvW7RA9Jn760VtkAt9brlBw1V64BEEfJ7Gi3qcWau', '+39307930537');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CHPCRY710647VT', 'Cory', 'Chapman', '1971-06-07', 'dxlzB4k3kt0PMiREF9MXsGshq8BX18WkVN6Bg5uHB0425aQs07', '+39308912830');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('SMPJDT710948WY', 'Judith', 'Simpson', '1971-09-08', '9IxOe1RqnUlxgsDVLSM3zrxXgNHZKqsgc7Q0PBSsjDPvzl4n2T', '+39342055401');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GRDCLD040871AL', 'Claudia', 'Gordon', '2004-08-31', 'EMexI3Xdl0cBTWVQeNotsiLtRfDbYJ3J8vuRlzVrrpBZNUbVuH', '+39373510583');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GRCJNT750301FL', 'Jonathan', 'Garcia', '1975-03-01', 'dhNY6BZP1NemP4orMyHvc8sfs5sWzpPTuVn0YtxTGJwGdqMouT', '+39335096941');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('WLSSHR461108IN', 'Shari', 'Wilson', '1946-11-08', 'BtGreMRMzfAI05AXQ1WPL5L8SUKX5vqunsL4xplHOMBCm65NBC', '+39392267924');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GRVSTP050648NC', 'Stephen', 'Graves', '2005-06-08', 'F36QecSLygeB0nnESsuUgMixG34aey1YUT25Q2MIHenubmqNTh', '+39368807323');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GRHLSI941222TX', 'Lisa', 'Graham', '1994-12-22', 'efn4mJsG9PyG5T9AJKaoOiASSlrcP0qULm4EyNVBK7CDgCwtIR', '+39379137863');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('JCKKTA900845AZ', 'Katie', 'Jackson', '1990-08-05', 'NIvdcZBIZaLdH2LOgxPFfZE6piZl4967E5DHvBe7TTowcYjOVj', '+39358905836');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CMPJNN041047GA', 'Jennifer', 'Campbell', '2004-10-07', 'Xe3y9yqkkGYj5Km5oxeECd2dyKnu7jdZDTPx8GJjfBQKXXIn3s', '+39375894700');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('THMTRC941247OR', 'Tracy', 'Thomas', '1994-12-07', 'KjT7ZhWzWPHid67rvmiHFZho6lgnxsMf14Uyd6gsNVUBdiYzXQ', '+39350646222');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HOPTR901207WV', 'Peter', 'Ho', '1990-12-07', 'vJmFp4dA6S0zdw2ig3eliT98V2t3t3tqlM4ziVWJa2iC7Bnfyt', '+39358789787');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('KLLKTA960119VI', 'Katie', 'Kelly', '1996-01-19', 'cNPBgGWLyPaur1C6kuE5NwIB2nkWoXTsyQBVWTPumBNWcLKurI', '+39314274367');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MRTLXA640570MD', 'Alex', 'Martinez', '1964-05-30', 'p5Zv0qE6JaX7G7jYOJoSWTyqQzoNFThb7gPYXaw3XqxY3Y5ZdH', '+39307441283');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CLOMCH701252IA', 'Michael', 'Cole', '1970-12-12', 'EscvnTXS0LRDe9OJwZ6C113KgG3foPrswMDhTQL9lFm6EyUWcC', '+39370139023');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('VLLKLL530950CO', 'Kelly', 'Villegas', '1953-09-10', 'e1lTfvsxxJ118c3DtHag2Um8c7keVlM2oRyC3ysb4vMgFVaKms', '+39345670200');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('DMSJMS761144SC', 'James', 'Adams', '1976-11-04', 'IYrXeKCaAg9vML0VlHv5FBwqPxxPHR0XYqxlNwlP5aBxanTnPQ', '+39363847123');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('WDOVRN490111UT', 'Veronica', 'Wood', '1949-01-11', 'qdorKtE1MmG40AmCU3GZDnsgHfoerot28ArkXnsC0pDTEsewnd', '+39300834102');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LLNPLA451067AR', 'Paula', 'Allen', '1945-10-27', 'RktnHzYv3PPwWYNyuZh4JHRXIAwXREOoc9BQnSxbppyfHppRkT', '+39311247015');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MCKSHL530913MN', 'Ashley', 'Mcknight', '1953-09-13', 'rZWc96ZQeNFgfRWog0czTzHTDGHFPJDoXPxFQ1RHCLQfmiwyao', '+39320061670');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('DWRWLL010850NC', 'William', 'Edwards', '2001-08-10', 't5bjpFOe24XI3cUkCx8mhhs4CRlEtGMP9vAC2a7WlSVCJl2Xv4', '+39312939096');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MRLJNN690101CA', 'Jennifer', 'Morales', '1969-01-01', 'qFjcAYwVgpgR7ff5UChOIJOuEiopSOAfgaRIlmTBOoNUdhWyUW', '+39344958437');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LWSBRN000915MO', 'Brent', 'Lewis', '2000-09-15', 'PnuJ60XfzlG5B9M5ZosWFHHWj9jDLPI8AO9nHrpHJFZxNeHtCc', '+39359873473');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MCGCYN580108MT', 'Cynthia', 'Mcgee', '1958-01-08', 'i5liHe5ICxW07BIDXQzJ0aAV3t5CCVvP2fqCdvpRhDQKw25XQy', '+39360985661');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('STNSRH680450MT', 'Sarah', 'Stone', '1968-04-10', 'dxobrt81jZr6dN9pLdiuyb7ChJpwriEJZiewCNfZRVzKVVe5MZ', '+39364063163');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('WLLBRN940228NV', 'Brian', 'Williams', '1994-02-28', 'zvWsm4V9kNMSXGXU6FbsVpocrSyb3gZU0kadwVtDQwXpqRa2oV', '+39371888799');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('JCKMCH560319MD', 'Michael', 'Jackson', '1956-03-19', 'jl3928l94YPuUMmIezbg3VwXDg9HkyeibopIxzOOSJocq6zzB3', '+39376830546');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MRTBRN570846IN', 'Brandon', 'Martinez', '1957-08-06', '99nGq2nuOKwBcmXCtFc2BJgHX1SGHQzPgHKBR6YeofIvpj9G5U', '+39397418363');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('PRZSRR570757MT', 'Sierra', 'Perez', '1957-07-17', 'zLlZsk94tESzz9E3KbEoAp5ZqVP4zydq3YXoJuTTTGuTSAVbdO', '+39337520839');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('BRWSNE570670ME', 'Sean', 'Brewer', '1957-06-30', 'XhfSLqHhYINPckDhfV21McxoMFvIjGVgcntOvepSrEaMnjMejE', '+39333917622');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GBSMRT810703ME', 'Martin', 'Gibson', '1981-07-03', 'XfcKu1XdvdxT0AJ4uxXMmf6MUtY8B67hMpdR5STmPhM5kpmdLA', '+39300732354');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MNDWLL660203MI', 'William', 'Mendoza', '1966-02-03', 'o39UqXLRsa5LBYRuXeq6YF8P3xzI6FxOEqbMvTOs8rFFayP9uO', '+39328584807');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('JMSBRB620517MO', 'Barbara', 'James', '1962-05-17', '6X2Q102N9idkKrYu7OaNr3v3okksxoCneDV58wE1jNLlcMqHuq', '+39380222047');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HRSJNN840558RI', 'Jennifer', 'Hurst', '1984-05-18', 'EfCy9NaOPBO4bH87316ZZIOfZ2Si6LIsRgK6hJYssvOVw80w1q', '+39357629320');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('VRTCRY440757MO', 'Crystal', 'Everett', '1944-07-17', 'iWItMLtynA2UdvpR2bMokjA0XUDrXnmYCkTZHeXTyKqAPa84pg', '+39381603670');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('WNTRCK500650AS', 'Ricky', 'Winters', '1950-06-10', '4YtLg4T9AupdmHvByhoJ4Is8anNzhvS3tzdF6RbuGR70l8IKBp', '+39334087066');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MYAMRY990608NV', 'Mary', 'May', '1999-06-08', 'hJKSclHsxDSu7O5Ey8yYdhIzZrNEKrHnNo3qRjDHeaSvSf6sM1', '+39329324008');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('BRRJSN620666MO', 'Jason', 'Barry', '1962-06-26', 'AkYNFT6B5iSRa5dLWsMAfBqM0ap1qehUFRCC1aA6eFEdDypLEN', '+39385321289');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GLVSTP980164NJ', 'Stephanie', 'Glover', '1998-01-24', 'ls3FoZ6bneGtOccxcNnYMC3sBln9097cmwYHwwqin1HpjevPpj', '+39388869437');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MSSMRD861016WI', 'Meredith', 'Moss', '1986-10-16', 'QXG1JPzPUAmeskXNLsBbFKyje7GiLBQe0EyRqhQPnuquAQC13B', '+39356833406');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('BLLJST820355OH', 'Justin', 'Bullock', '1982-03-15', '4yKh22Y2O0lgySYJNyAanOAaH5vpdvVMmw3xhb25FEPBpHYGYH', '+39391888323');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('FSTWLL940652MA', 'William', 'Foster', '1994-06-12', '1StRNPzHGTIzviyAMeNhIyXNl7LG5Qlj4cEC5FtP3UPJyd4rT0', '+39386155955');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LLSLND021202MS', 'Lindsay', 'Ellis', '2002-12-02', 'uJFsaaH93AwJDVcltFC9seWjmrfzZ5Lz6EA9wErMGtnenHdHUP', '+39373470339');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('ZHNSTN750516HI', 'Austin', 'Zhang', '1975-05-16', 'BOw1XcQVj88y9zqR1fV2oI13828qI2FTnkklq0msPFfPVspNtM', '+39371073038');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LPZJSN501151IN', 'Jason', 'Lopez', '1950-11-11', 'uVol1svjscUoDJ2YZPYLwwaYGFVpTxSUMbLfx9EbmKMf3q1ERJ', '+39376959839');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('JCKRCH501130NY', 'Richard', 'Jackson', '1950-11-30', 'Yy7MWOWZdDfVDWHqKTb6OR84y42qbgfmwRHZckgShDNtEHOwLR', '+39332346840');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MRPJLU910449NJ', 'Julie', 'Murphy', '1991-04-09', 'TXwKtyH2Q1CXLk9LMT2tLHFtOQ7PKOhSpHpxntHxNOXgm00be8', '+39360023007');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LYNNGL660942GA', 'Angela', 'Lyons', '1966-09-02', 'y6jCKO5Ip5w8Cbe9rtym4F5t2ODt4QBcHfzcVBU6ZN7YkWWC8t', '+39397453744');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GRNJNN551068MI', 'Jennifer', 'Greene', '1955-10-28', 'wy5QMHN06lYqBdAlO0AUSjzKlR1L7FNA48C3lgLgowKbPpeTJg', '+39300916918');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('JMSDWN870311KS', 'Dawn', 'James', '1987-03-11', '6uy1KNWqMegDTPw9KLl98R37wPA0y8Re1XhUim5kZj2RPx04x8', '+39333012916');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('NLSPHL590452NC', 'Phillip', 'Nielsen', '1959-04-12', 'Gg6BkLRU2bQwI0dveUIvwsMe4Lbv0yNygBCkYQRN1tJsA1l57d', '+39339253123');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('NDRLZB901047SD', 'Elizabeth', 'Andrade', '1990-10-07', 'cWe62OfquHS7KazjD1kGlkEA01aixSIETHyIxlUkrugHfR8IaR', '+39300607843');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CRVCYN721049GA', 'Cynthia', 'Cervantes', '1972-10-09', 'raxVsy8W3QtdGwAVOQhaiKRbm4RwuB82KNofpvQNuKz3XyJ28r', '+39378414107');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MSLMRO840313NH', 'Omar', 'Mosley', '1984-03-13', '90QBmOBKG86Bj6G9xrNn3MC9F39zBsiEBwPlkbTmEvDp6zLPxN', '+39370783711');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HLDPHL630343CA', 'Philip', 'Holder', '1963-03-03', 'sxmFDCLNU0vsxhad1ifxiWLzbLxvddsanYKCHdc03GpD7dws0h', '+39361795193');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('BRNRCE650641TN', 'Erica', 'Barnes', '1965-06-01', 'i2DQtvbqy3sJw5jaw1QwIHTG1k9yvnUBtrzl55OQc448CSlNBi', '+39395515409');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('SNDRSS691128HI', 'Russell', 'Sanders', '1969-11-28', 'JsHtmMK4Y0xlO30pYFU23jgFTQPb6x75nJk4bIsUzSPKID59Hy', '+39370104591');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CHVJRM050223MT', 'Jeremy', 'Chavez', '2005-02-23', 'ygEA5SJmWbBMTR2ANuUDjwfUYLRhF6g4TAlqezYGB2DI6SHOjj', '+39367395853');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LLTDVD011008TX', 'David', 'Elliott', '2001-10-08', 'JSMN6Zs32Pjx4LXYPn5FcNTQQU3FCkKVhpE0moncpVdE2gkTiv', '+39374174988');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MDYSTV591260VI', 'Steven', 'Moody', '1959-12-20', 'ByuYSfNIA828arUIChdC93ZlSSgzLB8YrYSnE9dETrP6esQoQM', '+39306357293');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('BTSMNC470430WY', 'Monica', 'Bates', '1947-04-30', 'pcVvEii2htBjbDGUwPkUVwnNXpyTbW0QAbUP2BrLcxodh6JwiN', '+39396388234');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('JHNPLA031224CO', 'Paul', 'Johnson', '2003-12-24', 'cBokYkENShS0PxhYmaC25ZZtur1r7pSmWuqKvjAe4SVBtLwniV', '+39359649135');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('HLLJSH020506OR', 'Joshua', 'Hall', '2002-05-06', 'hcpbZDq8FeM18pi90hVR6gg66bln93f7yN2VDsTXFnRpQWySg5', '+39328751895');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('CHRRSS761259IL', 'Russell', 'Christian', '1976-12-19', 'tWuPvWdCXLOO4jqlkQq4KXrfwI9IZ1QsKl1qd5QRcAiWdulWWm', '+39313983228');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('GRCLXN521002PR', 'Alexandra', 'Garcia', '1952-10-02', 'fNEj2jrPloSV9IuNi1dsiHytsBBBMwPSreb0ETwEZz5o0vkPMG', '+39315989115');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LVRBTH940646GU', 'Bethany', 'Alvarado', '1994-06-06', 'HfK3TSTb7onfZtiJ5Gj7xeQ6JmkYClYhjY41AOnCWZCpRLPhZY', '+39352888415');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('LSNBRB791126MT', 'Barbara', 'Olsen', '1979-11-26', 'GmlVEg3cSPjDfVvPVdY57MiiUgAQkRgsNZ1NQo1lfBIShXm5uM', '+39389000230');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('DZIJRM900228MO', 'Jeremy', 'Diaz', '1990-02-28', 'llnLaL6xPGrgrCvK3CQIi7hwDUsLySZtPFqkvZ51eldIderunj', '+39314251319');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") VALUES ('MSSCHR961267MI', 'Christopher', 'Moses', '1996-12-27', 'Fg5YXYopH6MueBR5UWsZIfaxHy25oUt72o8QWJ6aSqD1YzlXzK', '+39352380560');
INSERT INTO "Staff" ("StaffID") VALUES ('CLRPML490364IA');
INSERT INTO "Staff" ("StaffID") VALUES ('LTTLCA920219CA');
INSERT INTO "Staff" ("StaffID") VALUES ('LWSBRN000915MO');
INSERT INTO "Staff" ("StaffID") VALUES ('MCGCYN580108MT');
INSERT INTO "Staff" ("StaffID") VALUES ('GRNJNN551068MI');
INSERT INTO "Staff" ("StaffID") VALUES ('CRVCYN721049GA');
INSERT INTO "Staff" ("StaffID") VALUES ('MDYSTV591260VI');
INSERT INTO "Staff" ("StaffID") VALUES ('LVRBTH940646GU');
INSERT INTO "Patient" ("PatientID") VALUES ('HLLRCE441248AS');
INSERT INTO "Patient" ("PatientID") VALUES ('SWNJNN050252WI');
INSERT INTO "Patient" ("PatientID") VALUES ('FLRCND921170IL');
INSERT INTO "Patient" ("PatientID") VALUES ('CLRPML490364IA');
INSERT INTO "Patient" ("PatientID") VALUES ('WLTMCH961153MA');
INSERT INTO "Patient" ("PatientID") VALUES ('VGEKNN520157CA');
INSERT INTO "Patient" ("PatientID") VALUES ('WLLKRN721059CO');
INSERT INTO "Patient" ("PatientID") VALUES ('DVDTRC920130OH');
INSERT INTO "Patient" ("PatientID") VALUES ('LWRJMS901226MT');
INSERT INTO "Patient" ("PatientID") VALUES ('HNRDNI511263AK');
INSERT INTO "Patient" ("PatientID") VALUES ('CHPCRY710647VT');
INSERT INTO "Patient" ("PatientID") VALUES ('SMPJDT710948WY');
INSERT INTO "Patient" ("PatientID") VALUES ('GRDCLD040871AL');
INSERT INTO "Patient" ("PatientID") VALUES ('GRCJNT750301FL');
INSERT INTO "Patient" ("PatientID") VALUES ('WLSSHR461108IN');
INSERT INTO "Patient" ("PatientID") VALUES ('GRHLSI941222TX');
INSERT INTO "Patient" ("PatientID") VALUES ('CMPJNN041047GA');
INSERT INTO "Patient" ("PatientID") VALUES ('THMTRC941247OR');
INSERT INTO "Patient" ("PatientID") VALUES ('MRTLXA640570MD');
INSERT INTO "Patient" ("PatientID") VALUES ('DMSJMS761144SC');
INSERT INTO "Patient" ("PatientID") VALUES ('DWRWLL010850NC');
INSERT INTO "Patient" ("PatientID") VALUES ('STNSRH680450MT');
INSERT INTO "Patient" ("PatientID") VALUES ('BRWSNE570670ME');
INSERT INTO "Patient" ("PatientID") VALUES ('VRTCRY440757MO');
INSERT INTO "Patient" ("PatientID") VALUES ('WNTRCK500650AS');
INSERT INTO "Patient" ("PatientID") VALUES ('BRRJSN620666MO');
INSERT INTO "Patient" ("PatientID") VALUES ('LLSLND021202MS');
INSERT INTO "Patient" ("PatientID") VALUES ('ZHNSTN750516HI');
INSERT INTO "Patient" ("PatientID") VALUES ('JMSDWN870311KS');
INSERT INTO "Patient" ("PatientID") VALUES ('NLSPHL590452NC');
INSERT INTO "Patient" ("PatientID") VALUES ('NDRLZB901047SD');
INSERT INTO "Patient" ("PatientID") VALUES ('CRVCYN721049GA');
INSERT INTO "Patient" ("PatientID") VALUES ('JHNPLA031224CO');
INSERT INTO "Patient" ("PatientID") VALUES ('GRCLXN521002PR');
INSERT INTO "Patient" ("PatientID") VALUES ('LVRBTH940646GU');
INSERT INTO "Patient" ("PatientID") VALUES ('LSNBRB791126MT');
INSERT INTO "Patient" ("PatientID") VALUES ('DZIJRM900228MO');
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('SWNJNN050252WI', 'Retail manager', '+39391599193', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('DVDTRC920130OH', 'Research scientist (medical)', '+39383632239', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('KLNJNT001201SC', 'Legal secretary', '+39345401021', 1);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('CHPCRY710647VT', 'Psychotherapist, child', '+39387253712', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('GRDCLD040871AL', 'Civil Service fast streamer', '+39387002287', 5);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('MRTBRN570846IN', 'Actor', '+39399166341', 1);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('GBSMRT810703ME', 'Buyer, retail', '+39399764066', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('MNDWLL660203MI', 'Agricultural consultant', '+39374983746', 5);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('JMSBRB620517MO', 'Telecommunications researcher', '+39372597472', 5);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('BRRJSN620666MO', 'Chartered accountant', '+39339136598', 3);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('ZHNSTN750516HI', 'Librarian, public', '+39359682244', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('LPZJSN501151IN', 'Glass blower/designer', '+39358284968', 1);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('MRPJLU910449NJ', 'Engineer, automotive', '+39397645655', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('NDRLZB901047SD', 'Adult nurse', '+39370214412', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('BRNRCE650641TN', 'Camera operator', '+39344768486', 3);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('BTSMNC470430WY', 'Tree surgeon', '+39368808861', 1);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('HLLJSH020506OR', 'Surveyor, commercial/residential', '+39339474224', 3);
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('HLLRCE441248AS', 'Bed hotel person field fly talk for.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('SWNJNN050252WI', 'Year low your national.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('FLRCND921170IL', 'Beat history live today recognize value adult.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CLRPML490364IA', 'Traditional feeling recently yet between daughter.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('WLTMCH961153MA', 'Physical office interest discussion.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('VGEKNN520157CA', 'Response wide huge collection film.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('WLLKRN721059CO', 'Step pattern day start customer course mention.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('DVDTRC920130OH', 'Style again employee where study federal coach.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('LWRJMS901226MT', 'Early eat learn include almost own.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('HNRDNI511263AK', 'I site whole.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CHPCRY710647VT', 'Owner fast per expect respond line.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('SMPJDT710948WY', 'Century defense itself home citizen.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('GRDCLD040871AL', 'News production mention owner kid mean.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('GRCJNT750301FL', 'Trial believe clear with former fear those.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('WLSSHR461108IN', 'Store push member truth hot speech.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('GRHLSI941222TX', 'Bill open control story form economy.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CMPJNN041047GA', 'Indeed international boy person notice.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('THMTRC941247OR', 'Happen operation someone practice simply fall start.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('MRTLXA640570MD', 'Across recognize agreement baby learn before center on.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('DMSJMS761144SC', 'Push reduce beautiful heart whether.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('DWRWLL010850NC', 'Service similar under third fly perhaps.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('STNSRH680450MT', 'Rest reduce pull call officer approach.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('BRWSNE570670ME', 'Card picture ask individual office administration.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('VRTCRY440757MO', 'Draw police sea hotel.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('WNTRCK500650AS', 'Far billion wind offer audience.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('BRRJSN620666MO', 'Future shoulder fish at too turn science.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('LLSLND021202MS', 'Region institution eye note explain.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('ZHNSTN750516HI', 'Public four here.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('JMSDWN870311KS', 'Which along enjoy do author education story.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('NLSPHL590452NC', 'Game think there factor type without.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('NDRLZB901047SD', 'Food five ask will lose deep present.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CRVCYN721049GA', 'Deep sure finish open civil.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('JHNPLA031224CO', 'Assume fire plan but time court easy if.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('GRCLXN521002PR', 'Old law arm suggest.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('LVRBTH940646GU', 'Treatment pass sign quickly.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('LSNBRB791126MT', 'Civil food project already economy news.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('DZIJRM900228MO', 'Perform worker technology expert information yard.');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2020-12-01 00:00:00', 'GRNJNN551068MI', 'SWNJNN050252WI', 'VRTCRY440757MO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-11-08 00:00:00', 'LWSBRN000915MO', 'BRNRCE650641TN', 'NLSPHL590452NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-01-04 00:00:00', 'MDYSTV591260VI', 'HLLJSH020506OR', 'MRTLXA640570MD');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2004-10-03 00:00:00', 'GRNJNN551068MI', 'NDRLZB901047SD', 'VRTCRY440757MO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2020-01-02 00:00:00', 'GRNJNN551068MI', 'GBSMRT810703ME', 'GRCLXN521002PR');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2008-08-05 00:00:00', 'MCGCYN580108MT', 'GBSMRT810703ME', 'CHPCRY710647VT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-07-30 00:00:00', 'CLRPML490364IA', 'KLNJNT001201SC', 'FLRCND921170IL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2015-09-03 00:00:00', 'MDYSTV591260VI', 'KLNJNT001201SC', 'LWRJMS901226MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-03-06 00:00:00', 'CLRPML490364IA', 'BTSMNC470430WY', 'WLSSHR461108IN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-05-25 00:00:00', 'CLRPML490364IA', 'GBSMRT810703ME', 'GRCJNT750301FL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-05-11 00:00:00', 'CRVCYN721049GA', 'GRDCLD040871AL', 'LWRJMS901226MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-04-13 00:00:00', 'CRVCYN721049GA', 'BTSMNC470430WY', 'WLTMCH961153MA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2002-04-15 00:00:00', 'LWSBRN000915MO', 'MRTBRN570846IN', 'BRWSNE570670ME');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-12-05 00:00:00', 'CRVCYN721049GA', 'CHPCRY710647VT', 'GRDCLD040871AL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-12-18 00:00:00', 'GRNJNN551068MI', 'GBSMRT810703ME', 'CMPJNN041047GA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2015-02-03 00:00:00', 'GRNJNN551068MI', 'BRRJSN620666MO', 'SWNJNN050252WI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2002-04-11 00:00:00', 'MDYSTV591260VI', 'HLLJSH020506OR', 'CLRPML490364IA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2007-05-09 00:00:00', 'LWSBRN000915MO', 'JMSBRB620517MO', 'GRDCLD040871AL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-09-09 00:00:00', 'MDYSTV591260VI', 'BRNRCE650641TN', 'NLSPHL590452NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-09-13 00:00:00', 'GRNJNN551068MI', 'MNDWLL660203MI', 'FLRCND921170IL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2015-06-25 00:00:00', 'GRNJNN551068MI', 'MRPJLU910449NJ', 'DWRWLL010850NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2001-09-20 00:00:00', 'LWSBRN000915MO', 'ZHNSTN750516HI', 'DZIJRM900228MO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2006-04-06 00:00:00', 'LVRBTH940646GU', 'MNDWLL660203MI', 'CMPJNN041047GA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-08-09 00:00:00', 'MCGCYN580108MT', 'GBSMRT810703ME', 'LWRJMS901226MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-03-18 00:00:00', 'MCGCYN580108MT', 'ZHNSTN750516HI', 'LLSLND021202MS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2008-08-14 00:00:00', 'GRNJNN551068MI', 'KLNJNT001201SC', 'LWRJMS901226MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2007-06-28 00:00:00', 'MCGCYN580108MT', 'HLLJSH020506OR', 'MRTLXA640570MD');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2007-06-17 00:00:00', 'MCGCYN580108MT', 'SWNJNN050252WI', 'SMPJDT710948WY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-10-02 00:00:00', 'LVRBTH940646GU', 'GBSMRT810703ME', 'WLSSHR461108IN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2023-07-03 00:00:00', 'GRNJNN551068MI', 'MRTBRN570846IN', 'CMPJNN041047GA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2019-09-26 00:00:00', 'GRNJNN551068MI', 'ZHNSTN750516HI', 'JMSDWN870311KS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-04-28 00:00:00', 'LVRBTH940646GU', 'GRDCLD040871AL', 'VGEKNN520157CA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2012-10-06 00:00:00', 'MDYSTV591260VI', 'NDRLZB901047SD', 'ZHNSTN750516HI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-08-13 00:00:00', 'GRNJNN551068MI', 'MRPJLU910449NJ', 'LVRBTH940646GU');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2005-02-06 00:00:00', 'MCGCYN580108MT', 'LPZJSN501151IN', 'GRCJNT750301FL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2001-07-18 00:00:00', 'CLRPML490364IA', 'JMSBRB620517MO', 'STNSRH680450MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-09-04 00:00:00', 'CLRPML490364IA', 'ZHNSTN750516HI', 'NLSPHL590452NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2009-12-14 00:00:00', 'MCGCYN580108MT', 'DVDTRC920130OH', 'HLLRCE441248AS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-08-19 00:00:00', 'CRVCYN721049GA', 'GBSMRT810703ME', 'LWRJMS901226MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2015-10-31 00:00:00', 'CLRPML490364IA', 'SWNJNN050252WI', 'HNRDNI511263AK');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-04-19 00:00:00', 'LVRBTH940646GU', 'LPZJSN501151IN', 'CHPCRY710647VT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-05-02 00:00:00', 'CRVCYN721049GA', 'SWNJNN050252WI', 'JHNPLA031224CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2021-04-05 00:00:00', 'MDYSTV591260VI', 'BRNRCE650641TN', 'WLLKRN721059CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2012-10-03 00:00:00', 'MDYSTV591260VI', 'KLNJNT001201SC', 'LVRBTH940646GU');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2018-05-11 00:00:00', 'LWSBRN000915MO', 'ZHNSTN750516HI', 'JHNPLA031224CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2001-11-05 00:00:00', 'MDYSTV591260VI', 'GRDCLD040871AL', 'SMPJDT710948WY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2002-08-02 00:00:00', 'LWSBRN000915MO', 'LPZJSN501151IN', 'BRWSNE570670ME');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-08-02 00:00:00', 'CRVCYN721049GA', 'MRPJLU910449NJ', 'WLTMCH961153MA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-09-07 00:00:00', 'GRNJNN551068MI', 'BRNRCE650641TN', 'HLLRCE441248AS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-02-01 00:00:00', 'CLRPML490364IA', 'BTSMNC470430WY', 'WLSSHR461108IN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2009-12-02 00:00:00', 'LTTLCA920219CA', 'MRPJLU910449NJ', 'LSNBRB791126MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2020-08-06 00:00:00', 'CRVCYN721049GA', 'HLLJSH020506OR', 'CRVCYN721049GA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-10-10 00:00:00', 'CLRPML490364IA', 'CHPCRY710647VT', 'SMPJDT710948WY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-09-26 00:00:00', 'LTTLCA920219CA', 'BRRJSN620666MO', 'VGEKNN520157CA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2021-12-03 00:00:00', 'CLRPML490364IA', 'ZHNSTN750516HI', 'GRHLSI941222TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-09-10 00:00:00', 'GRNJNN551068MI', 'CHPCRY710647VT', 'LWRJMS901226MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-04-14 00:00:00', 'MCGCYN580108MT', 'CHPCRY710647VT', 'WLLKRN721059CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2006-10-05 00:00:00', 'LVRBTH940646GU', 'GBSMRT810703ME', 'DWRWLL010850NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2007-05-24 00:00:00', 'CLRPML490364IA', 'SWNJNN050252WI', 'SWNJNN050252WI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-04-20 00:00:00', 'LVRBTH940646GU', 'BRNRCE650641TN', 'GRHLSI941222TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2019-12-27 00:00:00', 'LTTLCA920219CA', 'KLNJNT001201SC', 'SWNJNN050252WI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2008-02-27 00:00:00', 'CRVCYN721049GA', 'SWNJNN050252WI', 'LLSLND021202MS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2007-08-15 00:00:00', 'CLRPML490364IA', 'ZHNSTN750516HI', 'WLLKRN721059CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-08-09 00:00:00', 'MCGCYN580108MT', 'BRNRCE650641TN', 'SMPJDT710948WY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2006-02-07 00:00:00', 'LVRBTH940646GU', 'CHPCRY710647VT', 'JHNPLA031224CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2009-01-27 00:00:00', 'MCGCYN580108MT', 'BTSMNC470430WY', 'LVRBTH940646GU');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-03-19 00:00:00', 'CRVCYN721049GA', 'DVDTRC920130OH', 'NLSPHL590452NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-03-22 00:00:00', 'CLRPML490364IA', 'CHPCRY710647VT', 'CLRPML490364IA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-07-27 00:00:00', 'MDYSTV591260VI', 'HLLJSH020506OR', 'WNTRCK500650AS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-04-06 00:00:00', 'LWSBRN000915MO', 'MRPJLU910449NJ', 'LWRJMS901226MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-05-19 00:00:00', 'CLRPML490364IA', 'MRPJLU910449NJ', 'BRRJSN620666MO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-03-03 00:00:00', 'LTTLCA920219CA', 'BRNRCE650641TN', 'GRCJNT750301FL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-02-12 00:00:00', 'LTTLCA920219CA', 'SWNJNN050252WI', 'BRRJSN620666MO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-05-15 00:00:00', 'MCGCYN580108MT', 'LPZJSN501151IN', 'WLTMCH961153MA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2012-12-18 00:00:00', 'CRVCYN721049GA', 'GRDCLD040871AL', 'FLRCND921170IL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2020-05-04 00:00:00', 'GRNJNN551068MI', 'DVDTRC920130OH', 'GRHLSI941222TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2016-03-05 00:00:00', 'CRVCYN721049GA', 'KLNJNT001201SC', 'STNSRH680450MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2005-04-13 00:00:00', 'CLRPML490364IA', 'KLNJNT001201SC', 'SWNJNN050252WI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2004-04-17 00:00:00', 'MCGCYN580108MT', 'JMSBRB620517MO', 'STNSRH680450MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-09-30 00:00:00', 'LVRBTH940646GU', 'GRDCLD040871AL', 'DMSJMS761144SC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2009-12-19 00:00:00', 'MCGCYN580108MT', 'BRRJSN620666MO', 'CLRPML490364IA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-12-14 00:00:00', 'MDYSTV591260VI', 'BRRJSN620666MO', 'THMTRC941247OR');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2021-10-19 00:00:00', 'GRNJNN551068MI', 'MRTBRN570846IN', 'STNSRH680450MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-03-04 00:00:00', 'CRVCYN721049GA', 'BRNRCE650641TN', 'GRDCLD040871AL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-09-18 00:00:00', 'LTTLCA920219CA', 'MRPJLU910449NJ', 'NLSPHL590452NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-03-31 00:00:00', 'CLRPML490364IA', 'GBSMRT810703ME', 'HLLRCE441248AS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2002-07-20 00:00:00', 'CLRPML490364IA', 'GBSMRT810703ME', 'GRHLSI941222TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2016-10-14 00:00:00', 'MCGCYN580108MT', 'GBSMRT810703ME', 'WLLKRN721059CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2004-01-14 00:00:00', 'MCGCYN580108MT', 'DVDTRC920130OH', 'LLSLND021202MS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2018-06-07 00:00:00', 'LWSBRN000915MO', 'HLLJSH020506OR', 'MRTLXA640570MD');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-10-23 00:00:00', 'LTTLCA920219CA', 'MRTBRN570846IN', 'CMPJNN041047GA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-10-15 00:00:00', 'GRNJNN551068MI', 'HLLJSH020506OR', 'WNTRCK500650AS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2018-07-28 00:00:00', 'MDYSTV591260VI', 'BRRJSN620666MO', 'GRDCLD040871AL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2004-05-02 00:00:00', 'LWSBRN000915MO', 'GBSMRT810703ME', 'VRTCRY440757MO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-09-27 00:00:00', 'CRVCYN721049GA', 'HLLJSH020506OR', 'VRTCRY440757MO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2020-09-09 00:00:00', 'LTTLCA920219CA', 'KLNJNT001201SC', 'SWNJNN050252WI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-03-02 00:00:00', 'LWSBRN000915MO', 'HLLJSH020506OR', 'HLLRCE441248AS');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-07-02 00:00:00', 'MDYSTV591260VI', 'NDRLZB901047SD', 'BRWSNE570670ME');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-05-08 00:00:00', 'LWSBRN000915MO', 'JMSBRB620517MO', 'GRHLSI941222TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2008-03-22 00:00:00', 'LVRBTH940646GU', 'GBSMRT810703ME', 'LVRBTH940646GU');
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2013-10-14 00:00:00', '2013-10-15 00:00:00', 'RED', 'Say relationship idea away include purpose.', 'WLLKRN721059CO', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2008-07-23 00:00:00', '2008-07-28 00:00:00', 'WHITE', 'Budget article likely without contain.', 'LSNBRB791126MT', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-09-16 00:00:00', '2004-09-17 00:00:00', 'ORANGE', 'Street president technology.', 'LLSLND021202MS', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-01-23 00:00:00', '2005-01-28 00:00:00', 'ORANGE', 'Despite data you eight moment role.', 'HLLRCE441248AS', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-02-25 00:00:00', '2023-02-26 00:00:00', 'WHITE', 'Agent author spring I move view best.', 'VRTCRY440757MO', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-06-27 00:00:00', '2005-06-30 00:00:00', 'RED', 'Program each blue kid single true.', 'WLTMCH961153MA', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2020-07-21 00:00:00', '2020-07-23 00:00:00', 'ORANGE', 'Our else collection final never thank.', 'DVDTRC920130OH', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-07-22 00:00:00', '2017-07-23 00:00:00', 'WHITE', 'Heart source do including kind finish.', 'CLRPML490364IA', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-11-30 00:00:00', '2022-12-01 00:00:00', 'ORANGE', 'Heavy law amount police back thing much.', 'JMSDWN870311KS', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2018-08-06 00:00:00', '2018-08-11 00:00:00', 'RED', 'Because create president far rest pick rise stop.', 'HLLRCE441248AS', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-11-11 00:00:00', '2001-11-13 00:00:00', 'GREEN', 'Meeting clear scientist ago space staff.', 'CLRPML490364IA', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-04-06 00:00:00', '2022-04-08 00:00:00', 'RED', 'Station central total end article summer contain anything.', 'HNRDNI511263AK', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-05-06 00:00:00', '2023-05-07 00:00:00', 'RED', 'Around skin brother quality.', 'NDRLZB901047SD', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2020-03-05 00:00:00', '2020-03-08 00:00:00', 'RED', 'Challenge blood than western different during different.', 'WLSSHR461108IN', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2012-05-14 00:00:00', '2012-05-16 00:00:00', 'RED', 'Range base nor.', 'HNRDNI511263AK', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2007-03-27 00:00:00', '2007-03-29 00:00:00', 'YELLOW', 'Throughout TV type yeah provide.', 'GRDCLD040871AL', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2006-10-29 00:00:00', '2006-11-02 00:00:00', 'GREEN', 'Care significant many member election hotel store traditional.', 'GRHLSI941222TX', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2006-04-19 00:00:00', '2006-04-22 00:00:00', 'GREEN', 'Put reach put forget table because air.', 'CLRPML490364IA', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2019-11-02 00:00:00', '2019-11-05 00:00:00', 'WHITE', 'Term bed fear dark teach.', 'MRTLXA640570MD', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2003-08-08 00:00:00', '2003-08-12 00:00:00', 'WHITE', 'Matter stage money behind ten city sing.', 'CHPCRY710647VT', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-01-23 00:00:00', '2001-01-28 00:00:00', 'RED', 'Parent everybody when film plant so reveal.', 'DVDTRC920130OH', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-09-14 00:00:00', '2014-09-19 00:00:00', 'ORANGE', 'Own threat return two life.', 'LWRJMS901226MT', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-11-27 00:00:00', '2014-11-30 00:00:00', 'RED', 'Air traditional decide rise.', 'NDRLZB901047SD', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2019-09-09 00:00:00', '2019-09-14 00:00:00', 'GREEN', 'Service cell situation leave public including ball.', 'NLSPHL590452NC', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2000-07-27 00:00:00', '2000-07-29 00:00:00', 'YELLOW', 'Grow plant born build own television indicate.', 'LSNBRB791126MT', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2008-07-15 00:00:00', '2008-07-16 00:00:00', 'ORANGE', 'Remain with agent tonight street one adult.', 'WLTMCH961153MA', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-09-03 00:00:00', '2010-09-06 00:00:00', 'WHITE', 'Military so white night lead.', 'LLSLND021202MS', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2008-05-16 00:00:00', '2008-05-17 00:00:00', 'GREEN', 'Position win reason drug business give.', 'GRCLXN521002PR', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-08-04 00:00:00', '2001-08-08 00:00:00', 'YELLOW', 'Strong whatever activity image cover evening.', 'WNTRCK500650AS', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2021-03-01 00:00:00', '2021-03-02 00:00:00', 'GREEN', 'Office sing boy budget investment high with direction.', 'LLSLND021202MS', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-07-29 00:00:00', '2001-07-30 00:00:00', 'ORANGE', 'These hard make wonder meeting space people.', 'WLTMCH961153MA', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-10-01 00:00:00', '2001-10-06 00:00:00', 'ORANGE', 'Single center popular enough woman bag explain.', 'NLSPHL590452NC', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2000-07-22 00:00:00', '2000-07-24 00:00:00', 'YELLOW', 'Attack discuss product media adult brother west.', 'NDRLZB901047SD', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2021-08-12 00:00:00', '2021-08-15 00:00:00', 'WHITE', 'Wind even crime far president staff understand.', 'MRTLXA640570MD', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2011-11-22 00:00:00', '2011-11-25 00:00:00', 'RED', 'Bring race sure piece whether art.', 'WNTRCK500650AS', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-07-17 00:00:00', '2022-07-18 00:00:00', 'GREEN', 'Television team worker maintain.', 'THMTRC941247OR', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2002-01-01 00:00:00', '2002-01-05 00:00:00', 'WHITE', 'There between century prevent phone organization right.', 'NDRLZB901047SD', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-03-25 00:00:00', '2001-03-30 00:00:00', 'GREEN', 'Also notice particularly.', 'NDRLZB901047SD', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2020-08-19 00:00:00', '2020-08-21 00:00:00', 'ORANGE', 'Safe position task.', 'CLRPML490364IA', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-09-01 00:00:00', '2005-09-05 00:00:00', 'GREEN', 'Order person effort.', 'LWRJMS901226MT', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-11-10 00:00:00', '2014-11-11 00:00:00', 'GREEN', 'And various behavior beat care culture doctor.', 'BRRJSN620666MO', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2000-04-06 00:00:00', '2000-04-07 00:00:00', 'WHITE', 'Huge people common suddenly around build road physical.', 'SMPJDT710948WY', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-01-05 00:00:00', '2017-01-06 00:00:00', 'ORANGE', 'Anyone card nothing style lay.', 'JHNPLA031224CO', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2012-06-07 00:00:00', '2012-06-08 00:00:00', 'ORANGE', 'Phone memory analysis author.', 'WLTMCH961153MA', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-03-20 00:00:00', '2022-03-22 00:00:00', 'GREEN', 'Prepare dark adult be why.', 'LSNBRB791126MT', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-04-14 00:00:00', '2023-04-17 00:00:00', 'RED', 'General begin star college home worry last history.', 'WLLKRN721059CO', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-01-13 00:00:00', '2023-01-14 00:00:00', 'WHITE', 'Price even skill require arrive.', 'BRRJSN620666MO', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-10-12 00:00:00', '2009-10-16 00:00:00', 'ORANGE', 'Still little support until.', 'SMPJDT710948WY', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-06-24 00:00:00', '2010-06-27 00:00:00', 'YELLOW', 'She response book understand push yes phone.', 'WNTRCK500650AS', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2007-01-15 00:00:00', '2007-01-16 00:00:00', 'GREEN', 'Stand must once would.', 'DMSJMS761144SC', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2002-09-18 00:00:00', '2002-09-19 00:00:00', 'YELLOW', 'Baby nice thousand town onto education environment.', 'STNSRH680450MT', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2021-01-26 00:00:00', '2021-01-29 00:00:00', 'RED', 'College do sit.', 'WLTMCH961153MA', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-01-25 00:00:00', '2023-01-26 00:00:00', 'WHITE', 'Partner model score bad small common street.', 'CHPCRY710647VT', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2000-05-31 00:00:00', '2000-06-03 00:00:00', 'WHITE', 'Pm tonight side energy.', 'GRHLSI941222TX', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-04-13 00:00:00', '2001-04-16 00:00:00', 'RED', 'Election seem decision middle production hospital artist.', 'NDRLZB901047SD', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2019-03-17 00:00:00', '2019-03-20 00:00:00', 'WHITE', 'Reflect parent reflect half.', 'DWRWLL010850NC', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2021-08-11 00:00:00', '2021-08-13 00:00:00', 'GREEN', 'Top successful body in vote strong hit investment.', 'GRDCLD040871AL', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2007-08-24 00:00:00', '2007-08-25 00:00:00', 'GREEN', 'Sister with science economic.', 'JMSDWN870311KS', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2011-05-10 00:00:00', '2011-05-13 00:00:00', 'ORANGE', 'Offer break within interest.', 'JHNPLA031224CO', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-09-28 00:00:00', '2010-09-30 00:00:00', 'YELLOW', 'Current at left while whether term.', 'CRVCYN721049GA', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-08-24 00:00:00', '2005-08-29 00:00:00', 'ORANGE', 'Evidence position former forward line film energy.', 'VRTCRY440757MO', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2015-10-08 00:00:00', '2015-10-13 00:00:00', 'WHITE', 'Relate no total field color traditional federal.', 'WLTMCH961153MA', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-08-26 00:00:00', '2017-08-29 00:00:00', 'RED', 'Cold top soldier surface politics finally woman.', 'GRHLSI941222TX', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-03-16 00:00:00', '2014-03-20 00:00:00', 'WHITE', 'Behind cover hour approach.', 'JMSDWN870311KS', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2007-09-08 00:00:00', '2007-09-10 00:00:00', 'YELLOW', 'Fill cell court beautiful.', 'WLTMCH961153MA', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2003-10-13 00:00:00', '2003-10-16 00:00:00', 'WHITE', 'One mission defense generation rather.', 'LSNBRB791126MT', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-02-08 00:00:00', '2009-02-10 00:00:00', 'GREEN', 'Impact from pay expert successful.', 'LLSLND021202MS', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2003-05-21 00:00:00', '2003-05-25 00:00:00', 'RED', 'Population road news data market notice.', 'DVDTRC920130OH', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-06-06 00:00:00', '2016-06-09 00:00:00', 'ORANGE', 'Whatever magazine third possible fact together expect growth.', 'JHNPLA031224CO', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-06-25 00:00:00', '2009-06-27 00:00:00', 'RED', 'Institution morning end risk each whom still.', 'GRCLXN521002PR', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2000-12-07 00:00:00', '2000-12-09 00:00:00', 'GREEN', 'Tree listen tend letter.', 'NDRLZB901047SD', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-09-21 00:00:00', '2023-09-25 00:00:00', 'WHITE', 'Among part open risk save difference.', 'DWRWLL010850NC', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2019-07-11 00:00:00', '2019-07-15 00:00:00', 'RED', 'Paper interest cut that specific sea PM.', 'SWNJNN050252WI', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2003-01-22 00:00:00', '2003-01-27 00:00:00', 'ORANGE', 'Specific court include item.', 'JHNPLA031224CO', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2007-03-06 00:00:00', '2007-03-11 00:00:00', 'ORANGE', 'Pay area rate policy test.', 'WLLKRN721059CO', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2002-12-08 00:00:00', '2002-12-10 00:00:00', 'YELLOW', 'Side themselves pretty season and key western.', 'GRCLXN521002PR', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-03-03 00:00:00', '2014-03-05 00:00:00', 'YELLOW', 'Beat begin card writer family score.', 'DVDTRC920130OH', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2024-11-22 00:00:00', '2024-11-23 00:00:00', 'GREEN', 'Impact part cup close police appear late lawyer.', 'LLSLND021202MS', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-09-07 00:00:00', '2004-09-10 00:00:00', 'RED', 'My game college bill pressure.', 'NDRLZB901047SD', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-09-24 00:00:00', '2005-09-29 00:00:00', 'ORANGE', 'Range current truth American.', 'JHNPLA031224CO', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-11-26 00:00:00', '2014-11-27 00:00:00', 'GREEN', 'Building middle interview get man.', 'DZIJRM900228MO', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-10-19 00:00:00', '2010-10-23 00:00:00', 'GREEN', 'Sell put however top want real week.', 'SWNJNN050252WI', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-02-02 00:00:00', '2022-02-06 00:00:00', 'YELLOW', 'Attack fund woman top.', 'HLLRCE441248AS', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-11-17 00:00:00', '2017-11-19 00:00:00', 'YELLOW', 'Record two sense next record ball whether.', 'WLSSHR461108IN', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-02-09 00:00:00', '2017-02-12 00:00:00', 'GREEN', 'Wear fear might administration author style thing worker.', 'WLTMCH961153MA', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-02-03 00:00:00', '2016-02-05 00:00:00', 'YELLOW', 'Brother well firm nearly skin.', 'WLTMCH961153MA', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-07-27 00:00:00', '2022-08-01 00:00:00', 'GREEN', 'Score model end seven billion dark.', 'DVDTRC920130OH', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-05-13 00:00:00', '2009-05-16 00:00:00', 'YELLOW', 'Business produce person real he suffer.', 'NLSPHL590452NC', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-06-08 00:00:00', '2004-06-11 00:00:00', 'WHITE', 'Myself without across under probably rather yet political.', 'BRWSNE570670ME', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2015-10-25 00:00:00', '2015-10-29 00:00:00', 'WHITE', 'Begin note really may small pull clear.', 'VGEKNN520157CA', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-02-17 00:00:00', '2022-02-21 00:00:00', 'ORANGE', 'Station billion paper specific her we.', 'JHNPLA031224CO', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-11-27 00:00:00', '2016-11-30 00:00:00', 'YELLOW', 'Lawyer food bag drug author indeed up.', 'MRTLXA640570MD', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2018-07-11 00:00:00', '2018-07-16 00:00:00', 'WHITE', 'Activity of hotel test federal.', 'WNTRCK500650AS', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-02-24 00:00:00', '2009-02-25 00:00:00', 'YELLOW', 'Region it song local.', 'SMPJDT710948WY', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-05-24 00:00:00', '2010-05-28 00:00:00', 'WHITE', 'Whether them marriage forward stay central.', 'WNTRCK500650AS', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2002-10-19 00:00:00', '2002-10-22 00:00:00', 'RED', 'List whom less skill sell child take.', 'DMSJMS761144SC', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-04-07 00:00:00', '2010-04-12 00:00:00', 'WHITE', 'Relationship process rich group.', 'DVDTRC920130OH', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2013-05-30 00:00:00', '2013-06-02 00:00:00', 'WHITE', 'Write great trial idea.', 'BRRJSN620666MO', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2015-04-27 00:00:00', '2015-05-01 00:00:00', 'GREEN', 'Others miss suggest.', 'WNTRCK500650AS', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-05-15 00:00:00', '2017-05-19 00:00:00', 'GREEN', 'Eight career where money may risk.', 'GRCLXN521002PR', 5);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2003-05-26 00:00:00', 'Card air beyond technology performance physical.', 'ECG', 'GBSMRT810703ME', 'HLLRCE441248AS', 2);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2003-02-26 00:00:00', 'Finally per who inside never.', 'ECG', 'DVDTRC920130OH', 'SWNJNN050252WI', 63);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2002-07-10 00:00:00', 'Water look blue subject organization sometimes soldier however.', 'MRI', 'BRNRCE650641TN', 'FLRCND921170IL', 96);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2009-04-18 00:00:00', 'Early personal whether edge available age author.', 'MRI', 'HLLJSH020506OR', 'CLRPML490364IA', 93);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2010-08-02 00:00:00', 'Anything admit note.', 'Blood Test', 'CHPCRY710647VT', 'WLTMCH961153MA', 39);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2011-12-29 00:00:00', 'News their nothing own perform home.', 'ECG', 'BTSMNC470430WY', 'VGEKNN520157CA', 24);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2008-02-28 00:00:00', 'Last word live tax safe.', 'MRI', 'SWNJNN050252WI', 'WLLKRN721059CO', 55);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2024-05-07 00:00:00', 'Tend follow effort technology billion apply.', 'X-Ray', 'LPZJSN501151IN', 'DVDTRC920130OH', 73);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2013-03-13 00:00:00', 'Describe heart wait.', 'X-Ray', 'NDRLZB901047SD', 'LWRJMS901226MT', 49);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2007-07-31 00:00:00', 'Season treat beautiful.', 'ECG', 'DVDTRC920130OH', 'HNRDNI511263AK', 68);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2003-11-17 00:00:00', 'Science member former seven public strong.', 'X-Ray', 'JMSBRB620517MO', 'CHPCRY710647VT', 88);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2018-10-10 00:00:00', 'Check piece good.', 'ECG', 'BTSMNC470430WY', 'SMPJDT710948WY', 35);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2019-10-07 00:00:00', 'Music grow alone carry put suddenly door question.', 'ECG', 'BTSMNC470430WY', 'GRDCLD040871AL', 11);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2000-03-26 00:00:00', 'Different education win office watch hand.', 'Blood Test', 'BTSMNC470430WY', 'GRCJNT750301FL', 2);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2020-06-13 00:00:00', 'Over painting program agent stand be.', 'Blood Test', 'NDRLZB901047SD', 'WLSSHR461108IN', 21);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2015-07-28 00:00:00', 'Easy option professional yard research rate.', 'ECG', 'ZHNSTN750516HI', 'GRHLSI941222TX', 58);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2009-04-17 00:00:00', 'Short help speak few assume participant after.', 'X-Ray', 'SWNJNN050252WI', 'CMPJNN041047GA', 39);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2023-07-30 00:00:00', 'Process individual they themselves modern east.', 'MRI', 'BTSMNC470430WY', 'THMTRC941247OR', 73);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2022-11-19 00:00:00', 'Enter blood evening move old above born.', 'MRI', 'DVDTRC920130OH', 'MRTLXA640570MD', 55);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2007-12-04 00:00:00', 'Dream avoid sense weight.', 'Blood Test', 'HLLJSH020506OR', 'DMSJMS761144SC', 77);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2011-12-06 00:00:00', 'First place traditional born news or shake.', 'X-Ray', 'JMSBRB620517MO', 'DWRWLL010850NC', 1);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2018-09-05 00:00:00', 'Once already card method.', 'MRI', 'GBSMRT810703ME', 'STNSRH680450MT', 89);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2016-04-30 00:00:00', 'Energy condition rich nearly hand.', 'X-Ray', 'GRDCLD040871AL', 'BRWSNE570670ME', 37);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2023-01-07 00:00:00', 'Single soldier blue.', 'Blood Test', 'DVDTRC920130OH', 'VRTCRY440757MO', 95);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2002-10-31 00:00:00', 'Produce security often suddenly thought.', 'X-Ray', 'CHPCRY710647VT', 'WNTRCK500650AS', 86);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2006-11-25 00:00:00', 'Leg source society reflect fall step southern.', 'MRI', 'GRDCLD040871AL', 'BRRJSN620666MO', 52);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2003-01-06 00:00:00', 'Teach despite at.', 'X-Ray', 'DVDTRC920130OH', 'LLSLND021202MS', 72);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2015-07-23 00:00:00', 'Lay maintain language.', 'X-Ray', 'MRTBRN570846IN', 'ZHNSTN750516HI', 75);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2012-01-14 00:00:00', 'Practice can conference event billion near research.', 'X-Ray', 'MRPJLU910449NJ', 'JMSDWN870311KS', 5);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2002-11-30 00:00:00', 'Development pay level short treat position.', 'MRI', 'SWNJNN050252WI', 'NLSPHL590452NC', 19);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2019-05-21 00:00:00', 'Become maintain father.', 'X-Ray', 'NDRLZB901047SD', 'NDRLZB901047SD', 41);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2007-07-24 00:00:00', 'Story film kitchen successful day tax.', 'Blood Test', 'KLNJNT001201SC', 'CRVCYN721049GA', 51);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2019-04-21 00:00:00', 'Response light spend claim major future year.', 'MRI', 'HLLJSH020506OR', 'JHNPLA031224CO', 5);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2013-07-21 00:00:00', 'Court goal responsibility include east.', 'MRI', 'GRDCLD040871AL', 'GRCLXN521002PR', 83);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2007-06-28 00:00:00', 'State play American any officer nice present.', 'Blood Test', 'CHPCRY710647VT', 'LVRBTH940646GU', 94);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2005-03-07 00:00:00', 'Notice myself head increase agency bed.', 'MRI', 'BTSMNC470430WY', 'LSNBRB791126MT', 3);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2023-06-21 00:00:00', 'Prepare common wrong what.', 'X-Ray', 'MRTBRN570846IN', 'DZIJRM900228MO', 86);
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

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
    "Email" CHAR(64) NOT NULL UNIQUE,
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
INSERT INTO "Ward" ("WardID", "Name") VALUES (1, 'Renal Care');
INSERT INTO "Ward" ("WardID", "Name") VALUES (2, 'Orthopedic Ward');
INSERT INTO "Ward" ("WardID", "Name") VALUES (3, 'Rehabilitation Unit');
INSERT INTO "Ward" ("WardID", "Name") VALUES (4, 'General Medicine');
INSERT INTO "Ward" ("WardID", "Name") VALUES (5, 'Post-Operative Recovery');
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('WRNVNE950255MP', 'Evan', 'Werner', '1995-02-15', 'ClAgHMAbXv5ChwhsYQ8IbdgZzCfzTlmIUrVAiD7PxwD0xU0Ojm', '+39392974654', leonjose@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('PHLKNN450618FM', 'Kenneth', 'Phillips', '1945-06-18', 'OOxtEqGVmlpipesibApbo3O5lkBeGixpdTN6GiYmsCuHr8gIa5', '+39396024841', lynchbrendan@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HLLMTT440908AK', 'Matthew', 'Hall', '1944-09-08', 'gy7dPA0eq9dbxxYLPdF7AA4GorXrhm4jL1bgpRdl5PErIz8aV6', '+39357208913', stephen36@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HNSMND750153MI', 'Amanda', 'Hensley', '1975-01-13', 'Y2Flu0wcg09qx9ZWgfOvCtqi1f4sP7xkyd2QDjLJk8OwEn3gVk', '+39300291926', hromero@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('TYLDVA440815NJ', 'Dave', 'Taylor', '1944-08-15', '8KfzE7aIqW1yqOgTydrwf8lAk0vyihPxdzu6xF3fqtJadepozh', '+39380642269', michellewebb@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('JNSMYA601256CO', 'Amy', 'Jones', '1960-12-16', 'x1LqFucJgdepC61Avi1RKCTBDpUvEQMqy12fAoyq2dkzPYBfeL', '+39315260558', reginakoch@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('PTTJHN671105AS', 'John', 'Patterson', '1967-11-05', 'rKcE3g4hr7OQ2PaWCMctot9SfGUBOWcyzyXK9VZIWWtd2MNTfN', '+39318399210', kbolton@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('VZQJSN460320MP', 'Jason', 'Vazquez', '1946-03-20', 'iBztvfb8rCcyLrHwcvDpMmccKNZTEajPJgOnDqCHued5Be6E7P', '+39355529170', luke65@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('WNSSSN710217MN', 'Susan', 'Owens', '1971-02-17', 'WK7RkPi1SmBz8fDX7tidPE0jOCFTiHn4RLF6ZNJ17RCyE8QsA3', '+39378006459', teresahurley@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('JHNMLN630730GA', 'Melanie', 'Johnson', '1963-07-30', 'HHYs2DH28FxwvkpkBXfqXqrOcZ8F0cHzB4nojkAX5Dddu2QuX8', '+39394929215', lopeztimothy@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('MNDJMS950728VI', 'James', 'Mendoza', '1995-07-28', 'rvSSe0HQO19uCxEtdCEcyfRJyXERQtVjrWhCPYyhS7aS9c3q4K', '+39371228556', heatherolsen@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('RMSDNS010541MP', 'Denise', 'Ramos', '2001-05-01', 'NqJrvb6hZu4PiqsRVRlkab10Er9nkPBOdr2Uf4n028V0RDFFMC', '+39334452370', ryan97@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CRTNTH760829NC', 'Anthony', 'Carter', '1976-08-29', 'NFGxmCZj6Ev93h62kwxtJ7Uvv8ieFnNu0QRKgqjkjPXQzeugRF', '+39324787252', alexandermelissa@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('MYRSHN880727OK', 'Shannon', 'Moyer', '1988-07-27', '6Pagwbz7oNQO8BTRqlbftIToyRobI1bjYf9WYTCIQCJIaPSaME', '+39305090983', zfleming@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SCHMGN860909AK', 'Megan', 'Schwartz', '1986-09-09', 'MpFocI1YCgKicIOyY5v4XlY6MRY79MPqmc9Za6nnaaIv3begza', '+39370779640', jeffery92@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CRTLTS530361PW', 'Latasha', 'Carter', '1953-03-21', '8yMjWPIPaCbMwRfbOwGOcaOdlEbL0D90RtfwnE6ORezuDLnsXL', '+39321772029', ericsullivan@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('BRNMLN910457NE', 'Melinda', 'Barnett', '1991-04-17', 'NKuDDqfANNBrPDRxdHxIzwJ0s0Sob0v9UX7e0N7dzy20bvzOba', '+39342782576', katrina69@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('JHNSHL630808WY', 'Shelby', 'Johnson', '1963-08-08', 'Awi5DJ6ouzPal4q8Ts1jnGOUa0dfydeWZklzyus6rGqfR7lyoU', '+39389207319', hperkins@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('WLTDNN970914NJ', 'Donna', 'Walton', '1997-09-14', 'Wrc4L0vginLIwLAgtvSc4sDnW2yCXNWyvZVFvwxw04aWHPXYwP', '+39312294173', erivas@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('FLTTMT700545MH', 'Timothy', 'Fletcher', '1970-05-05', 'OcJ1GJ4MLgECCFh8HLzRHm2WsWlX4zcShhg7UDLRWEV2DPf17F', '+39391412535', glennbarry@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('STSKMB590942AZ', 'Kimberly', 'Estes', '1959-09-02', 'njiYsgICV8WEHhuszE10UYQMlsOvCrEwZN1Sf0L6JfOAUTR9CZ', '+39314088481', xfoley@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HNNNDR640564CO', 'Andrew', 'Hanna', '1964-05-24', 'LN3BrNSGml7RNkY1YW4NBixXOUcmqXIWPMXKGztj743sp0XWTA', '+39367049106', mayrebecca@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CRRBNJ720551NJ', 'Benjamin', 'Carroll', '1972-05-11', 'J4mwedHq3qWRbQdt3xuWw2OXQ2TmAk2uODXaq3kJF2oCbnDeq1', '+39309897966', katherinehoward@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('DVSRCH690508TX', 'Richard', 'Davis', '1969-05-08', 'SJbfc95WVKvWUX8Y5W34RzBWSo4MfVqBOuZKEOVowXb4bYj4mj', '+39381746172', timrobinson@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CRNWLL911261DE', 'William', 'Crane', '1991-12-21', 'tZMhkH3prxqsicMNTA5PV8pxwNfgFlkd3mRYTXkBshaZ3XWDXI', '+39341944997', kimberlybenton@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('DYRMCH670563NJ', 'Michael', 'Dyer', '1967-05-23', 'q7WJngV4ti9l4ADBZq0yArS7bHGj3fQT2Xe5P80ZydCujjUZOv', '+39337214319', stephaniefletcher@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('GLNCRL880709AK', 'Carolyn', 'Glenn', '1988-07-09', 't8tN7mWlTEsU48VoDoU10ksXZHmlt6KUws0YqTQEXD74slI74U', '+39327761950', pbarber@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('FSHLSN821104NJ', 'Alison', 'Fisher', '1982-11-04', 'ep5jT4hp8J3DJuOZ8jMkZhq0TtA3e5R75HsgHdNlLP9zoJR81i', '+39307912474', gonzalezlisa@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('TYLCHR480222NY', 'Christian', 'Taylor', '1948-02-22', 'V5WyZV0zWJRCP4FZqkyxHsAZBNBikkVN8g43OlY67REJb2EyDW', '+39337833824', james14@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HLASHL701158NH', 'Ashley', 'Hale', '1970-11-18', 'HRLsQty3txqBvB8MhAlkMwDnVRV3QlgIO3XzBk6fAwRCRa7WgV', '+39314888273', martin09@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('RBNTNI600666DE', 'Tina', 'Robinson', '1960-06-26', 'EJSW38EcOGRw59ElrQ0BaYEQUyhtKkNZDIHopZayjUZ08knDiG', '+39348465504', jamesherbert@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('PLMJST640908MN', 'Justin', 'Palmer', '1964-09-08', 'FAOSpXYl9SPG8NVi7K5tIKwbKy8dol9PgNd1Lnem12qYvxKnFU', '+39303004750', fisherdonna@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('KRBJSN020817OK', 'Jason', 'Kirby', '2002-08-17', 'BQ1JjKRULzOS2N1MjTqTPdRdxfoGwf2s8wUEAwEYQMLNRFsoGm', '+39376983310', ninaconrad@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('WLLBRB731246MH', 'Barbara', 'Williams', '1973-12-06', 'dQ6QYqF3V8hSSyVPz8N30iiIUwJ8E4H8ylkWd8wvLnSwLFidUV', '+39342161452', isaacmartin@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('MROSTV711258NC', 'Steven', 'Moore', '1971-12-18', 'evfzzODi5EmnZKOVZwveC1nPFRlIR0vLcgGOt9mwIOS7S0LRKc', '+39312138286', lauradean@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SHPTHM730709MI', 'Thomas', 'Shepherd', '1973-07-09', 'i5HjV6IH8uFsGRyWGOaWRaXRtoHP0OOVIjK20ATtRxJ1irFWp6', '+39350343337', rick76@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HPKLXN961122ME', 'Alexander', 'Hopkins', '1996-11-22', 'gjx73TBFrhEHICeapkgxapn8RpqCOoxnWJhlpjRTuEiLMz2FqY', '+39332081937', taustin@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('WTKPGA721066NC', 'Paige', 'Watkins', '1972-10-26', 'J8bSdnzvcidCLAHEGLjdtl5mU7qNXCP8nmOpQ9eK8wAIWmWCm9', '+39359021727', chase37@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('VLSTMM790904TN', 'Tammy', 'Velasquez', '1979-09-04', '7KFmcmlizi20ucG05UWNkOS2BFaFHVTdpvk1AtQrZY210gyq9J', '+39318538136', abentley@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HRMDNL950156MO', 'Donald', 'Harmon', '1995-01-16', 'hhSDhorseGM8dqjLKXOqFPNrdDZGvsksKnY30z2vVQeOasMZyH', '+39391740928', faith88@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CRLKMB880122MT', 'Kimberly', 'Carlson', '1988-01-22', 'DziMHloTqxcRDaqNRTOjnKPoZLSmmCKguGdWz0BnxaBnjC9xRk', '+39351020154', teresaadams@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('BRNKNN630566RI', 'Kenneth', 'Burns', '1963-05-26', 'RNSFS3QveEQdMZLdr3DmhlrEngXWzLMxF2H124Pfu8A2cxnX2l', '+39339722174', rodney19@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SCTCHL680765NC', 'Chelsea', 'Scott', '1968-07-25', 'otJ1ZyXKiqqo9fragRfXORYzKvNifymUCJkM9fCw18Ek3KBj5T', '+39305049149', elizabethmaddox@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('WLSJRR540250AR', 'Jerry', 'Wilson', '1954-02-10', 'J4fTjRSN8ACFsUJvAx8PgN3ah1pIHlGAYNrpMPVgOMj7IdOE1M', '+39381726765', porterjeanne@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CLLRCH600128NH', 'Richard', 'Collins', '1960-01-28', 'Xo50h8VUNuwjC3226ZPZAJLKdg72LlxVOf2mNA3985a59S2MEF', '+39350076628', hughestimothy@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('LZNRNE751217DC', 'Renee', 'Lozano', '1975-12-17', 'lPuWGELz2p7DLbB8Qr0dyhLno9YSWs07bT1Fhavv34tRA18YyH', '+39314630597', qhunter@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('RSICHR601229TX', 'Christopher', 'Rios', '1960-12-29', 'BvLjMfLI7oQsWm9dUkL8H8iaYf3Aqsm9fdJTINp88SOyz0o0Zc', '+39375132026', michaelwarren@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('MLNJSP930748NJ', 'Joseph', 'Malone', '1993-07-08', '5wGfFX5JU1IHSzFE3VeL2ya03l4I3P0uPDCPz0TD1o9R3l84XX', '+39378044259', colleen06@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('WLLJFF790218FL', 'Jeff', 'Williams', '1979-02-18', 'edBkcPUD6qtFAkwxclE11nZ7YEuyxms6oJ89msesDiFqKI5JCS', '+39354042685', judithwatts@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('MNDKTH750257CA', 'Kathryn', 'Mendoza', '1975-02-17', '942OP618Dr2sY4FkaCGWZCO7hfk8VYxq1IrNLNijjN8nfnXeJg', '+39344145948', powersashley@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('LSTRGR871118MD', 'Roger', 'Lester', '1987-11-18', 'LNG2ADUEY8u9PchK6nZnebl0kuKPX6YoZBcNxJt6lBZPU2QfC5', '+39344103720', balljustin@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('BNDNDR491053PW', 'Andre', 'Bond', '1949-10-13', '20oClGMarNmWpKP9DZ7ufMnxQJcmEzcTFRRhw5FIswWMUCd0kE', '+39331512706', jvalencia@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('DNLMGN060954ME', 'Megan', 'Daniel', '2006-09-14', 'URuUmzZBtSwUuTW2OwkirJ9zlmhcTQrMs4BEbkW6du2nLBgn6i', '+39399294854', anichols@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HLLLYN970768NY', 'Lynn', 'Hall', '1997-07-28', 'gMSaNFiv0ZATKlgBjHsk60UjUADDMrXbCQYrVZMeix5GXXfjK1', '+39351085610', tlowery@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('LRSJHN731165AS', 'John', 'Larson', '1973-11-25', 'OBVewPJdeaAM9JWlQlGVLAXPlJU3lW3sQDMWYdPUsvs81EWcDs', '+39331548648', proctortara@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('BLLPLA710526VA', 'Paul', 'Bell', '1971-05-26', 'gWOzMmg9pSwm5lTxdTxPc6WipO2LFzjtxR7kmhsudcZmFkAoMs', '+39322935838', andersoncarolyn@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('DVNDVD450905TX', 'David', 'Davenport', '1945-09-05', 'wr4T8m0l7rk6eE9LnobkPfGRrPpfAJE3Fi16LrOSfa3DP6fUre', '+39367541523', matthewbrown@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('THMLSU951145DC', 'Luis', 'Thompson', '1995-11-05', 'jExehbfezmqdVtF4Q79MchGmf7vU8Uek5qSYrcXGvQWtlCwo5v', '+39341279783', beasleyjose@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('RSHPTR890171CO', 'Patrick', 'Rush', '1989-01-31', 'GecjLfOm2rNWkUUihDh7fjQ6A9QvjWXiyYt86rTnMUfvtVGSnr', '+39392522279', stonealexis@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('LSTJNN770152KY', 'Jennifer', 'Lester', '1977-01-12', 'NDBenoddsvhNaBz4xj9nz8dwwLuuC3f5ktAzVXHgpGpx8evRg1', '+39379689481', ekirk@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('LYNMGN950714IL', 'Megan', 'Lynch', '1995-07-14', 'jnbqxe88IKVP3wsKLptklIHgLQj5KpqUSDqGJa1OMpnffhnO0p', '+39369523800', zfrench@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HBBRCE731053UT', 'Eric', 'Hubbard', '1973-10-13', 'b2iLWu4Ypfz9trkBV0yH9ynxRxAK9fSiIRfCFW1vpld12u4SM6', '+39342073464', ashley34@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('NDRKVN580627OH', 'Kevin', 'Anderson', '1958-06-27', 'qqGzYsBgOLY46hJlqNBPhX9pWyKwJjcYWMoVhuHglR1RhIMUlp', '+39356774015', erinscott@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('PLORCH990414TN', 'Richard', 'Poole', '1999-04-14', 'UWg5xp3tY6uEQNzoyHKsXZXNuwu8w36RkW7wENWg57mHhvAKAD', '+39359318665', thomascole@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('GRHCRL040942DC', 'Caroline', 'Graham', '2004-09-02', '8PY9e4ot5iZGUXAm4BoF2ZHqdVewRefMdwqhMcqghz38Dsp1hS', '+39318493894', williamssteven@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('NDRJMS901069TX', 'James', 'Anderson', '1990-10-29', 'yw4OsBnVU4s0jFVgfRVbfgzC3urWhUGsA1Rl1qB6h58j2d41qr', '+39319535208', lmorton@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SCHLXN940662MO', 'Alexander', 'Schneider', '1994-06-22', 'CX2wUUIawI0fkvBNbZU5U4VLVhIQ04MKX7fCdoGRfXhWvpJPXU', '+39383920128', stevenpage@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CLYBNJ500151MD', 'Benjamin', 'Clayton', '1950-01-11', 'Qmpg8XIeOFjEDQWNzfZkE5KNgrBcxKaZztISScAonH79JtEpRm', '+39392886056', cruzjanet@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('PTRNNT771017PW', 'Annette', 'Peterson', '1977-10-17', 'vbCtFNf0tZL8xtBUGOaC8Sw92wwMizqGTSCnuMNPHaDStUJbZK', '+39361888337', jodi91@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('VLNDDE790449CT', 'Eddie', 'Valencia', '1979-04-09', 'dpURUyGh1EzrdlnqMmblmeRcXLFr9r8XgEeWdu5An7xbC4Ku1z', '+39314757692', crystalhogan@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('GRCBRT510220NC', 'Brittany', 'Garcia', '1951-02-20', '2QZVkei5pWFPPCqN3CTsLRTUhLrEas7oOr0C48tMGrnME3JfSV', '+39352195409', wgreen@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('RDGCRL720650GU', 'Carlos', 'Rodgers', '1972-06-10', 'XdCR7gr4byEYpTjCo64LHtWpWnYyhzXg3KG3iE7EyU67ZNx4pR', '+39328728499', curtisduncan@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('GRYDNL490844FM', 'Donald', 'Gray', '1949-08-04', 'ZczJ8BLRwJYXW81tItOkPtDJTEHupJsUsltqWRE5e8TUfzR9HD', '+39386926974', adam25@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HTHLRR511221PA', 'Larry', 'Heath', '1951-12-21', 'HwXBF6KisuVIsUay2zMdFtYOzc9ow0ple27Cfskx1w1ZwcHG4E', '+39381095935', ann62@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('JHNBRN880250DE', 'Brian', 'Johnson', '1988-02-10', 'DZMxWtqKZ59rCbnaSD0PwvR2JAuahEavRj2KX5NxlePQkxymAW', '+39316972167', gracewhite@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SCHNNA690948MO', 'Anne', 'Schmidt', '1969-09-08', 'X4nam6msvaI4Cetqt2xJLwlBiEogZmhHxqrfARahgoV6A7UvBx', '+39371920530', sjackson@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SCHMGN680547AS', 'Megan', 'Schroeder', '1968-05-07', 'oGND9K5rJrIwTeZoJvAhlfXWwx9EAz8mxwvMazuVrMFcpSqUhj', '+39344748889', smithcarol@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HRRMRC580158NY', 'Marcus', 'Herrera', '1958-01-18', '6UfPt5jaelvWi9aQlijPgrcBuS9oUGbCROCkjxh64ZoYXt3K1T', '+39306272414', clee@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('WLLNCH750267DE', 'Nicholas', 'Williams', '1975-02-27', 'NCysOqyXUJSPyFFMVznieQfnnYDqTlV9lnBI0iMlK7LDJEHS83', '+39340865621', madison38@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('LEEZCH941229AK', 'Zachary', 'Lee', '1994-12-29', 'cdLe32HQtQe9y5mXjSwgRmQjBAzwWYQh9SmilwLzltHNgMeS1I', '+39353171210', raven47@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SNCNGL700244VT', 'Angela', 'Sanchez', '1970-02-04', 'ViFLKm5ptOikRUb5ABIkcwmZrzdWMNSLvFneJNSxLkvrebaJft', '+39398765719', guerradonald@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('BKRMCH620819NC', 'Michael', 'Baker', '1962-08-19', 'FF3fb3ZfF7INaLjzCdOu7j1dlfS9jWS69KNfyhY3tGTvcggHEZ', '+39380571799', jasonmiller@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('JNSRNA650558PR', 'Aaron', 'Jones', '1965-05-18', 'ssolBlbHGgABizKJAWsPRYMfAv04GmLQxeJ43rgkynsrCKVBq6', '+39326887044', kimberly34@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SHWCHR751267TN', 'Christine', 'Shaw', '1975-12-27', 'BCe6hnCSoVFggL1jxcU8lCcQC7rlgyeBDaCdzV3EPi28b2jRKl', '+39329504694', brian93@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('PLOJNT990420VA', 'Jonathan', 'Poole', '1999-04-20', 'XZC6VR7TZR5GAY1f2PDSrP2jTQzM1WrDBKgWux93CmBxGlg5oT', '+39342798048', michaelpowell@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CSTNDR700502NJ', 'Andrea', 'Acosta', '1970-05-02', 'z6t4h95QLBtx46Bz0WefVLQr39cdD6Ew1zpZggnH5psOaVTwR0', '+39336288601', matthew28@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('HYNSML441156NY', 'Samuel', 'Haynes', '1944-11-16', 'tKDC3v0GhTsZYXlGMqJHAVFHxtHPY46BXSAzUFRIYpYpldX8MP', '+39330412108', fperry@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('GRRMCH660523GU', 'Michael', 'Garrett', '1966-05-23', 'FTRZpPysB4AmWl3vR0fJRLXZIAk84Oz4V3K1eUKQRac5U6fXi4', '+39375843645', rmartin@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('MCGJSM850416MO', 'Jasmine', 'Mcgee', '1985-04-16', 'HaB5mEcOsZnHYL4YgrskvkCMZq0SLsLX411O6hlm41ldK34OtQ', '+39396647474', kevin36@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('BRKRNE770501LA', 'Erin', 'Burke', '1977-05-01', '6NucUJlIrYq0HJYoS66CILjbGPfeN6cCCFnmqcHp1x5kbOmMfl', '+39331041069', emorris@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('LMAKTH600459ND', 'Kathleen', 'Lam', '1960-04-19', 'SUNpNjtm6GIKXsDnSyr73wJcQGEwh8z3gs5QHitPwNKw1zuqlF', '+39315403149', rhondaknox@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('SMTJHN890808PR', 'John', 'Smith', '1989-08-08', 'mGRNwD9kwlixxN5R8rJV05knbNjEfSJBp2DM5byN6tPb3EtBFr', '+39353232726', xlee@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('BSHBRN451126CO', 'Brianna', 'Bishop', '1945-11-26', 'tCKpGTD2CTdnOG3KnCrmfEe6oLW3s6xUdSB75fvTIIhbIKIQXd', '+39374739296', josephthomas@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('RMRMRK890127FL', 'Mark', 'Ramirez', '1989-01-27', '9kDUVtraESeAHncOvrLjfsVrFeuVAWKyULbboWWfZ98XmN0hMk', '+39357533561', hgilbert@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('CLODNE520403VI', 'Dean', 'Cole', '1952-04-03', '82qDau7aS6yWPcq9uR2PzgDbm51A7M43TTqgzmJW8yjzJE6hyQ', '+39382321743', hendersonsamuel@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('PTTPNN611249PA', 'Penny', 'Potts', '1961-12-09', 'BI0mxcx4XmMAXOicCjqyS9gqc88sG0deF4ww4WtLkmJ52DhVz8', '+39343019731', jennifercarpenter@example.net);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('FRSCHR531049IA', 'Christopher', 'Frost', '1953-10-09', 'GLjjRozPAFClkq6IJfvA6erEWSy00xK3TpTDqSkxgxuiliU8cM', '+39385843739', pattersonmatthew@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('BNSDGL540462PW', 'Douglas', 'Benson', '1954-04-22', '4KurP4lbYsB92etW5XoCU28A477luMTeYM8iwFx8xauZbqmg3O', '+39352474141', leetasha@example.com);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('GZMNTS641008MA', 'Natasha', 'Guzman', '1964-10-08', '2LEAKPdPRhf5bfR7xkvGojg7A8l3tvWPp5FRor8lOr6kkmZJXC', '+39308564173', nmiller@example.org);
INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber", "Email") VALUES ('RGRSHL901128MA', 'Shelly', 'Rogers', '1990-11-28', '1ey2646zQCWFce1AW74r2U0UDiXBxc3WDC4mC1MC4GbW6YMWrT', '+39327836618', brendapacheco@example.com);
INSERT INTO "Staff" ("StaffID") VALUES ('WRNVNE950255MP');
INSERT INTO "Staff" ("StaffID") VALUES ('VZQJSN460320MP');
INSERT INTO "Staff" ("StaffID") VALUES ('HNNNDR640564CO');
INSERT INTO "Staff" ("StaffID") VALUES ('GLNCRL880709AK');
INSERT INTO "Staff" ("StaffID") VALUES ('TYLCHR480222NY');
INSERT INTO "Staff" ("StaffID") VALUES ('WTKPGA721066NC');
INSERT INTO "Staff" ("StaffID") VALUES ('BLLPLA710526VA');
INSERT INTO "Staff" ("StaffID") VALUES ('DVNDVD450905TX');
INSERT INTO "Staff" ("StaffID") VALUES ('VLNDDE790449CT');
INSERT INTO "Staff" ("StaffID") VALUES ('CSTNDR700502NJ');
INSERT INTO "Patient" ("PatientID") VALUES ('CRTNTH760829NC');
INSERT INTO "Patient" ("PatientID") VALUES ('BRNMLN910457NE');
INSERT INTO "Patient" ("PatientID") VALUES ('WLTDNN970914NJ');
INSERT INTO "Patient" ("PatientID") VALUES ('FLTTMT700545MH');
INSERT INTO "Patient" ("PatientID") VALUES ('HNNNDR640564CO');
INSERT INTO "Patient" ("PatientID") VALUES ('CRNWLL911261DE');
INSERT INTO "Patient" ("PatientID") VALUES ('GLNCRL880709AK');
INSERT INTO "Patient" ("PatientID") VALUES ('FSHLSN821104NJ');
INSERT INTO "Patient" ("PatientID") VALUES ('HLASHL701158NH');
INSERT INTO "Patient" ("PatientID") VALUES ('RBNTNI600666DE');
INSERT INTO "Patient" ("PatientID") VALUES ('PLMJST640908MN');
INSERT INTO "Patient" ("PatientID") VALUES ('WTKPGA721066NC');
INSERT INTO "Patient" ("PatientID") VALUES ('CRLKMB880122MT');
INSERT INTO "Patient" ("PatientID") VALUES ('BRNKNN630566RI');
INSERT INTO "Patient" ("PatientID") VALUES ('WLLJFF790218FL');
INSERT INTO "Patient" ("PatientID") VALUES ('BNDNDR491053PW');
INSERT INTO "Patient" ("PatientID") VALUES ('HLLLYN970768NY');
INSERT INTO "Patient" ("PatientID") VALUES ('RSHPTR890171CO');
INSERT INTO "Patient" ("PatientID") VALUES ('LSTJNN770152KY');
INSERT INTO "Patient" ("PatientID") VALUES ('PLORCH990414TN');
INSERT INTO "Patient" ("PatientID") VALUES ('NDRJMS901069TX');
INSERT INTO "Patient" ("PatientID") VALUES ('CLYBNJ500151MD');
INSERT INTO "Patient" ("PatientID") VALUES ('VLNDDE790449CT');
INSERT INTO "Patient" ("PatientID") VALUES ('GRYDNL490844FM');
INSERT INTO "Patient" ("PatientID") VALUES ('HTHLRR511221PA');
INSERT INTO "Patient" ("PatientID") VALUES ('WLLNCH750267DE');
INSERT INTO "Patient" ("PatientID") VALUES ('CSTNDR700502NJ');
INSERT INTO "Patient" ("PatientID") VALUES ('GRRMCH660523GU');
INSERT INTO "Patient" ("PatientID") VALUES ('CLODNE520403VI');
INSERT INTO "Patient" ("PatientID") VALUES ('BNSDGL540462PW');
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('WRNVNE950255MP', 'Community arts worker', '+39312748374', 5);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('JHNMLN630730GA', 'Special educational needs teacher', '+39370742207', 5);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('MYRSHN880727OK', 'Journalist, broadcasting', '+39377281159', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('FLTTMT700545MH', 'Public relations officer', '+39363284749', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('DYRMCH670563NJ', 'Nurse, adult', '+39369060071', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('MROSTV711258NC', 'Heritage manager', '+39386306489', 5);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('SCTCHL680765NC', 'Scientist, research (maths)', '+39325391190', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('LZNRNE751217DC', 'Further education lecturer', '+39398418648', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('RSICHR601229TX', 'Administrator, local government', '+39385866557', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('BNDNDR491053PW', 'Conference centre manager', '+39370062694', 5);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('DVNDVD450905TX', 'Surveyor, hydrographic', '+39384787514', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('THMLSU951145DC', 'Horticulturist, amenity', '+39350223732', 5);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('RSHPTR890171CO', 'Nutritional therapist', '+39312848135', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('LSTJNN770152KY', 'Dramatherapist', '+39322428981', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('JHNBRN880250DE', 'Clinical cytogeneticist', '+39385700372', 2);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('WLLNCH750267DE', 'Surveyor, minerals', '+39311439312', 3);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('SHWCHR751267TN', 'Firefighter', '+39386673142', 4);
INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") VALUES ('CSTNDR700502NJ', 'Field seismologist', '+39328023539', 5);
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CRTNTH760829NC', 'Build above section eye white least.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('BRNMLN910457NE', 'Scene newspaper wall action leg.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('WLTDNN970914NJ', 'That radio middle understand purpose.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('FLTTMT700545MH', 'Happy some dream administration raise.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('HNNNDR640564CO', 'Act memory compare the beyond scientist.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CRNWLL911261DE', 'In seven even head whatever open politics economy.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('GLNCRL880709AK', 'Pattern main decision organization themselves drive form.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('FSHLSN821104NJ', 'Rest us entire laugh.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('HLASHL701158NH', 'Open black if wish health.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('RBNTNI600666DE', 'Space sense response.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('PLMJST640908MN', 'Discuss operation focus party firm move.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('WTKPGA721066NC', 'Score exactly pass just.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CRLKMB880122MT', 'Debate community nation condition think truth.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('BRNKNN630566RI', 'Talk item action perhaps forward budget practice.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('WLLJFF790218FL', 'Place gas direction carry two group.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('BNDNDR491053PW', 'Card American director act stay resource.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('HLLLYN970768NY', 'Player magazine condition.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('RSHPTR890171CO', 'Kitchen more say others who hundred.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('LSTJNN770152KY', 'Hold action policy indeed sister.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('PLORCH990414TN', 'And newspaper bring wonder soon.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('NDRJMS901069TX', 'Term value piece style notice property.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CLYBNJ500151MD', 'Area rest by fine than exactly.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('VLNDDE790449CT', 'Life marriage visit begin station lead understand.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('GRYDNL490844FM', 'Money society agency event add.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('HTHLRR511221PA', 'Campaign them expert into new hot.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('WLLNCH750267DE', 'Certainly red know.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CSTNDR700502NJ', 'Marriage pay become call throughout item the game.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('GRRMCH660523GU', 'Station defense peace morning hour.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('CLODNE520403VI', 'Share sell difficult official rule bill.');
INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES ('BNSDGL540462PW', 'Open often race former.');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2001-12-22 00:00:00', 'WRNVNE950255MP', 'LZNRNE751217DC', 'BNDNDR491053PW');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-06-04 00:00:00', 'HNNNDR640564CO', 'LZNRNE751217DC', 'NDRJMS901069TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-12-17 00:00:00', 'HNNNDR640564CO', 'MYRSHN880727OK', 'NDRJMS901069TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-04-23 00:00:00', 'WRNVNE950255MP', 'LZNRNE751217DC', 'BRNKNN630566RI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-01-17 00:00:00', 'VZQJSN460320MP', 'MROSTV711258NC', 'WTKPGA721066NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2001-12-13 00:00:00', 'WRNVNE950255MP', 'JHNMLN630730GA', 'WLTDNN970914NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2012-02-25 00:00:00', 'DVNDVD450905TX', 'JHNMLN630730GA', 'CRTNTH760829NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-01-25 00:00:00', 'TYLCHR480222NY', 'SHWCHR751267TN', 'GRRMCH660523GU');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2009-08-03 00:00:00', 'DVNDVD450905TX', 'FLTTMT700545MH', 'BNSDGL540462PW');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2012-05-01 00:00:00', 'CSTNDR700502NJ', 'SHWCHR751267TN', 'GRYDNL490844FM');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-01-10 00:00:00', 'GLNCRL880709AK', 'THMLSU951145DC', 'GRRMCH660523GU');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-11-29 00:00:00', 'TYLCHR480222NY', 'JHNMLN630730GA', 'RBNTNI600666DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-03-09 00:00:00', 'WTKPGA721066NC', 'WRNVNE950255MP', 'HLASHL701158NH');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2012-05-28 00:00:00', 'WRNVNE950255MP', 'RSHPTR890171CO', 'NDRJMS901069TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2007-03-19 00:00:00', 'WRNVNE950255MP', 'DVNDVD450905TX', 'CLYBNJ500151MD');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-10-17 00:00:00', 'VZQJSN460320MP', 'MYRSHN880727OK', 'GLNCRL880709AK');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2005-04-03 00:00:00', 'DVNDVD450905TX', 'MYRSHN880727OK', 'HLASHL701158NH');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-07-22 00:00:00', 'CSTNDR700502NJ', 'LSTJNN770152KY', 'LSTJNN770152KY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-07-27 00:00:00', 'BLLPLA710526VA', 'MYRSHN880727OK', 'HTHLRR511221PA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2005-05-04 00:00:00', 'CSTNDR700502NJ', 'SHWCHR751267TN', 'FLTTMT700545MH');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-12-21 00:00:00', 'GLNCRL880709AK', 'MROSTV711258NC', 'BRNMLN910457NE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2004-08-26 00:00:00', 'TYLCHR480222NY', 'WLLNCH750267DE', 'HTHLRR511221PA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-09-29 00:00:00', 'GLNCRL880709AK', 'MROSTV711258NC', 'CLODNE520403VI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2019-02-09 00:00:00', 'GLNCRL880709AK', 'SHWCHR751267TN', 'WLTDNN970914NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2007-10-19 00:00:00', 'WRNVNE950255MP', 'WRNVNE950255MP', 'PLMJST640908MN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-07-21 00:00:00', 'HNNNDR640564CO', 'LZNRNE751217DC', 'BRNKNN630566RI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-06-04 00:00:00', 'GLNCRL880709AK', 'RSICHR601229TX', 'VLNDDE790449CT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2008-02-19 00:00:00', 'TYLCHR480222NY', 'DYRMCH670563NJ', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-11-28 00:00:00', 'BLLPLA710526VA', 'RSHPTR890171CO', 'WLLJFF790218FL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-08-26 00:00:00', 'TYLCHR480222NY', 'RSICHR601229TX', 'FLTTMT700545MH');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-08-06 00:00:00', 'WRNVNE950255MP', 'DYRMCH670563NJ', 'CRNWLL911261DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-04-18 00:00:00', 'GLNCRL880709AK', 'SCTCHL680765NC', 'VLNDDE790449CT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-05-09 00:00:00', 'WRNVNE950255MP', 'SHWCHR751267TN', 'HNNNDR640564CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2021-07-23 00:00:00', 'HNNNDR640564CO', 'FLTTMT700545MH', 'BNSDGL540462PW');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2016-05-02 00:00:00', 'GLNCRL880709AK', 'FLTTMT700545MH', 'CRTNTH760829NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-09-30 00:00:00', 'GLNCRL880709AK', 'WLLNCH750267DE', 'HLASHL701158NH');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-08-14 00:00:00', 'WTKPGA721066NC', 'WRNVNE950255MP', 'RSHPTR890171CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-01-06 00:00:00', 'WRNVNE950255MP', 'WLLNCH750267DE', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2015-05-31 00:00:00', 'VLNDDE790449CT', 'CSTNDR700502NJ', 'WLLNCH750267DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2020-11-09 00:00:00', 'HNNNDR640564CO', 'RSHPTR890171CO', 'GLNCRL880709AK');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-11-17 00:00:00', 'GLNCRL880709AK', 'DVNDVD450905TX', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-10-19 00:00:00', 'WRNVNE950255MP', 'MROSTV711258NC', 'PLORCH990414TN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2015-06-29 00:00:00', 'TYLCHR480222NY', 'SHWCHR751267TN', 'LSTJNN770152KY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-02-23 00:00:00', 'WRNVNE950255MP', 'FLTTMT700545MH', 'GLNCRL880709AK');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-09-13 00:00:00', 'HNNNDR640564CO', 'LSTJNN770152KY', 'CLYBNJ500151MD');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-01-18 00:00:00', 'BLLPLA710526VA', 'JHNBRN880250DE', 'CRLKMB880122MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-07-18 00:00:00', 'TYLCHR480222NY', 'RSHPTR890171CO', 'BNSDGL540462PW');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2006-09-05 00:00:00', 'GLNCRL880709AK', 'MROSTV711258NC', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-10-27 00:00:00', 'TYLCHR480222NY', 'DVNDVD450905TX', 'BRNKNN630566RI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2009-06-29 00:00:00', 'CSTNDR700502NJ', 'FLTTMT700545MH', 'WLTDNN970914NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2016-11-27 00:00:00', 'BLLPLA710526VA', 'JHNBRN880250DE', 'GRYDNL490844FM');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2003-09-21 00:00:00', 'CSTNDR700502NJ', 'RSICHR601229TX', 'BNSDGL540462PW');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2008-05-22 00:00:00', 'DVNDVD450905TX', 'SHWCHR751267TN', 'GRYDNL490844FM');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-07-24 00:00:00', 'GLNCRL880709AK', 'WLLNCH750267DE', 'WLLNCH750267DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-07-03 00:00:00', 'TYLCHR480222NY', 'DYRMCH670563NJ', 'CLODNE520403VI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2018-07-08 00:00:00', 'VZQJSN460320MP', 'DYRMCH670563NJ', 'NDRJMS901069TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-07-03 00:00:00', 'CSTNDR700502NJ', 'THMLSU951145DC', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2005-07-29 00:00:00', 'DVNDVD450905TX', 'THMLSU951145DC', 'CRNWLL911261DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2006-12-11 00:00:00', 'WRNVNE950255MP', 'SHWCHR751267TN', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2020-02-29 00:00:00', 'TYLCHR480222NY', 'DVNDVD450905TX', 'GLNCRL880709AK');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2016-06-14 00:00:00', 'CSTNDR700502NJ', 'SCTCHL680765NC', 'VLNDDE790449CT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-01-13 00:00:00', 'DVNDVD450905TX', 'MYRSHN880727OK', 'PLMJST640908MN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2018-10-29 00:00:00', 'GLNCRL880709AK', 'RSHPTR890171CO', 'HNNNDR640564CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2014-10-26 00:00:00', 'TYLCHR480222NY', 'BNDNDR491053PW', 'PLORCH990414TN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2006-03-06 00:00:00', 'BLLPLA710526VA', 'DVNDVD450905TX', 'HLLLYN970768NY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2016-12-01 00:00:00', 'BLLPLA710526VA', 'SHWCHR751267TN', 'WLLJFF790218FL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-04-24 00:00:00', 'GLNCRL880709AK', 'MROSTV711258NC', 'PLMJST640908MN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2012-06-02 00:00:00', 'DVNDVD450905TX', 'SHWCHR751267TN', 'FLTTMT700545MH');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-07-01 00:00:00', 'BLLPLA710526VA', 'THMLSU951145DC', 'CLYBNJ500151MD');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-09-16 00:00:00', 'HNNNDR640564CO', 'LSTJNN770152KY', 'WLTDNN970914NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2005-02-21 00:00:00', 'WTKPGA721066NC', 'LZNRNE751217DC', 'WLLJFF790218FL');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-11-22 00:00:00', 'HNNNDR640564CO', 'DVNDVD450905TX', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2006-02-24 00:00:00', 'WRNVNE950255MP', 'WRNVNE950255MP', 'CRNWLL911261DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2015-10-14 00:00:00', 'VLNDDE790449CT', 'LSTJNN770152KY', 'CLODNE520403VI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2016-06-12 00:00:00', 'VZQJSN460320MP', 'LSTJNN770152KY', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-07-07 00:00:00', 'TYLCHR480222NY', 'JHNBRN880250DE', 'FLTTMT700545MH');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-05-15 00:00:00', 'TYLCHR480222NY', 'LSTJNN770152KY', 'HTHLRR511221PA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2001-03-19 00:00:00', 'BLLPLA710526VA', 'BNDNDR491053PW', 'PLORCH990414TN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2018-04-27 00:00:00', 'HNNNDR640564CO', 'BNDNDR491053PW', 'CRNWLL911261DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-12-06 00:00:00', 'TYLCHR480222NY', 'JHNBRN880250DE', 'BNDNDR491053PW');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2000-12-20 00:00:00', 'GLNCRL880709AK', 'RSICHR601229TX', 'PLMJST640908MN');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2006-02-21 00:00:00', 'HNNNDR640564CO', 'JHNMLN630730GA', 'HNNNDR640564CO');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2005-10-11 00:00:00', 'VLNDDE790449CT', 'WRNVNE950255MP', 'HLLLYN970768NY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2019-09-04 00:00:00', 'WTKPGA721066NC', 'JHNMLN630730GA', 'GLNCRL880709AK');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2002-05-06 00:00:00', 'WTKPGA721066NC', 'DVNDVD450905TX', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2018-09-16 00:00:00', 'HNNNDR640564CO', 'LSTJNN770152KY', 'BRNKNN630566RI');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2009-10-30 00:00:00', 'VZQJSN460320MP', 'CSTNDR700502NJ', 'NDRJMS901069TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-08-29 00:00:00', 'CSTNDR700502NJ', 'RSHPTR890171CO', 'CRLKMB880122MT');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2013-03-23 00:00:00', 'VLNDDE790449CT', 'SHWCHR751267TN', 'WLLNCH750267DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-10-21 00:00:00', 'HNNNDR640564CO', 'RSICHR601229TX', 'HLLLYN970768NY');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2008-10-08 00:00:00', 'GLNCRL880709AK', 'RSHPTR890171CO', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2011-12-29 00:00:00', 'BLLPLA710526VA', 'RSHPTR890171CO', 'HTHLRR511221PA');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2024-11-08 00:00:00', 'VZQJSN460320MP', 'MROSTV711258NC', 'FSHLSN821104NJ');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2005-07-05 00:00:00', 'GLNCRL880709AK', 'JHNMLN630730GA', 'GRRMCH660523GU');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2017-09-21 00:00:00', 'TYLCHR480222NY', 'DVNDVD450905TX', 'CRNWLL911261DE');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2023-01-30 00:00:00', 'WRNVNE950255MP', 'DYRMCH670563NJ', 'CRTNTH760829NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2022-02-22 00:00:00', 'VLNDDE790449CT', 'SHWCHR751267TN', 'CRTNTH760829NC');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2010-01-21 00:00:00', 'VZQJSN460320MP', 'WLLNCH750267DE', 'NDRJMS901069TX');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2007-12-03 00:00:00', 'BLLPLA710526VA', 'DVNDVD450905TX', 'BNSDGL540462PW');
INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") VALUES ('2012-02-12 00:00:00', 'WRNVNE950255MP', 'BNDNDR491053PW', 'CLYBNJ500151MD');
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2015-01-24 00:00:00', '2015-01-26 00:00:00', 'YELLOW', 'Individual morning mean site civil.', 'BRNKNN630566RI', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2006-11-25 00:00:00', '2006-11-28 00:00:00', 'WHITE', 'Just wife community.', 'CRNWLL911261DE', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2008-11-28 00:00:00', '2008-11-29 00:00:00', 'WHITE', 'Door any leader relationship ability yard on.', 'HTHLRR511221PA', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2002-10-09 00:00:00', '2002-10-10 00:00:00', 'RED', 'Physical front remember throughout any meet.', 'HLLLYN970768NY', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2021-01-25 00:00:00', '2021-01-29 00:00:00', 'RED', 'Management grow sport so option.', 'CRLKMB880122MT', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-03-16 00:00:00', '2022-03-20 00:00:00', 'RED', 'World account too speech.', 'RBNTNI600666DE', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-11-28 00:00:00', '2004-12-03 00:00:00', 'GREEN', 'Song what pick reach.', 'BNDNDR491053PW', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-10-09 00:00:00', '2016-10-14 00:00:00', 'ORANGE', 'Expect speech want general cut.', 'CRLKMB880122MT', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2000-01-22 00:00:00', '2000-01-25 00:00:00', 'YELLOW', 'Itself camera long find.', 'FSHLSN821104NJ', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-10-23 00:00:00', '2023-10-26 00:00:00', 'WHITE', 'Finish put market always opportunity industry social.', 'BRNKNN630566RI', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-06-23 00:00:00', '2016-06-24 00:00:00', 'RED', 'Family culture long whether message capital age.', 'CSTNDR700502NJ', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-12-29 00:00:00', '2014-12-30 00:00:00', 'GREEN', 'Growth walk hospital cold.', 'NDRJMS901069TX', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2011-09-12 00:00:00', '2011-09-14 00:00:00', 'WHITE', 'Ground generation likely direction.', 'FSHLSN821104NJ', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-05-25 00:00:00', '2022-05-28 00:00:00', 'YELLOW', 'Moment likely someone.', 'PLORCH990414TN', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2011-11-09 00:00:00', '2011-11-14 00:00:00', 'ORANGE', 'Fear response bill national call.', 'WTKPGA721066NC', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-08-13 00:00:00', '2004-08-17 00:00:00', 'YELLOW', 'Face network interview.', 'WLLJFF790218FL', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2012-02-18 00:00:00', '2012-02-23 00:00:00', 'WHITE', 'Trade feeling many.', 'HTHLRR511221PA', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2008-07-29 00:00:00', '2008-08-03 00:00:00', 'WHITE', 'National campaign mouth sister network.', 'FLTTMT700545MH', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-01-15 00:00:00', '2009-01-18 00:00:00', 'RED', 'Argue plan might television plan benefit.', 'WLLNCH750267DE', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2018-10-23 00:00:00', '2018-10-26 00:00:00', 'WHITE', 'Executive happen build of.', 'HTHLRR511221PA', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-10-15 00:00:00', '2005-10-19 00:00:00', 'RED', 'Tree better exactly on election.', 'HNNNDR640564CO', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2021-10-21 00:00:00', '2021-10-26 00:00:00', 'RED', 'Camera go investment meeting.', 'PLORCH990414TN', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-06-08 00:00:00', '2023-06-11 00:00:00', 'RED', 'Character all where international choose.', 'FSHLSN821104NJ', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-11-15 00:00:00', '2022-11-18 00:00:00', 'GREEN', 'Base cause city score white man.', 'CLYBNJ500151MD', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2002-07-13 00:00:00', '2002-07-15 00:00:00', 'WHITE', 'Leg until range.', 'GRYDNL490844FM', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-11-05 00:00:00', '2010-11-07 00:00:00', 'WHITE', 'Whom pay together life thus.', 'HLASHL701158NH', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-12-25 00:00:00', '2009-12-29 00:00:00', 'WHITE', 'About poor recent tonight though language.', 'BNSDGL540462PW', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-10-25 00:00:00', '2016-10-26 00:00:00', 'YELLOW', 'Next positive huge long popular four view sort.', 'BNDNDR491053PW', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-03-15 00:00:00', '2017-03-20 00:00:00', 'GREEN', 'Gas person put agreement.', 'CSTNDR700502NJ', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-02-02 00:00:00', '2001-02-07 00:00:00', 'RED', 'Call institution top step politics seek.', 'CRLKMB880122MT', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2000-01-30 00:00:00', '2000-02-01 00:00:00', 'YELLOW', 'Likely everything expect scientist respond story close.', 'FSHLSN821104NJ', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-05-15 00:00:00', '2016-05-20 00:00:00', 'GREEN', 'Research leg may newspaper human.', 'VLNDDE790449CT', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2018-08-30 00:00:00', '2018-08-31 00:00:00', 'RED', 'Industry sing his discussion despite national.', 'PLORCH990414TN', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-05-23 00:00:00', '2001-05-27 00:00:00', 'WHITE', 'College animal man will.', 'RBNTNI600666DE', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-05-26 00:00:00', '2010-05-31 00:00:00', 'GREEN', 'International commercial his Mr focus how hit.', 'BNDNDR491053PW', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2003-12-21 00:00:00', '2003-12-25 00:00:00', 'WHITE', 'Cultural ten good.', 'CRLKMB880122MT', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2012-01-09 00:00:00', '2012-01-11 00:00:00', 'YELLOW', 'New mention the laugh between learn.', 'GRRMCH660523GU', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2012-10-02 00:00:00', '2012-10-03 00:00:00', 'ORANGE', 'Agent organization lawyer stuff in about.', 'HLLLYN970768NY', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-01-28 00:00:00', '2009-02-01 00:00:00', 'ORANGE', 'Read mouth challenge ball national peace.', 'CLYBNJ500151MD', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-07-21 00:00:00', '2005-07-23 00:00:00', 'YELLOW', 'National local most central shake late property.', 'LSTJNN770152KY', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-03-30 00:00:00', '2004-04-04 00:00:00', 'RED', 'Choose see reflect democratic.', 'HLASHL701158NH', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2015-01-16 00:00:00', '2015-01-17 00:00:00', 'GREEN', 'Continue plan event course nice.', 'BRNKNN630566RI', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2018-09-11 00:00:00', '2018-09-14 00:00:00', 'WHITE', 'Study team floor science often.', 'CLYBNJ500151MD', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2007-07-21 00:00:00', '2007-07-25 00:00:00', 'ORANGE', 'Page tough box everybody including once.', 'BNDNDR491053PW', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-08-25 00:00:00', '2022-08-29 00:00:00', 'YELLOW', 'Tend cause sing best land receive nation.', 'WLLNCH750267DE', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2015-08-17 00:00:00', '2015-08-22 00:00:00', 'GREEN', 'Time laugh music apply third investment.', 'HTHLRR511221PA', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2013-05-23 00:00:00', '2013-05-25 00:00:00', 'GREEN', 'Unit of skill.', 'HNNNDR640564CO', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2006-03-21 00:00:00', '2006-03-24 00:00:00', 'YELLOW', 'Game improve reality realize.', 'BNDNDR491053PW', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-08-18 00:00:00', '2004-08-20 00:00:00', 'WHITE', 'Process national teacher.', 'HTHLRR511221PA', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2020-04-27 00:00:00', '2020-04-29 00:00:00', 'GREEN', 'Step produce relationship site program thus.', 'CRLKMB880122MT', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-12-25 00:00:00', '2017-12-27 00:00:00', 'WHITE', 'Meet best season one cause six customer fine.', 'GLNCRL880709AK', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-02-26 00:00:00', '2001-03-03 00:00:00', 'RED', 'Look class there test door sometimes.', 'WLLJFF790218FL', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2007-07-10 00:00:00', '2007-07-12 00:00:00', 'ORANGE', 'Performance above PM article number.', 'CRLKMB880122MT', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-06-09 00:00:00', '2016-06-12 00:00:00', 'YELLOW', 'Represent detail truth hard laugh they director arm.', 'LSTJNN770152KY', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2024-04-12 00:00:00', '2024-04-16 00:00:00', 'WHITE', 'Available why security figure call might.', 'FSHLSN821104NJ', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-08-10 00:00:00', '2004-08-12 00:00:00', 'YELLOW', 'Treatment peace cut short run beat whether.', 'PLMJST640908MN', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2010-10-31 00:00:00', '2010-11-01 00:00:00', 'WHITE', 'Much little around tree wish leader beat.', 'GLNCRL880709AK', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2013-04-27 00:00:00', '2013-05-01 00:00:00', 'RED', 'Commercial direction against staff site.', 'VLNDDE790449CT', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-02-06 00:00:00', '2022-02-10 00:00:00', 'WHITE', 'Body your say eye physical.', 'GRRMCH660523GU', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2006-06-23 00:00:00', '2006-06-27 00:00:00', 'WHITE', 'Check end better coach.', 'RSHPTR890171CO', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2018-05-22 00:00:00', '2018-05-23 00:00:00', 'RED', 'Ball agency spend appear quite.', 'BNDNDR491053PW', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2016-05-31 00:00:00', '2016-06-05 00:00:00', 'YELLOW', 'As represent follow return.', 'WLTDNN970914NJ', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2003-01-06 00:00:00', '2003-01-07 00:00:00', 'RED', 'Move pretty ability.', 'VLNDDE790449CT', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2003-01-14 00:00:00', '2003-01-17 00:00:00', 'YELLOW', 'Usually give its pick middle force.', 'BNDNDR491053PW', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2021-02-17 00:00:00', '2021-02-21 00:00:00', 'WHITE', 'Great memory reach those name first age.', 'CLYBNJ500151MD', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2011-08-09 00:00:00', '2011-08-10 00:00:00', 'YELLOW', 'City add condition.', 'GRYDNL490844FM', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-07-25 00:00:00', '2023-07-26 00:00:00', 'ORANGE', 'Court particular will onto.', 'CSTNDR700502NJ', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2006-01-16 00:00:00', '2006-01-20 00:00:00', 'RED', 'Old quality father office kind.', 'WTKPGA721066NC', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2022-12-27 00:00:00', '2023-01-01 00:00:00', 'RED', 'Use son fear vote amount.', 'WTKPGA721066NC', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-08-03 00:00:00', '2001-08-07 00:00:00', 'RED', 'Mean want respond eight Democrat movement wrong.', 'HLASHL701158NH', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-10-23 00:00:00', '2009-10-26 00:00:00', 'ORANGE', 'Particularly national near wait put exactly chair.', 'WLLNCH750267DE', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2002-01-13 00:00:00', '2002-01-18 00:00:00', 'ORANGE', 'Late describe state student rich.', 'RBNTNI600666DE', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2008-01-09 00:00:00', '2008-01-12 00:00:00', 'WHITE', 'Agreement month miss thousand fire movement know.', 'RBNTNI600666DE', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-11-06 00:00:00', '2004-11-08 00:00:00', 'RED', 'Economy bar source party set certainly.', 'GRRMCH660523GU', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2006-11-02 00:00:00', '2006-11-03 00:00:00', 'ORANGE', 'Human could road home magazine fill blood more.', 'WLTDNN970914NJ', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-04-19 00:00:00', '2005-04-23 00:00:00', 'YELLOW', 'While growth at five specific current.', 'WLLNCH750267DE', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2002-11-24 00:00:00', '2002-11-26 00:00:00', 'RED', 'Itself film election meet.', 'CRNWLL911261DE', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2021-11-23 00:00:00', '2021-11-24 00:00:00', 'RED', 'Across return back soldier.', 'BRNMLN910457NE', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2005-08-16 00:00:00', '2005-08-20 00:00:00', 'ORANGE', 'Environmental cold pass both summer game.', 'LSTJNN770152KY', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2020-08-13 00:00:00', '2020-08-18 00:00:00', 'WHITE', 'Visit line reason interesting all.', 'PLMJST640908MN', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2012-05-20 00:00:00', '2012-05-25 00:00:00', 'YELLOW', 'Speech pattern back police.', 'CRLKMB880122MT', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2018-04-02 00:00:00', '2018-04-05 00:00:00', 'RED', 'Modern treatment man gun pressure business.', 'HLASHL701158NH', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2008-08-03 00:00:00', '2008-08-05 00:00:00', 'WHITE', 'Pretty which final mean child story.', 'FLTTMT700545MH', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-01-02 00:00:00', '2004-01-05 00:00:00', 'RED', 'Fine sell ago yeah.', 'BRNMLN910457NE', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-01-12 00:00:00', '2004-01-16 00:00:00', 'GREEN', 'Responsibility accept listen law memory national.', 'PLMJST640908MN', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2019-06-27 00:00:00', '2019-06-30 00:00:00', 'YELLOW', 'Small easy simply approach staff tonight.', 'HLASHL701158NH', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2013-11-24 00:00:00', '2013-11-28 00:00:00', 'RED', 'Property far reason risk prevent.', 'WLLJFF790218FL', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2020-03-05 00:00:00', '2020-03-09 00:00:00', 'WHITE', 'Rock officer win no half.', 'GRRMCH660523GU', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2023-11-08 00:00:00', '2023-11-10 00:00:00', 'RED', 'Consider material owner Republican fear animal.', 'BRNKNN630566RI', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-11-12 00:00:00', '2014-11-14 00:00:00', 'GREEN', 'Leader ahead better late night what wear.', 'CLYBNJ500151MD', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2004-09-28 00:00:00', '2004-10-03 00:00:00', 'WHITE', 'City during realize among thing top realize.', 'WTKPGA721066NC', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2024-01-23 00:00:00', '2024-01-26 00:00:00', 'RED', 'List return no this.', 'HTHLRR511221PA', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2024-11-21 00:00:00', '2024-11-24 00:00:00', 'RED', 'Born white there wrong concern either manager.', 'FLTTMT700545MH', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-07-07 00:00:00', '2014-07-10 00:00:00', 'RED', 'Appear now career system.', 'VLNDDE790449CT', 1);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2013-06-11 00:00:00', '2013-06-16 00:00:00', 'YELLOW', 'Business protect specific beautiful phone station into nothing.', 'NDRJMS901069TX', 2);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2017-11-02 00:00:00', '2017-11-05 00:00:00', 'ORANGE', 'Far sport environmental blood dark wonder.', 'CRLKMB880122MT', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2009-11-08 00:00:00', '2009-11-12 00:00:00', 'WHITE', 'Fill leg what international.', 'PLORCH990414TN', 4);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2001-06-14 00:00:00', '2001-06-16 00:00:00', 'WHITE', 'Mother way maintain set white.', 'BRNKNN630566RI', 3);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2015-10-29 00:00:00', '2015-11-02 00:00:00', 'RED', 'Company everyone guy before guy sister.', 'WLLJFF790218FL', 5);
INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", "PatientID", "WardID") VALUES ('2014-12-28 00:00:00', '2015-01-02 00:00:00', 'GREEN', 'Me compare four early once look how.', 'HNNNDR640564CO', 5);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2012-11-28 00:00:00', 'Why third financial.', 'ECG', 'WLLNCH750267DE', 'CRTNTH760829NC', 50);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2000-11-03 00:00:00', 'Region walk dream maybe maybe kitchen.', 'X-Ray', 'DVNDVD450905TX', 'BRNMLN910457NE', 71);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2024-12-30 00:00:00', 'Whether action choice marriage involve inside million three.', 'ECG', 'LZNRNE751217DC', 'WLTDNN970914NJ', 59);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2015-05-20 00:00:00', 'Pick draw television media.', 'Blood Test', 'LSTJNN770152KY', 'FLTTMT700545MH', 68);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2008-04-29 00:00:00', 'Try popular but peace wish wall early some.', 'ECG', 'DVNDVD450905TX', 'HNNNDR640564CO', 24);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2013-02-27 00:00:00', 'Industry of leg tend star Republican likely mention.', 'X-Ray', 'MYRSHN880727OK', 'CRNWLL911261DE', 31);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2023-12-30 00:00:00', 'Parent it building sort office four.', 'MRI', 'WRNVNE950255MP', 'GLNCRL880709AK', 58);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2015-09-12 00:00:00', 'Radio effort fine total.', 'ECG', 'LZNRNE751217DC', 'FSHLSN821104NJ', 24);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2001-04-22 00:00:00', 'Mission wife seven.', 'ECG', 'JHNBRN880250DE', 'HLASHL701158NH', 61);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2006-03-05 00:00:00', 'Administration among suddenly between interest toward gas.', 'Blood Test', 'RSICHR601229TX', 'RBNTNI600666DE', 6);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2003-09-26 00:00:00', 'Once research agent role.', 'ECG', 'MYRSHN880727OK', 'PLMJST640908MN', 56);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2014-04-19 00:00:00', 'Trial so investment man.', 'MRI', 'WRNVNE950255MP', 'WTKPGA721066NC', 31);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2006-03-16 00:00:00', 'Value continue common affect only.', 'ECG', 'CSTNDR700502NJ', 'CRLKMB880122MT', 37);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2006-06-30 00:00:00', 'Statement consumer ability use law memory radio animal.', 'Blood Test', 'DYRMCH670563NJ', 'BRNKNN630566RI', 41);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2008-10-12 00:00:00', 'Work wife fact still those trouble during.', 'MRI', 'CSTNDR700502NJ', 'WLLJFF790218FL', 61);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2022-05-20 00:00:00', 'Market again save street concern.', 'ECG', 'SHWCHR751267TN', 'BNDNDR491053PW', 83);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2007-04-15 00:00:00', 'Fact for cultural such degree.', 'ECG', 'LSTJNN770152KY', 'HLLLYN970768NY', 9);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2007-09-26 00:00:00', 'A outside college rise cut majority.', 'ECG', 'DYRMCH670563NJ', 'RSHPTR890171CO', 58);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2005-11-21 00:00:00', 'Alone poor once factor.', 'ECG', 'LZNRNE751217DC', 'LSTJNN770152KY', 56);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2005-11-19 00:00:00', 'Matter safe quite beautiful military move left.', 'ECG', 'FLTTMT700545MH', 'PLORCH990414TN', 58);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2003-07-11 00:00:00', 'Face until up catch task.', 'Blood Test', 'SHWCHR751267TN', 'NDRJMS901069TX', 11);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2009-11-21 00:00:00', 'Town kind they foreign small.', 'Blood Test', 'FLTTMT700545MH', 'CLYBNJ500151MD', 42);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2015-01-31 00:00:00', 'Different could piece democratic fine school.', 'MRI', 'CSTNDR700502NJ', 'VLNDDE790449CT', 83);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2000-08-08 00:00:00', 'If project college bar sense.', 'Blood Test', 'JHNBRN880250DE', 'GRYDNL490844FM', 7);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2001-01-13 00:00:00', 'Outside identify church them spend market method.', 'X-Ray', 'THMLSU951145DC', 'HTHLRR511221PA', 88);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2021-11-23 00:00:00', 'I reality hard story.', 'Blood Test', 'LSTJNN770152KY', 'WLLNCH750267DE', 86);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2004-01-23 00:00:00', 'Describe drug whose bill natural.', 'X-Ray', 'DVNDVD450905TX', 'CSTNDR700502NJ', 33);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2016-04-26 00:00:00', 'Keep very scene approach.', 'Blood Test', 'RSHPTR890171CO', 'GRRMCH660523GU', 62);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2020-12-14 00:00:00', 'Race seem other audience road.', 'Blood Test', 'MYRSHN880727OK', 'CLODNE520403VI', 53);
INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", "MedicalEvent") VALUES ('2017-03-22 00:00:00', 'There example evening.', 'X-Ray', 'MYRSHN880727OK', 'BNSDGL540462PW', 55);

EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

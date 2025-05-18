    CREATE SCHEMA IF NOT EXISTS keycloak;

    DO $$
        BEGIN
        CREATE TYPE severity AS ENUM ('WHITE', 'GREEN', 'YELLOW', 'ORANGE', 'RED');
    EXCEPTION
        WHEN duplicate_object THEN null;
    END $$;

    CREATE TABLE IF NOT EXISTS users (
        id CHAR(16) PRIMARY KEY,
        name TEXT NOT NULL,
        surname TEXT NOT NULL,
        date_of_birth DATE NOT NULL,
        sub CHAR(50) NOT NULL UNIQUE,
        phone_number CHAR(15),
        email TEXT
    );

    CREATE INDEX IF NOT EXISTS idx_users_id ON users(id);
    CREATE INDEX IF NOT EXISTS idx_users_sub ON users(sid);

    CREATE TABLE IF NOT EXISTS staff (
        staff_id CHAR(16) REFERENCES users(id) PRIMARY KEY
    );

    CREATE TABLE IF NOT EXISTS patient (
        patient_id CHAR(16) REFERENCES users(ID) PRIMARY KEY
    );

    CREATE TABLE IF NOT EXISTS ward (
        ward_id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS doctor (
        doctor_id CHAR(16) REFERENCES users(ID) PRIMARY KEY,
        med_specialization TEXT,
        office_phone_number CHAR(15),
        ward_id SERIAL REFERENCES ward(ward_id)
    );

    CREATE TABLE IF NOT EXISTS medical_info (
        medical_info_id SERIAL PRIMARY KEY,
        patient_id CHAR(16) REFERENCES patient(patient_id),
        description TEXT
    );

    CREATE TABLE IF NOT EXISTS appointment (
        appointment_id SERIAL PRIMARY KEY,
        date_time TIMESTAMPTZ NOT NULL,
        staff_id CHAR(16) REFERENCES staff(staff_id),
        doctor_id CHAR(16) REFERENCES doctor(doctor_id),
        patient_id CHAR(16) REFERENCES patient(patient_id)
    );

    CREATE TABLE IF NOT EXISTS medical_event (
        event_id SERIAL PRIMARY KEY,
        from_date_time TIMESTAMPTZ NOT NULL,
        to_date_time TIMESTAMPTZ CHECK ( to_date_time >= medical_event.from_date_time ),
        severity_code severity,
        discharge_letter TEXT,
        patient_id CHAR(16) REFERENCES patient(patient_id),
        ward_id SERIAL REFERENCES ward(ward_id)
    );

    CREATE TABLE IF NOT EXISTS medical_exam (
        exam_id SERIAL PRIMARY KEY,
        date_time TIMESTAMPTZ NOT NULL,
        medical_report TEXT,
        exam_type TEXT,
        doctor_id CHAR(16) REFERENCES doctor(doctor_id),
        patient_id CHAR(16) REFERENCES patient(patient_id),
        medical_event_id SERIAL REFERENCES medical_event(event_id)
    );


    INSERT INTO ward (ward_id, name) VALUES (1, 'Renal Care');
    INSERT INTO ward (ward_id, name) VALUES (2, 'Orthopedic Ward');
    INSERT INTO ward (ward_id, name) VALUES (3, 'Rehabilitation Unit');
    INSERT INTO ward (ward_id, name) VALUES (4, 'General Medicine');
    INSERT INTO ward (ward_id, name) VALUES (5, 'Post-Operative Recovery');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('WRNVNE95A02B551C', 'Evan', 'Werner', '1995-02-15', 'ClAgHMAbXv5ChwhsYQ8IbdgZzCfzTlmIUrVAiD7PxwD0xU0Ojm', '+39392974654', 'leonjose@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('PHLKNN45A06B181C', 'Kenneth', 'Phillips', '1945-06-18', 'OOxtEqGVmlpipesibApbo3O5lkBeGixpdTN6GiYmsCuHr8gIa5', '+39396024841', 'lynchbrendan@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HLLMTT44A09B081C', 'Matthew', 'Hall', '1944-09-08', 'gy7dPA0eq9dbxxYLPdF7AA4GorXrhm4jL1bgpRdl5PErIz8aV6', '+39357208913', 'stephen36@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HNSMND75A01B531C', 'Amanda', 'Hensley', '1975-01-13', 'Y2Flu0wcg09qx9ZWgfOvCtqi1f4sP7xkyd2QDjLJk8OwEn3gVk', '+39300291926', 'hromero@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('TYLDVA44A08B151C', 'Dave', 'Taylor', '1944-08-15', '8KfzE7aIqW1yqOgTydrwf8lAk0vyihPxdzu6xF3fqtJadepozh', '+39380642269', 'michellewebb@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('JNSMYA60A12B561C', 'Amy', 'Jones', '1960-12-16', 'x1LqFucJgdepC61Avi1RKCTBDpUvEQMqy12fAoyq2dkzPYBfeL', '+39315260558', 'reginakoch@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('PTTJHN67A11B051C', 'John', 'Patterson', '1967-11-05', 'rKcE3g4hr7OQ2PaWCMctot9SfGUBOWcyzyXK9VZIWWtd2MNTfN', '+39318399210', 'kbolton@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('VZQJSN46A03B201C', 'Jason', 'Vazquez', '1946-03-20', 'iBztvfb8rCcyLrHwcvDpMmccKNZTEajPJgOnDqCHued5Be6E7P', '+39355529170', 'luke65@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('WNSSSN71A02B171C', 'Susan', 'Owens', '1971-02-17', 'WK7RkPi1SmBz8fDX7tidPE0jOCFTiHn4RLF6ZNJ17RCyE8QsA3', '+39378006459', 'teresahurley@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('JHNMLN63A07B301C', 'Melanie', 'Johnson', '1963-07-30', 'HHYs2DH28FxwvkpkBXfqXqrOcZ8F0cHzB4nojkAX5Dddu2QuX8', '+39394929215', 'lopeztimothy@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('MNDJMS95A07B281C', 'James', 'Mendoza', '1995-07-28', 'rvSSe0HQO19uCxEtdCEcyfRJyXERQtVjrWhCPYyhS7aS9c3q4K', '+39371228556', 'heatherolsen@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('RMSDNS01A05B411C', 'Denise', 'Ramos', '2001-05-01', 'NqJrvb6hZu4PiqsRVRlkab10Er9nkPBOdr2Uf4n028V0RDFFMC', '+39334452370', 'ryan97@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CRTNTH76A08B291C', 'Anthony', 'Carter', '1976-08-29', 'NFGxmCZj6Ev93h62kwxtJ7Uvv8ieFnNu0QRKgqjkjPXQzeugRF', '+39324787252', 'alexandermelissa@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('MYRSHN88A07B271C', 'Shannon', 'Moyer', '1988-07-27', '6Pagwbz7oNQO8BTRqlbftIToyRobI1bjYf9WYTCIQCJIaPSaME', '+39305090983', 'zfleming@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SCHMGN86A09B091C', 'Megan', 'Schwartz', '1986-09-09', 'MpFocI1YCgKicIOyY5v4XlY6MRY79MPqmc9Za6nnaaIv3begza', '+39370779640', 'jeffery92@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CRTLTS53A03B611C', 'Latasha', 'Carter', '1953-03-21', '8yMjWPIPaCbMwRfbOwGOcaOdlEbL0D90RtfwnE6ORezuDLnsXL', '+39321772029', 'ericsullivan@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('BRNMLN91A04B571C', 'Melinda', 'Barnett', '1991-04-17', 'NKuDDqfANNBrPDRxdHxIzwJ0s0Sob0v9UX7e0N7dzy20bvzOba', '+39342782576', 'katrina69@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('JHNSHL63A08B081C', 'Shelby', 'Johnson', '1963-08-08', 'Awi5DJ6ouzPal4q8Ts1jnGOUa0dfydeWZklzyus6rGqfR7lyoU', '+39389207319', 'hperkins@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('WLTDNN97A09B141C', 'Donna', 'Walton', '1997-09-14', 'Wrc4L0vginLIwLAgtvSc4sDnW2yCXNWyvZVFvwxw04aWHPXYwP', '+39312294173', 'erivas@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('FLTTMT70A05B451C', 'Timothy', 'Fletcher', '1970-05-05', 'OcJ1GJ4MLgECCFh8HLzRHm2WsWlX4zcShhg7UDLRWEV2DPf17F', '+39391412535', 'glennbarry@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('STSKMB59A09B421C', 'Kimberly', 'Estes', '1959-09-02', 'njiYsgICV8WEHhuszE10UYQMlsOvCrEwZN1Sf0L6JfOAUTR9CZ', '+39314088481', 'xfoley@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HNNNDR64A05B641C', 'Andrew', 'Hanna', '1964-05-24', 'LN3BrNSGml7RNkY1YW4NBixXOUcmqXIWPMXKGztj743sp0XWTA', '+39367049106', 'mayrebecca@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CRRBNJ72A05B511C', 'Benjamin', 'Carroll', '1972-05-11', 'J4mwedHq3qWRbQdt3xuWw2OXQ2TmAk2uODXaq3kJF2oCbnDeq1', '+39309897966', 'katherinehoward@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('DVSRCH69A05B081C', 'Richard', 'Davis', '1969-05-08', 'SJbfc95WVKvWUX8Y5W34RzBWSo4MfVqBOuZKEOVowXb4bYj4mj', '+39381746172', 'timrobinson@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CRNWLL91A12B611C', 'William', 'Crane', '1991-12-21', 'tZMhkH3prxqsicMNTA5PV8pxwNfgFlkd3mRYTXkBshaZ3XWDXI', '+39341944997', 'kimberlybenton@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('DYRMCH67A05B631C', 'Michael', 'Dyer', '1967-05-23', 'q7WJngV4ti9l4ADBZq0yArS7bHGj3fQT2Xe5P80ZydCujjUZOv', '+39337214319', 'stephaniefletcher@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('GLNCRL88A07B091C', 'Carolyn', 'Glenn', '1988-07-09', 't8tN7mWlTEsU48VoDoU10ksXZHmlt6KUws0YqTQEXD74slI74U', '+39327761950', 'pbarber@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('FSHLSN82A11B041C', 'Alison', 'Fisher', '1982-11-04', 'ep5jT4hp8J3DJuOZ8jMkZhq0TtA3e5R75HsgHdNlLP9zoJR81i', '+39307912474', 'gonzalezlisa@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('TYLCHR48A02B221C', 'Christian', 'Taylor', '1948-02-22', 'V5WyZV0zWJRCP4FZqkyxHsAZBNBikkVN8g43OlY67REJb2EyDW', '+39337833824', 'james14@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HLASHL70A11B581C', 'Ashley', 'Hale', '1970-11-18', 'HRLsQty3txqBvB8MhAlkMwDnVRV3QlgIO3XzBk6fAwRCRa7WgV', '+39314888273', 'martin09@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('RBNTNI60A06B661C', 'Tina', 'Robinson', '1960-06-26', 'EJSW38EcOGRw59ElrQ0BaYEQUyhtKkNZDIHopZayjUZ08knDiG', '+39348465504', 'jamesherbert@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('PLMJST64A09B081C', 'Justin', 'Palmer', '1964-09-08', 'FAOSpXYl9SPG8NVi7K5tIKwbKy8dol9PgNd1Lnem12qYvxKnFU', '+39303004750', 'fisherdonna@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('KRBJSN02A08B171C', 'Jason', 'Kirby', '2002-08-17', 'BQ1JjKRULzOS2N1MjTqTPdRdxfoGwf2s8wUEAwEYQMLNRFsoGm', '+39376983310', 'ninaconrad@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('WLLBRB73A12B461C', 'Barbara', 'Williams', '1973-12-06', 'dQ6QYqF3V8hSSyVPz8N30iiIUwJ8E4H8ylkWd8wvLnSwLFidUV', '+39342161452', 'isaacmartin@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('MROSTV71A12B581C', 'Steven', 'Moore', '1971-12-18', 'evfzzODi5EmnZKOVZwveC1nPFRlIR0vLcgGOt9mwIOS7S0LRKc', '+39312138286', 'lauradean@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SHPTHM73A07B091C', 'Thomas', 'Shepherd', '1973-07-09', 'i5HjV6IH8uFsGRyWGOaWRaXRtoHP0OOVIjK20ATtRxJ1irFWp6', '+39350343337', 'rick76@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HPKLXN96A11B221C', 'Alexander', 'Hopkins', '1996-11-22', 'gjx73TBFrhEHICeapkgxapn8RpqCOoxnWJhlpjRTuEiLMz2FqY', '+39332081937', 'taustin@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('WTKPGA72A10B661C', 'Paige', 'Watkins', '1972-10-26', 'J8bSdnzvcidCLAHEGLjdtl5mU7qNXCP8nmOpQ9eK8wAIWmWCm9', '+39359021727', 'chase37@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('VLSTMM79A09B041C', 'Tammy', 'Velasquez', '1979-09-04', '7KFmcmlizi20ucG05UWNkOS2BFaFHVTdpvk1AtQrZY210gyq9J', '+39318538136', 'abentley@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HRMDNL95A01B561C', 'Donald', 'Harmon', '1995-01-16', 'hhSDhorseGM8dqjLKXOqFPNrdDZGvsksKnY30z2vVQeOasMZyH', '+39391740928', 'faith88@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CRLKMB88A01B221C', 'Kimberly', 'Carlson', '1988-01-22', 'DziMHloTqxcRDaqNRTOjnKPoZLSmmCKguGdWz0BnxaBnjC9xRk', '+39351020154', 'teresaadams@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('BRNKNN63A05B661C', 'Kenneth', 'Burns', '1963-05-26', 'RNSFS3QveEQdMZLdr3DmhlrEngXWzLMxF2H124Pfu8A2cxnX2l', '+39339722174', 'rodney19@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SCTCHL68A07B651C', 'Chelsea', 'Scott', '1968-07-25', 'otJ1ZyXKiqqo9fragRfXORYzKvNifymUCJkM9fCw18Ek3KBj5T', '+39305049149', 'elizabethmaddox@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('WLSJRR54A02B501C', 'Jerry', 'Wilson', '1954-02-10', 'J4fTjRSN8ACFsUJvAx8PgN3ah1pIHlGAYNrpMPVgOMj7IdOE1M', '+39381726765', 'porterjeanne@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CLLRCH60A01B281C', 'Richard', 'Collins', '1960-01-28', 'Xo50h8VUNuwjC3226ZPZAJLKdg72LlxVOf2mNA3985a59S2MEF', '+39350076628', 'hughestimothy@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('LZNRNE75A12B171C', 'Renee', 'Lozano', '1975-12-17', 'lPuWGELz2p7DLbB8Qr0dyhLno9YSWs07bT1Fhavv34tRA18YyH', '+39314630597', 'qhunter@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('RSICHR60A12B291C', 'Christopher', 'Rios', '1960-12-29', 'BvLjMfLI7oQsWm9dUkL8H8iaYf3Aqsm9fdJTINp88SOyz0o0Zc', '+39375132026', 'michaelwarren@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('MLNJSP93A07B481C', 'Joseph', 'Malone', '1993-07-08', '5wGfFX5JU1IHSzFE3VeL2ya03l4I3P0uPDCPz0TD1o9R3l84XX', '+39378044259', 'colleen06@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('WLLJFF79A02B181C', 'Jeff', 'Williams', '1979-02-18', 'edBkcPUD6qtFAkwxclE11nZ7YEuyxms6oJ89msesDiFqKI5JCS', '+39354042685', 'judithwatts@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('MNDKTH75A02B571C', 'Kathryn', 'Mendoza', '1975-02-17', '942OP618Dr2sY4FkaCGWZCO7hfk8VYxq1IrNLNijjN8nfnXeJg', '+39344145948', 'powersashley@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('LSTRGR87A11B181C', 'Roger', 'Lester', '1987-11-18', 'LNG2ADUEY8u9PchK6nZnebl0kuKPX6YoZBcNxJt6lBZPU2QfC5', '+39344103720', 'balljustin@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('BNDNDR49A10B531C', 'Andre', 'Bond', '1949-10-13', '20oClGMarNmWpKP9DZ7ufMnxQJcmEzcTFRRhw5FIswWMUCd0kE', '+39331512706', 'jvalencia@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('DNLMGN06A09B541C', 'Megan', 'Daniel', '2006-09-14', 'URuUmzZBtSwUuTW2OwkirJ9zlmhcTQrMs4BEbkW6du2nLBgn6i', '+39399294854', 'anichols@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HLLLYN97A07B681C', 'Lynn', 'Hall', '1997-07-28', 'gMSaNFiv0ZATKlgBjHsk60UjUADDMrXbCQYrVZMeix5GXXfjK1', '+39351085610', 'tlowery@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('LRSJHN73A11B651C', 'John', 'Larson', '1973-11-25', 'OBVewPJdeaAM9JWlQlGVLAXPlJU3lW3sQDMWYdPUsvs81EWcDs', '+39331548648', 'proctortara@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('BLLPLA71A05B261C', 'Paul', 'Bell', '1971-05-26', 'gWOzMmg9pSwm5lTxdTxPc6WipO2LFzjtxR7kmhsudcZmFkAoMs', '+39322935838', 'andersoncarolyn@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('DVNDVD45A09B051C', 'David', 'Davenport', '1945-09-05', 'wr4T8m0l7rk6eE9LnobkPfGRrPpfAJE3Fi16LrOSfa3DP6fUre', '+39367541523', 'matthewbrown@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('THMLSU95A11B451C', 'Luis', 'Thompson', '1995-11-05', 'jExehbfezmqdVtF4Q79MchGmf7vU8Uek5qSYrcXGvQWtlCwo5v', '+39341279783', 'beasleyjose@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('RSHPTR89A01B711C', 'Patrick', 'Rush', '1989-01-31', 'GecjLfOm2rNWkUUihDh7fjQ6A9QvjWXiyYt86rTnMUfvtVGSnr', '+39392522279', 'stonealexis@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('LSTJNN77A01B521C', 'Jennifer', 'Lester', '1977-01-12', 'NDBenoddsvhNaBz4xj9nz8dwwLuuC3f5ktAzVXHgpGpx8evRg1', '+39379689481', 'ekirk@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('LYNMGN95A07B141C', 'Megan', 'Lynch', '1995-07-14', 'jnbqxe88IKVP3wsKLptklIHgLQj5KpqUSDqGJa1OMpnffhnO0p', '+39369523800', 'zfrench@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HBBRCE73A10B531C', 'Eric', 'Hubbard', '1973-10-13', 'b2iLWu4Ypfz9trkBV0yH9ynxRxAK9fSiIRfCFW1vpld12u4SM6', '+39342073464', 'ashley34@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('NDRKVN58A06B271C', 'Kevin', 'Anderson', '1958-06-27', 'qqGzYsBgOLY46hJlqNBPhX9pWyKwJjcYWMoVhuHglR1RhIMUlp', '+39356774015', 'erinscott@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('PLORCH99A04B141C', 'Richard', 'Poole', '1999-04-14', 'UWg5xp3tY6uEQNzoyHKsXZXNuwu8w36RkW7wENWg57mHhvAKAD', '+39359318665', 'thomascole@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('GRHCRL04A09B421C', 'Caroline', 'Graham', '2004-09-02', '8PY9e4ot5iZGUXAm4BoF2ZHqdVewRefMdwqhMcqghz38Dsp1hS', '+39318493894', 'williamssteven@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('NDRJMS90A10B691C', 'James', 'Anderson', '1990-10-29', 'yw4OsBnVU4s0jFVgfRVbfgzC3urWhUGsA1Rl1qB6h58j2d41qr', '+39319535208', 'lmorton@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SCHLXN94A06B621C', 'Alexander', 'Schneider', '1994-06-22', 'CX2wUUIawI0fkvBNbZU5U4VLVhIQ04MKX7fCdoGRfXhWvpJPXU', '+39383920128', 'stevenpage@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CLYBNJ50A01B511C', 'Benjamin', 'Clayton', '1950-01-11', 'Qmpg8XIeOFjEDQWNzfZkE5KNgrBcxKaZztISScAonH79JtEpRm', '+39392886056', 'cruzjanet@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('PTRNNT77A10B171C', 'Annette', 'Peterson', '1977-10-17', 'vbCtFNf0tZL8xtBUGOaC8Sw92wwMizqGTSCnuMNPHaDStUJbZK', '+39361888337', 'jodi91@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('VLNDDE79A04B491C', 'Eddie', 'Valencia', '1979-04-09', 'dpURUyGh1EzrdlnqMmblmeRcXLFr9r8XgEeWdu5An7xbC4Ku1z', '+39314757692', 'crystalhogan@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('GRCBRT51A02B201C', 'Brittany', 'Garcia', '1951-02-20', '2QZVkei5pWFPPCqN3CTsLRTUhLrEas7oOr0C48tMGrnME3JfSV', '+39352195409', 'wgreen@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('RDGCRL72A06B501C', 'Carlos', 'Rodgers', '1972-06-10', 'XdCR7gr4byEYpTjCo64LHtWpWnYyhzXg3KG3iE7EyU67ZNx4pR', '+39328728499', 'curtisduncan@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('GRYDNL49A08B441C', 'Donald', 'Gray', '1949-08-04', 'ZczJ8BLRwJYXW81tItOkPtDJTEHupJsUsltqWRE5e8TUfzR9HD', '+39386926974', 'adam25@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HTHLRR51A12B211C', 'Larry', 'Heath', '1951-12-21', 'HwXBF6KisuVIsUay2zMdFtYOzc9ow0ple27Cfskx1w1ZwcHG4E', '+39381095935', 'ann62@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('JHNBRN88A02B501C', 'Brian', 'Johnson', '1988-02-10', 'DZMxWtqKZ59rCbnaSD0PwvR2JAuahEavRj2KX5NxlePQkxymAW', '+39316972167', 'gracewhite@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SCHNNA69A09B481C', 'Anne', 'Schmidt', '1969-09-08', 'X4nam6msvaI4Cetqt2xJLwlBiEogZmhHxqrfARahgoV6A7UvBx', '+39371920530', 'sjackson@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SCHMGN68A05B471C', 'Megan', 'Schroeder', '1968-05-07', 'oGND9K5rJrIwTeZoJvAhlfXWwx9EAz8mxwvMazuVrMFcpSqUhj', '+39344748889', 'smithcarol@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HRRMRC58A01B581C', 'Marcus', 'Herrera', '1958-01-18', '6UfPt5jaelvWi9aQlijPgrcBuS9oUGbCROCkjxh64ZoYXt3K1T', '+39306272414', 'clee@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('WLLNCH75A02B671C', 'Nicholas', 'Williams', '1975-02-27', 'NCysOqyXUJSPyFFMVznieQfnnYDqTlV9lnBI0iMlK7LDJEHS83', '+39340865621', 'madison38@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('LEEZCH94A12B291C', 'Zachary', 'Lee', '1994-12-29', 'cdLe32HQtQe9y5mXjSwgRmQjBAzwWYQh9SmilwLzltHNgMeS1I', '+39353171210', 'raven47@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SNCNGL70A02B441C', 'Angela', 'Sanchez', '1970-02-04', 'ViFLKm5ptOikRUb5ABIkcwmZrzdWMNSLvFneJNSxLkvrebaJft', '+39398765719', 'guerradonald@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('BKRMCH62A08B191C', 'Michael', 'Baker', '1962-08-19', 'FF3fb3ZfF7INaLjzCdOu7j1dlfS9jWS69KNfyhY3tGTvcggHEZ', '+39380571799', 'jasonmiller@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('JNSRNA65A05B581C', 'Aaron', 'Jones', '1965-05-18', 'ssolBlbHGgABizKJAWsPRYMfAv04GmLQxeJ43rgkynsrCKVBq6', '+39326887044', 'kimberly34@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SHWCHR75A12B671C', 'Christine', 'Shaw', '1975-12-27', 'BCe6hnCSoVFggL1jxcU8lCcQC7rlgyeBDaCdzV3EPi28b2jRKl', '+39329504694', 'brian93@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('PLOJNT99A04B201C', 'Jonathan', 'Poole', '1999-04-20', 'XZC6VR7TZR5GAY1f2PDSrP2jTQzM1WrDBKgWux93CmBxGlg5oT', '+39342798048', 'michaelpowell@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CSTNDR70A05B021C', 'Andrea', 'Acosta', '1970-05-02', 'z6t4h95QLBtx46Bz0WefVLQr39cdD6Ew1zpZggnH5psOaVTwR0', '+39336288601', 'matthew28@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('HYNSML44A11B561C', 'Samuel', 'Haynes', '1944-11-16', 'tKDC3v0GhTsZYXlGMqJHAVFHxtHPY46BXSAzUFRIYpYpldX8MP', '+39330412108', 'fperry@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('GRRMCH66A05B231C', 'Michael', 'Garrett', '1966-05-23', 'FTRZpPysB4AmWl3vR0fJRLXZIAk84Oz4V3K1eUKQRac5U6fXi4', '+39375843645', 'rmartin@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('MCGJSM85A04B161C', 'Jasmine', 'Mcgee', '1985-04-16', 'HaB5mEcOsZnHYL4YgrskvkCMZq0SLsLX411O6hlm41ldK34OtQ', '+39396647474', 'kevin36@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('BRKRNE77A05B011C', 'Erin', 'Burke', '1977-05-01', '6NucUJlIrYq0HJYoS66CILjbGPfeN6cCCFnmqcHp1x5kbOmMfl', '+39331041069', 'emorris@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('LMAKTH60A04B591C', 'Kathleen', 'Lam', '1960-04-19', 'SUNpNjtm6GIKXsDnSyr73wJcQGEwh8z3gs5QHitPwNKw1zuqlF', '+39315403149', 'rhondaknox@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('SMTJHN89A08B081C', 'John', 'Smith', '1989-08-08', 'mGRNwD9kwlixxN5R8rJV05knbNjEfSJBp2DM5byN6tPb3EtBFr', '+39353232726', 'xlee@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('BSHBRN45A11B261C', 'Brianna', 'Bishop', '1945-11-26', 'tCKpGTD2CTdnOG3KnCrmfEe6oLW3s6xUdSB75fvTIIhbIKIQXd', '+39374739296', 'josephthomas@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('RMRMRK89A01B271C', 'Mark', 'Ramirez', '1989-01-27', '9kDUVtraESeAHncOvrLjfsVrFeuVAWKyULbboWWfZ98XmN0hMk', '+39357533561', 'hgilbert@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('CLODNE52A04B031C', 'Dean', 'Cole', '1952-04-03', '82qDau7aS6yWPcq9uR2PzgDbm51A7M43TTqgzmJW8yjzJE6hyQ', '+39382321743', 'hendersonsamuel@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('PTTPNN61A12B491C', 'Penny', 'Potts', '1961-12-09', 'BI0mxcx4XmMAXOicCjqyS9gqc88sG0deF4ww4WtLkmJ52DhVz8', '+39343019731', 'jennifercarpenter@example.net');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('FRSCHR53A10B491C', 'Christopher', 'Frost', '1953-10-09', 'GLjjRozPAFClkq6IJfvA6erEWSy00xK3TpTDqSkxgxuiliU8cM', '+39385843739', 'pattersonmatthew@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('BNSDGL54A04B621C', 'Douglas', 'Benson', '1954-04-22', '4KurP4lbYsB92etW5XoCU28A477luMTeYM8iwFx8xauZbqmg3O', '+39352474141', 'leetasha@example.com');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('GZMNTS64A10B081C', 'Natasha', 'Guzman', '1964-10-08', '2LEAKPdPRhf5bfR7xkvGojg7A8l3tvWPp5FRor8lOr6kkmZJXC', '+39308564173', 'nmiller@example.org');
    INSERT INTO users (id, name, surname, date_of_birth, sub, phone_number, email) VALUES ('RGRSHL90A11B281C', 'Shelly', 'Rogers', '1990-11-28', '1ey2646zQCWFce1AW74r2U0UDiXBxc3WDC4mC1MC4GbW6YMWrT', '+39327836618', 'brendapacheco@example.com');
    INSERT INTO staff (staff_id) VALUES ('WRNVNE95A02B551C');
    INSERT INTO staff (staff_id) VALUES ('VZQJSN46A03B201C');
    INSERT INTO staff (staff_id) VALUES ('HNNNDR64A05B641C');
    INSERT INTO staff (staff_id) VALUES ('GLNCRL88A07B091C');
    INSERT INTO staff (staff_id) VALUES ('TYLCHR48A02B221C');
    INSERT INTO staff (staff_id) VALUES ('WTKPGA72A10B661C');
    INSERT INTO staff (staff_id) VALUES ('BLLPLA71A05B261C');
    INSERT INTO staff (staff_id) VALUES ('DVNDVD45A09B051C');
    INSERT INTO staff (staff_id) VALUES ('VLNDDE79A04B491C');
    INSERT INTO staff (staff_id) VALUES ('CSTNDR70A05B021C');
    INSERT INTO patient (patient_id) VALUES ('CRTNTH76A08B291C');
    INSERT INTO patient (patient_id) VALUES ('BRNMLN91A04B571C');
    INSERT INTO patient (patient_id) VALUES ('WLTDNN97A09B141C');
    INSERT INTO patient (patient_id) VALUES ('FLTTMT70A05B451C');
    INSERT INTO patient (patient_id) VALUES ('HNNNDR64A05B641C');
    INSERT INTO patient (patient_id) VALUES ('CRNWLL91A12B611C');
    INSERT INTO patient (patient_id) VALUES ('GLNCRL88A07B091C');
    INSERT INTO patient (patient_id) VALUES ('FSHLSN82A11B041C');
    INSERT INTO patient (patient_id) VALUES ('HLASHL70A11B581C');
    INSERT INTO patient (patient_id) VALUES ('RBNTNI60A06B661C');
    INSERT INTO patient (patient_id) VALUES ('PLMJST64A09B081C');
    INSERT INTO patient (patient_id) VALUES ('WTKPGA72A10B661C');
    INSERT INTO patient (patient_id) VALUES ('CRLKMB88A01B221C');
    INSERT INTO patient (patient_id) VALUES ('BRNKNN63A05B661C');
    INSERT INTO patient (patient_id) VALUES ('WLLJFF79A02B181C');
    INSERT INTO patient (patient_id) VALUES ('BNDNDR49A10B531C');
    INSERT INTO patient (patient_id) VALUES ('HLLLYN97A07B681C');
    INSERT INTO patient (patient_id) VALUES ('RSHPTR89A01B711C');
    INSERT INTO patient (patient_id) VALUES ('LSTJNN77A01B521C');
    INSERT INTO patient (patient_id) VALUES ('PLORCH99A04B141C');
    INSERT INTO patient (patient_id) VALUES ('NDRJMS90A10B691C');
    INSERT INTO patient (patient_id) VALUES ('CLYBNJ50A01B511C');
    INSERT INTO patient (patient_id) VALUES ('VLNDDE79A04B491C');
    INSERT INTO patient (patient_id) VALUES ('GRYDNL49A08B441C');
    INSERT INTO patient (patient_id) VALUES ('HTHLRR51A12B211C');
    INSERT INTO patient (patient_id) VALUES ('WLLNCH75A02B671C');
    INSERT INTO patient (patient_id) VALUES ('CSTNDR70A05B021C');
    INSERT INTO patient (patient_id) VALUES ('GRRMCH66A05B231C');
    INSERT INTO patient (patient_id) VALUES ('CLODNE52A04B031C');
    INSERT INTO patient (patient_id) VALUES ('BNSDGL54A04B621C');
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('WRNVNE95A02B551C', 'Community arts worker', '+39312748374', 5);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('JHNMLN63A07B301C', 'Special educational needs teacher', '+39370742207', 5);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('MYRSHN88A07B271C', 'Journalist, broadcasting', '+39377281159', 4);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('FLTTMT70A05B451C', 'Public relations officer', '+39363284749', 2);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('DYRMCH67A05B631C', 'Nurse, adult', '+39369060071', 2);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('MROSTV71A12B581C', 'Heritage manager', '+39386306489', 5);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('SCTCHL68A07B651C', 'Scientist, research (maths)', '+39325391190', 2);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('LZNRNE75A12B171C', 'Further education lecturer', '+39398418648', 4);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('RSICHR60A12B291C', 'Administrator, local government', '+39385866557', 2);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('BNDNDR49A10B531C', 'Conference centre manager', '+39370062694', 5);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('DVNDVD45A09B051C', 'Surveyor, hydrographic', '+39384787514', 2);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('THMLSU95A11B451C', 'Horticulturist, amenity', '+39350223732', 5);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('RSHPTR89A01B711C', 'Nutritional therapist', '+39312848135', 2);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('LSTJNN77A01B521C', 'Dramatherapist', '+39322428981', 2);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('JHNBRN88A02B501C', 'Clinical cytogeneticist', '+39385700372', 2);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('WLLNCH75A02B671C', 'Surveyor, minerals', '+39311439312', 3);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('SHWCHR75A12B671C', 'Firefighter', '+39386673142', 4);
    INSERT INTO doctor (doctor_id, med_specialization, office_phone_number, ward_id) VALUES ('CSTNDR70A05B021C', 'Field seismologist', '+39328023539', 5);
    INSERT INTO medical_info (patient_id, description) VALUES ('CRTNTH76A08B291C', 'Build above section eye white least.');
    INSERT INTO medical_info (patient_id, description) VALUES ('BRNMLN91A04B571C', 'Scene newspaper wall action leg.');
    INSERT INTO medical_info (patient_id, description) VALUES ('WLTDNN97A09B141C', 'That radio middle understand purpose.');
    INSERT INTO medical_info (patient_id, description) VALUES ('FLTTMT70A05B451C', 'Happy some dream administration raise.');
    INSERT INTO medical_info (patient_id, description) VALUES ('HNNNDR64A05B641C', 'Act memory compare the beyond scientist.');
    INSERT INTO medical_info (patient_id, description) VALUES ('CRNWLL91A12B611C', 'In seven even head whatever open politics economy.');
    INSERT INTO medical_info (patient_id, description) VALUES ('GLNCRL88A07B091C', 'Pattern main decision organization themselves drive form.');
    INSERT INTO medical_info (patient_id, description) VALUES ('FSHLSN82A11B041C', 'Rest us entire laugh.');
    INSERT INTO medical_info (patient_id, description) VALUES ('HLASHL70A11B581C', 'Open black if wish health.');
    INSERT INTO medical_info (patient_id, description) VALUES ('RBNTNI60A06B661C', 'Space sense response.');
    INSERT INTO medical_info (patient_id, description) VALUES ('PLMJST64A09B081C', 'Discuss operation focus party firm move.');
    INSERT INTO medical_info (patient_id, description) VALUES ('WTKPGA72A10B661C', 'Score exactly pass just.');
    INSERT INTO medical_info (patient_id, description) VALUES ('CRLKMB88A01B221C', 'Debate community nation condition think truth.');
    INSERT INTO medical_info (patient_id, description) VALUES ('BRNKNN63A05B661C', 'Talk item action perhaps forward budget practice.');
    INSERT INTO medical_info (patient_id, description) VALUES ('WLLJFF79A02B181C', 'Place gas direction carry two group.');
    INSERT INTO medical_info (patient_id, description) VALUES ('BNDNDR49A10B531C', 'Card American director act stay resource.');
    INSERT INTO medical_info (patient_id, description) VALUES ('HLLLYN97A07B681C', 'Player magazine condition.');
    INSERT INTO medical_info (patient_id, description) VALUES ('RSHPTR89A01B711C', 'Kitchen more say others who hundred.');
    INSERT INTO medical_info (patient_id, description) VALUES ('LSTJNN77A01B521C', 'Hold action policy indeed sister.');
    INSERT INTO medical_info (patient_id, description) VALUES ('PLORCH99A04B141C', 'And newspaper bring wonder soon.');
    INSERT INTO medical_info (patient_id, description) VALUES ('NDRJMS90A10B691C', 'Term value piece style notice property.');
    INSERT INTO medical_info (patient_id, description) VALUES ('CLYBNJ50A01B511C', 'Area rest by fine than exactly.');
    INSERT INTO medical_info (patient_id, description) VALUES ('VLNDDE79A04B491C', 'Life marriage visit begin station lead understand.');
    INSERT INTO medical_info (patient_id, description) VALUES ('GRYDNL49A08B441C', 'Money society agency event add.');
    INSERT INTO medical_info (patient_id, description) VALUES ('HTHLRR51A12B211C', 'Campaign them expert into new hot.');
    INSERT INTO medical_info (patient_id, description) VALUES ('WLLNCH75A02B671C', 'Certainly red know.');
    INSERT INTO medical_info (patient_id, description) VALUES ('CSTNDR70A05B021C', 'Marriage pay become call throughout item the game.');
    INSERT INTO medical_info (patient_id, description) VALUES ('GRRMCH66A05B231C', 'Station defense peace morning hour.');
    INSERT INTO medical_info (patient_id, description) VALUES ('CLODNE52A04B031C', 'Share sell difficult official rule bill.');
    INSERT INTO medical_info (patient_id, description) VALUES ('BNSDGL54A04B621C', 'Open often race former.');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2001-12-22 00:00:00', 'WRNVNE95A02B551C', 'LZNRNE751217DC', 'BNDNDR491053PW');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2000-06-04 00:00:00', 'HNNNDR64A05B641C', 'LZNRNE751217DC', 'NDRJMS901069TX');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2010-12-17 00:00:00', 'HNNNDR64A05B641C', 'MYRSHN880727OK', 'NDRJMS901069TX');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2024-04-23 00:00:00', 'WRNVNE95A02B551C', 'LZNRNE751217DC', 'BRNKNN630566RI');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2003-01-17 00:00:00', 'VZQJSN46A03B201C', 'MROSTV711258NC', 'WTKPGA721066NC');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2001-12-13 00:00:00', 'WRNVNE95A02B551C', 'JHNMLN630730GA', 'WLTDNN970914NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2012-02-25 00:00:00', 'DVNDVD45A09B051C', 'JHNMLN630730GA', 'CRTNTH760829NC');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2014-01-25 00:00:00', 'TYLCHR48A02B221C', 'SHWCHR751267TN', 'GRRMCH660523GU');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2009-08-03 00:00:00', 'DVNDVD45A09B051C', 'FLTTMT700545MH', 'BNSDGL540462PW');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2012-05-01 00:00:00', 'CSTNDR70A05B021C', 'SHWCHR751267TN', 'GRYDNL490844FM');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2003-01-10 00:00:00', 'GLNCRL88A07B091C', 'THMLSU951145DC', 'GRRMCH660523GU');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2010-11-29 00:00:00', 'TYLCHR48A02B221C', 'JHNMLN630730GA', 'RBNTNI600666DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2003-03-09 00:00:00', 'WTKPGA72A10B661C', 'WRNVNE950255MP', 'HLASHL701158NH');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2012-05-28 00:00:00', 'WRNVNE95A02B551C', 'RSHPTR890171CO', 'NDRJMS901069TX');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2007-03-19 00:00:00', 'WRNVNE95A02B551C', 'DVNDVD450905TX', 'CLYBNJ500151MD');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2013-10-17 00:00:00', 'VZQJSN46A03B201C', 'MYRSHN880727OK', 'GLNCRL880709AK');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2005-04-03 00:00:00', 'DVNDVD45A09B051C', 'MYRSHN880727OK', 'HLASHL701158NH');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2011-07-22 00:00:00', 'CSTNDR70A05B021C', 'LSTJNN770152KY', 'LSTJNN770152KY');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2003-07-27 00:00:00', 'BLLPLA71A05B261C', 'MYRSHN880727OK', 'HTHLRR511221PA');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2005-05-04 00:00:00', 'CSTNDR70A05B021C', 'SHWCHR751267TN', 'FLTTMT700545MH');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2011-12-21 00:00:00', 'GLNCRL88A07B091C', 'MROSTV711258NC', 'BRNMLN910457NE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2004-08-26 00:00:00', 'TYLCHR48A02B221C', 'WLLNCH750267DE', 'HTHLRR511221PA');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2000-09-29 00:00:00', 'GLNCRL88A07B091C', 'MROSTV711258NC', 'CLODNE520403VI');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2019-02-09 00:00:00', 'GLNCRL88A07B091C', 'SHWCHR751267TN', 'WLTDNN970914NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2007-10-19 00:00:00', 'WRNVNE95A02B551C', 'WRNVNE950255MP', 'PLMJST640908MN');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2014-07-21 00:00:00', 'HNNNDR64A05B641C', 'LZNRNE751217DC', 'BRNKNN630566RI');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2014-06-04 00:00:00', 'GLNCRL88A07B091C', 'RSICHR601229TX', 'VLNDDE790449CT');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2008-02-19 00:00:00', 'TYLCHR48A02B221C', 'DYRMCH670563NJ', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2003-11-28 00:00:00', 'BLLPLA71A05B261C', 'RSHPTR890171CO', 'WLLJFF790218FL');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2024-08-26 00:00:00', 'TYLCHR48A02B221C', 'RSICHR601229TX', 'FLTTMT700545MH');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2014-08-06 00:00:00', 'WRNVNE95A02B551C', 'DYRMCH670563NJ', 'CRNWLL911261DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2014-04-18 00:00:00', 'GLNCRL88A07B091C', 'SCTCHL680765NC', 'VLNDDE790449CT');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2017-05-09 00:00:00', 'WRNVNE95A02B551C', 'SHWCHR751267TN', 'HNNNDR640564CO');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2021-07-23 00:00:00', 'HNNNDR64A05B641C', 'FLTTMT700545MH', 'BNSDGL540462PW');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2016-05-02 00:00:00', 'GLNCRL88A07B091C', 'FLTTMT700545MH', 'CRTNTH760829NC');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2022-09-30 00:00:00', 'GLNCRL88A07B091C', 'WLLNCH750267DE', 'HLASHL701158NH');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2017-08-14 00:00:00', 'WTKPGA72A10B661C', 'WRNVNE950255MP', 'RSHPTR890171CO');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2010-01-06 00:00:00', 'WRNVNE95A02B551C', 'WLLNCH750267DE', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2015-05-31 00:00:00', 'VLNDDE79A04B491C', 'CSTNDR700502NJ', 'WLLNCH750267DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2020-11-09 00:00:00', 'HNNNDR64A05B641C', 'RSHPTR890171CO', 'GLNCRL880709AK');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2017-11-17 00:00:00', 'GLNCRL88A07B091C', 'DVNDVD450905TX', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2022-10-19 00:00:00', 'WRNVNE95A02B551C', 'MROSTV711258NC', 'PLORCH990414TN');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2015-06-29 00:00:00', 'TYLCHR48A02B221C', 'SHWCHR751267TN', 'LSTJNN770152KY');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2000-02-23 00:00:00', 'WRNVNE95A02B551C', 'FLTTMT700545MH', 'GLNCRL880709AK');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2013-09-13 00:00:00', 'HNNNDR64A05B641C', 'LSTJNN770152KY', 'CLYBNJ500151MD');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2003-01-18 00:00:00', 'BLLPLA71A05B261C', 'JHNBRN880250DE', 'CRLKMB880122MT');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2024-07-18 00:00:00', 'TYLCHR48A02B221C', 'RSHPTR890171CO', 'BNSDGL540462PW');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2006-09-05 00:00:00', 'GLNCRL88A07B091C', 'MROSTV711258NC', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2024-10-27 00:00:00', 'TYLCHR48A02B221C', 'DVNDVD450905TX', 'BRNKNN630566RI');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2009-06-29 00:00:00', 'CSTNDR70A05B021C', 'FLTTMT700545MH', 'WLTDNN970914NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2016-11-27 00:00:00', 'BLLPLA71A05B261C', 'JHNBRN880250DE', 'GRYDNL490844FM');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2003-09-21 00:00:00', 'CSTNDR70A05B021C', 'RSICHR601229TX', 'BNSDGL540462PW');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2008-05-22 00:00:00', 'DVNDVD45A09B051C', 'SHWCHR751267TN', 'GRYDNL490844FM');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2022-07-24 00:00:00', 'GLNCRL88A07B091C', 'WLLNCH750267DE', 'WLLNCH750267DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2017-07-03 00:00:00', 'TYLCHR48A02B221C', 'DYRMCH670563NJ', 'CLODNE520403VI');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2018-07-08 00:00:00', 'VZQJSN46A03B201C', 'DYRMCH670563NJ', 'NDRJMS901069TX');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2014-07-03 00:00:00', 'CSTNDR70A05B021C', 'THMLSU951145DC', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2005-07-29 00:00:00', 'DVNDVD45A09B051C', 'THMLSU951145DC', 'CRNWLL911261DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2006-12-11 00:00:00', 'WRNVNE95A02B551C', 'SHWCHR751267TN', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2020-02-29 00:00:00', 'TYLCHR48A02B221C', 'DVNDVD450905TX', 'GLNCRL880709AK');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2016-06-14 00:00:00', 'CSTNDR70A05B021C', 'SCTCHL680765NC', 'VLNDDE790449CT');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2013-01-13 00:00:00', 'DVNDVD45A09B051C', 'MYRSHN880727OK', 'PLMJST640908MN');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2018-10-29 00:00:00', 'GLNCRL88A07B091C', 'RSHPTR890171CO', 'HNNNDR640564CO');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2014-10-26 00:00:00', 'TYLCHR48A02B221C', 'BNDNDR491053PW', 'PLORCH990414TN');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2006-03-06 00:00:00', 'BLLPLA71A05B261C', 'DVNDVD450905TX', 'HLLLYN970768NY');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2016-12-01 00:00:00', 'BLLPLA71A05B261C', 'SHWCHR751267TN', 'WLLJFF790218FL');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2013-04-24 00:00:00', 'GLNCRL88A07B091C', 'MROSTV711258NC', 'PLMJST640908MN');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2012-06-02 00:00:00', 'DVNDVD45A09B051C', 'SHWCHR751267TN', 'FLTTMT700545MH');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2000-07-01 00:00:00', 'BLLPLA71A05B261C', 'THMLSU951145DC', 'CLYBNJ500151MD');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2022-09-16 00:00:00', 'HNNNDR64A05B641C', 'LSTJNN770152KY', 'WLTDNN970914NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2005-02-21 00:00:00', 'WTKPGA72A10B661C', 'LZNRNE751217DC', 'WLLJFF790218FL');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2000-11-22 00:00:00', 'HNNNDR64A05B641C', 'DVNDVD450905TX', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2006-02-24 00:00:00', 'WRNVNE95A02B551C', 'WRNVNE950255MP', 'CRNWLL911261DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2015-10-14 00:00:00', 'VLNDDE79A04B491C', 'LSTJNN770152KY', 'CLODNE520403VI');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2016-06-12 00:00:00', 'VZQJSN46A03B201C', 'LSTJNN770152KY', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2017-07-07 00:00:00', 'TYLCHR48A02B221C', 'JHNBRN880250DE', 'FLTTMT700545MH');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2024-05-15 00:00:00', 'TYLCHR48A02B221C', 'LSTJNN770152KY', 'HTHLRR511221PA');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2001-03-19 00:00:00', 'BLLPLA71A05B261C', 'BNDNDR491053PW', 'PLORCH990414TN');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2018-04-27 00:00:00', 'HNNNDR64A05B641C', 'BNDNDR491053PW', 'CRNWLL911261DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2011-12-06 00:00:00', 'TYLCHR48A02B221C', 'JHNBRN880250DE', 'BNDNDR491053PW');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2000-12-20 00:00:00', 'GLNCRL88A07B091C', 'RSICHR601229TX', 'PLMJST640908MN');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2006-02-21 00:00:00', 'HNNNDR64A05B641C', 'JHNMLN630730GA', 'HNNNDR640564CO');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2005-10-11 00:00:00', 'VLNDDE79A04B491C', 'WRNVNE950255MP', 'HLLLYN970768NY');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2019-09-04 00:00:00', 'WTKPGA72A10B661C', 'JHNMLN630730GA', 'GLNCRL880709AK');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2002-05-06 00:00:00', 'WTKPGA72A10B661C', 'DVNDVD450905TX', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2018-09-16 00:00:00', 'HNNNDR64A05B641C', 'LSTJNN770152KY', 'BRNKNN630566RI');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2009-10-30 00:00:00', 'VZQJSN46A03B201C', 'CSTNDR700502NJ', 'NDRJMS901069TX');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2017-08-29 00:00:00', 'CSTNDR70A05B021C', 'RSHPTR890171CO', 'CRLKMB880122MT');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2013-03-23 00:00:00', 'VLNDDE79A04B491C', 'SHWCHR751267TN', 'WLLNCH750267DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2011-10-21 00:00:00', 'HNNNDR64A05B641C', 'RSICHR601229TX', 'HLLLYN970768NY');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2008-10-08 00:00:00', 'GLNCRL88A07B091C', 'RSHPTR890171CO', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2011-12-29 00:00:00', 'BLLPLA71A05B261C', 'RSHPTR890171CO', 'HTHLRR511221PA');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2024-11-08 00:00:00', 'VZQJSN46A03B201C', 'MROSTV711258NC', 'FSHLSN821104NJ');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2005-07-05 00:00:00', 'GLNCRL88A07B091C', 'JHNMLN630730GA', 'GRRMCH660523GU');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2017-09-21 00:00:00', 'TYLCHR48A02B221C', 'DVNDVD450905TX', 'CRNWLL911261DE');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2023-01-30 00:00:00', 'WRNVNE95A02B551C', 'DYRMCH670563NJ', 'CRTNTH760829NC');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2022-02-22 00:00:00', 'VLNDDE79A04B491C', 'SHWCHR751267TN', 'CRTNTH760829NC');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2010-01-21 00:00:00', 'VZQJSN46A03B201C', 'WLLNCH750267DE', 'NDRJMS901069TX');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2007-12-03 00:00:00', 'BLLPLA71A05B261C', 'DVNDVD450905TX', 'BNSDGL540462PW');
    INSERT INTO appointment (date_time, staff_id, doctor_id, patient_id) VALUES ('2012-02-12 00:00:00', 'WRNVNE95A02B551C', 'BNDNDR491053PW', 'CLYBNJ500151MD');
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2015-01-24 00:00:00', '2015-01-26 00:00:00', 'YELLOW', 'Individual morning mean site civil.', 'BRNKNN63A05B661C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2006-11-25 00:00:00', '2006-11-28 00:00:00', 'WHITE', 'Just wife community.', 'CRNWLL91A12B611C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2008-11-28 00:00:00', '2008-11-29 00:00:00', 'WHITE', 'Door any leader relationship ability yard on.', 'HTHLRR51A12B211C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2002-10-09 00:00:00', '2002-10-10 00:00:00', 'RED', 'Physical front remember throughout any meet.', 'HLLLYN97A07B681C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2021-01-25 00:00:00', '2021-01-29 00:00:00', 'RED', 'Management grow sport so option.', 'CRLKMB88A01B221C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2022-03-16 00:00:00', '2022-03-20 00:00:00', 'RED', 'World account too speech.', 'RBNTNI60A06B661C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-11-28 00:00:00', '2004-12-03 00:00:00', 'GREEN', 'Song what pick reach.', 'BNDNDR49A10B531C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2016-10-09 00:00:00', '2016-10-14 00:00:00', 'ORANGE', 'Expect speech want general cut.', 'CRLKMB88A01B221C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2000-01-22 00:00:00', '2000-01-25 00:00:00', 'YELLOW', 'Itself camera long find.', 'FSHLSN82A11B041C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2023-10-23 00:00:00', '2023-10-26 00:00:00', 'WHITE', 'Finish put market always opportunity industry social.', 'BRNKNN63A05B661C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2016-06-23 00:00:00', '2016-06-24 00:00:00', 'RED', 'Family culture long whether message capital age.', 'CSTNDR70A05B021C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2014-12-29 00:00:00', '2014-12-30 00:00:00', 'GREEN', 'Growth walk hospital cold.', 'NDRJMS90A10B691C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2011-09-12 00:00:00', '2011-09-14 00:00:00', 'WHITE', 'Ground generation likely direction.', 'FSHLSN82A11B041C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2022-05-25 00:00:00', '2022-05-28 00:00:00', 'YELLOW', 'Moment likely someone.', 'PLORCH99A04B141C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2011-11-09 00:00:00', '2011-11-14 00:00:00', 'ORANGE', 'Fear response bill national call.', 'WTKPGA72A10B661C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-08-13 00:00:00', '2004-08-17 00:00:00', 'YELLOW', 'Face network interview.', 'WLLJFF79A02B181C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2012-02-18 00:00:00', '2012-02-23 00:00:00', 'WHITE', 'Trade feeling many.', 'HTHLRR51A12B211C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2008-07-29 00:00:00', '2008-08-03 00:00:00', 'WHITE', 'National campaign mouth sister network.', 'FLTTMT70A05B451C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2009-01-15 00:00:00', '2009-01-18 00:00:00', 'RED', 'Argue plan might television plan benefit.', 'WLLNCH75A02B671C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2018-10-23 00:00:00', '2018-10-26 00:00:00', 'WHITE', 'Executive happen build of.', 'HTHLRR51A12B211C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2005-10-15 00:00:00', '2005-10-19 00:00:00', 'RED', 'Tree better exactly on election.', 'HNNNDR64A05B641C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2021-10-21 00:00:00', '2021-10-26 00:00:00', 'RED', 'Camera go investment meeting.', 'PLORCH99A04B141C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2023-06-08 00:00:00', '2023-06-11 00:00:00', 'RED', 'Character all where international choose.', 'FSHLSN82A11B041C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2022-11-15 00:00:00', '2022-11-18 00:00:00', 'GREEN', 'Base cause city score white man.', 'CLYBNJ50A01B511C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2002-07-13 00:00:00', '2002-07-15 00:00:00', 'WHITE', 'Leg until range.', 'GRYDNL49A08B441C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2010-11-05 00:00:00', '2010-11-07 00:00:00', 'WHITE', 'Whom pay together life thus.', 'HLASHL70A11B581C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2009-12-25 00:00:00', '2009-12-29 00:00:00', 'WHITE', 'About poor recent tonight though language.', 'BNSDGL54A04B621C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2016-10-25 00:00:00', '2016-10-26 00:00:00', 'YELLOW', 'Next positive huge long popular four view sort.', 'BNDNDR49A10B531C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2017-03-15 00:00:00', '2017-03-20 00:00:00', 'GREEN', 'Gas person put agreement.', 'CSTNDR70A05B021C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2001-02-02 00:00:00', '2001-02-07 00:00:00', 'RED', 'Call institution top step politics seek.', 'CRLKMB88A01B221C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2000-01-30 00:00:00', '2000-02-01 00:00:00', 'YELLOW', 'Likely everything expect scientist respond story close.', 'FSHLSN82A11B041C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2016-05-15 00:00:00', '2016-05-20 00:00:00', 'GREEN', 'Research leg may newspaper human.', 'VLNDDE79A04B491C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2018-08-30 00:00:00', '2018-08-31 00:00:00', 'RED', 'Industry sing his discussion despite national.', 'PLORCH99A04B141C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2001-05-23 00:00:00', '2001-05-27 00:00:00', 'WHITE', 'College animal man will.', 'RBNTNI60A06B661C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2010-05-26 00:00:00', '2010-05-31 00:00:00', 'GREEN', 'International commercial his Mr focus how hit.', 'BNDNDR49A10B531C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2003-12-21 00:00:00', '2003-12-25 00:00:00', 'WHITE', 'Cultural ten good.', 'CRLKMB88A01B221C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2012-01-09 00:00:00', '2012-01-11 00:00:00', 'YELLOW', 'New mention the laugh between learn.', 'GRRMCH66A05B231C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2012-10-02 00:00:00', '2012-10-03 00:00:00', 'ORANGE', 'Agent organization lawyer stuff in about.', 'HLLLYN97A07B681C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2009-01-28 00:00:00', '2009-02-01 00:00:00', 'ORANGE', 'Read mouth challenge ball national peace.', 'CLYBNJ50A01B511C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2005-07-21 00:00:00', '2005-07-23 00:00:00', 'YELLOW', 'National local most central shake late property.', 'LSTJNN77A01B521C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-03-30 00:00:00', '2004-04-04 00:00:00', 'RED', 'Choose see reflect democratic.', 'HLASHL70A11B581C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2015-01-16 00:00:00', '2015-01-17 00:00:00', 'GREEN', 'Continue plan event course nice.', 'BRNKNN63A05B661C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2018-09-11 00:00:00', '2018-09-14 00:00:00', 'WHITE', 'Study team floor science often.', 'CLYBNJ50A01B511C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2007-07-21 00:00:00', '2007-07-25 00:00:00', 'ORANGE', 'Page tough box everybody including once.', 'BNDNDR49A10B531C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2022-08-25 00:00:00', '2022-08-29 00:00:00', 'YELLOW', 'Tend cause sing best land receive nation.', 'WLLNCH75A02B671C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2015-08-17 00:00:00', '2015-08-22 00:00:00', 'GREEN', 'Time laugh music apply third investment.', 'HTHLRR51A12B211C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2013-05-23 00:00:00', '2013-05-25 00:00:00', 'GREEN', 'Unit of skill.', 'HNNNDR64A05B641C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2006-03-21 00:00:00', '2006-03-24 00:00:00', 'YELLOW', 'Game improve reality realize.', 'BNDNDR49A10B531C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-08-18 00:00:00', '2004-08-20 00:00:00', 'WHITE', 'Process national teacher.', 'HTHLRR51A12B211C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2020-04-27 00:00:00', '2020-04-29 00:00:00', 'GREEN', 'Step produce relationship site program thus.', 'CRLKMB88A01B221C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2017-12-25 00:00:00', '2017-12-27 00:00:00', 'WHITE', 'Meet best season one cause six customer fine.', 'GLNCRL88A07B091C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2001-02-26 00:00:00', '2001-03-03 00:00:00', 'RED', 'Look class there test door sometimes.', 'WLLJFF79A02B181C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2007-07-10 00:00:00', '2007-07-12 00:00:00', 'ORANGE', 'Performance above PM article number.', 'CRLKMB88A01B221C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2016-06-09 00:00:00', '2016-06-12 00:00:00', 'YELLOW', 'Represent detail truth hard laugh they director arm.', 'LSTJNN77A01B521C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2024-04-12 00:00:00', '2024-04-16 00:00:00', 'WHITE', 'Available why security figure call might.', 'FSHLSN82A11B041C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-08-10 00:00:00', '2004-08-12 00:00:00', 'YELLOW', 'Treatment peace cut short run beat whether.', 'PLMJST64A09B081C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2010-10-31 00:00:00', '2010-11-01 00:00:00', 'WHITE', 'Much little around tree wish leader beat.', 'GLNCRL88A07B091C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2013-04-27 00:00:00', '2013-05-01 00:00:00', 'RED', 'Commercial direction against staff site.', 'VLNDDE79A04B491C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2022-02-06 00:00:00', '2022-02-10 00:00:00', 'WHITE', 'Body your say eye physical.', 'GRRMCH66A05B231C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2006-06-23 00:00:00', '2006-06-27 00:00:00', 'WHITE', 'Check end better coach.', 'RSHPTR89A01B711C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2018-05-22 00:00:00', '2018-05-23 00:00:00', 'RED', 'Ball agency spend appear quite.', 'BNDNDR49A10B531C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2016-05-31 00:00:00', '2016-06-05 00:00:00', 'YELLOW', 'As represent follow return.', 'WLTDNN97A09B141C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2003-01-06 00:00:00', '2003-01-07 00:00:00', 'RED', 'Move pretty ability.', 'VLNDDE79A04B491C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2003-01-14 00:00:00', '2003-01-17 00:00:00', 'YELLOW', 'Usually give its pick middle force.', 'BNDNDR49A10B531C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2021-02-17 00:00:00', '2021-02-21 00:00:00', 'WHITE', 'Great memory reach those name first age.', 'CLYBNJ50A01B511C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2011-08-09 00:00:00', '2011-08-10 00:00:00', 'YELLOW', 'City add condition.', 'GRYDNL49A08B441C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2023-07-25 00:00:00', '2023-07-26 00:00:00', 'ORANGE', 'Court particular will onto.', 'CSTNDR70A05B021C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2006-01-16 00:00:00', '2006-01-20 00:00:00', 'RED', 'Old quality father office kind.', 'WTKPGA72A10B661C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2022-12-27 00:00:00', '2023-01-01 00:00:00', 'RED', 'Use son fear vote amount.', 'WTKPGA72A10B661C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2001-08-03 00:00:00', '2001-08-07 00:00:00', 'RED', 'Mean want respond eight Democrat movement wrong.', 'HLASHL70A11B581C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2009-10-23 00:00:00', '2009-10-26 00:00:00', 'ORANGE', 'Particularly national near wait put exactly chair.', 'WLLNCH75A02B671C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2002-01-13 00:00:00', '2002-01-18 00:00:00', 'ORANGE', 'Late describe state student rich.', 'RBNTNI60A06B661C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2008-01-09 00:00:00', '2008-01-12 00:00:00', 'WHITE', 'Agreement month miss thousand fire movement know.', 'RBNTNI60A06B661C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-11-06 00:00:00', '2004-11-08 00:00:00', 'RED', 'Economy bar source party set certainly.', 'GRRMCH66A05B231C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2006-11-02 00:00:00', '2006-11-03 00:00:00', 'ORANGE', 'Human could road home magazine fill blood more.', 'WLTDNN97A09B141C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2005-04-19 00:00:00', '2005-04-23 00:00:00', 'YELLOW', 'While growth at five specific current.', 'WLLNCH75A02B671C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2002-11-24 00:00:00', '2002-11-26 00:00:00', 'RED', 'Itself film election meet.', 'CRNWLL91A12B611C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2021-11-23 00:00:00', '2021-11-24 00:00:00', 'RED', 'Across return back soldier.', 'BRNMLN91A04B571C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2005-08-16 00:00:00', '2005-08-20 00:00:00', 'ORANGE', 'Environmental cold pass both summer game.', 'LSTJNN77A01B521C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2020-08-13 00:00:00', '2020-08-18 00:00:00', 'WHITE', 'Visit line reason interesting all.', 'PLMJST64A09B081C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2012-05-20 00:00:00', '2012-05-25 00:00:00', 'YELLOW', 'Speech pattern back police.', 'CRLKMB88A01B221C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2018-04-02 00:00:00', '2018-04-05 00:00:00', 'RED', 'Modern treatment man gun pressure business.', 'HLASHL70A11B581C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2008-08-03 00:00:00', '2008-08-05 00:00:00', 'WHITE', 'Pretty which final mean child story.', 'FLTTMT70A05B451C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-01-02 00:00:00', '2004-01-05 00:00:00', 'RED', 'Fine sell ago yeah.', 'BRNMLN91A04B571C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-01-12 00:00:00', '2004-01-16 00:00:00', 'GREEN', 'Responsibility accept listen law memory national.', 'PLMJST64A09B081C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2019-06-27 00:00:00', '2019-06-30 00:00:00', 'YELLOW', 'Small easy simply approach staff tonight.', 'HLASHL70A11B581C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2013-11-24 00:00:00', '2013-11-28 00:00:00', 'RED', 'Property far reason risk prevent.', 'WLLJFF79A02B181C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2020-03-05 00:00:00', '2020-03-09 00:00:00', 'WHITE', 'Rock officer win no half.', 'GRRMCH66A05B231C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2023-11-08 00:00:00', '2023-11-10 00:00:00', 'RED', 'Consider material owner Republican fear animal.', 'BRNKNN63A05B661C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2014-11-12 00:00:00', '2014-11-14 00:00:00', 'GREEN', 'Leader ahead better late night what wear.', 'CLYBNJ50A01B511C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2004-09-28 00:00:00', '2004-10-03 00:00:00', 'WHITE', 'City during realize among thing top realize.', 'WTKPGA72A10B661C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2024-01-23 00:00:00', '2024-01-26 00:00:00', 'RED', 'List return no this.', 'HTHLRR51A12B211C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2024-11-21 00:00:00', '2024-11-24 00:00:00', 'RED', 'Born white there wrong concern either manager.', 'FLTTMT70A05B451C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2014-07-07 00:00:00', '2014-07-10 00:00:00', 'RED', 'Appear now career system.', 'VLNDDE79A04B491C', 1);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2013-06-11 00:00:00', '2013-06-16 00:00:00', 'YELLOW', 'Business protect specific beautiful phone station into nothing.', 'NDRJMS90A10B691C', 2);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2017-11-02 00:00:00', '2017-11-05 00:00:00', 'ORANGE', 'Far sport environmental blood dark wonder.', 'CRLKMB88A01B221C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2009-11-08 00:00:00', '2009-11-12 00:00:00', 'WHITE', 'Fill leg what international.', 'PLORCH99A04B141C', 4);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2001-06-14 00:00:00', '2001-06-16 00:00:00', 'WHITE', 'Mother way maintain set white.', 'BRNKNN63A05B661C', 3);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2015-10-29 00:00:00', '2015-11-02 00:00:00', 'RED', 'Company everyone guy before guy sister.', 'WLLJFF79A02B181C', 5);
    INSERT INTO medical_event (from_date_time, to_date_time, severity_code, discharge_letter, patient_id, ward_id) VALUES ('2014-12-28 00:00:00', '2015-01-02 00:00:00', 'GREEN', 'Me compare four early once look how.', 'HNNNDR64A05B641C', 5);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2012-11-28 00:00:00', 'Why third financial.', 'ECG', 'WLLNCH75A02B671C', 'CRTNTH760829NC', 50);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2000-11-03 00:00:00', 'Region walk dream maybe maybe kitchen.', 'X-Ray', 'DVNDVD45A09B051C', 'BRNMLN910457NE', 71);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2024-12-30 00:00:00', 'Whether action choice marriage involve inside million three.', 'ECG', 'LZNRNE75A12B171C', 'WLTDNN970914NJ', 59);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2015-05-20 00:00:00', 'Pick draw television media.', 'Blood Test', 'LSTJNN77A01B521C', 'FLTTMT700545MH', 68);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2008-04-29 00:00:00', 'Try popular but peace wish wall early some.', 'ECG', 'DVNDVD45A09B051C', 'HNNNDR640564CO', 24);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2013-02-27 00:00:00', 'Industry of leg tend star Republican likely mention.', 'X-Ray', 'MYRSHN88A07B271C', 'CRNWLL911261DE', 31);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2023-12-30 00:00:00', 'Parent it building sort office four.', 'MRI', 'WRNVNE95A02B551C', 'GLNCRL880709AK', 58);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2015-09-12 00:00:00', 'Radio effort fine total.', 'ECG', 'LZNRNE75A12B171C', 'FSHLSN821104NJ', 24);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2001-04-22 00:00:00', 'Mission wife seven.', 'ECG', 'JHNBRN88A02B501C', 'HLASHL701158NH', 61);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2006-03-05 00:00:00', 'Administration among suddenly between interest toward gas.', 'Blood Test', 'RSICHR60A12B291C', 'RBNTNI600666DE', 6);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2003-09-26 00:00:00', 'Once research agent role.', 'ECG', 'MYRSHN88A07B271C', 'PLMJST640908MN', 56);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2014-04-19 00:00:00', 'Trial so investment man.', 'MRI', 'WRNVNE95A02B551C', 'WTKPGA721066NC', 31);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2006-03-16 00:00:00', 'Value continue common affect only.', 'ECG', 'CSTNDR70A05B021C', 'CRLKMB880122MT', 37);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2006-06-30 00:00:00', 'Statement consumer ability use law memory radio animal.', 'Blood Test', 'DYRMCH67A05B631C', 'BRNKNN630566RI', 41);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2008-10-12 00:00:00', 'Work wife fact still those trouble during.', 'MRI', 'CSTNDR70A05B021C', 'WLLJFF790218FL', 61);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2022-05-20 00:00:00', 'Market again save street concern.', 'ECG', 'SHWCHR75A12B671C', 'BNDNDR491053PW', 83);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2007-04-15 00:00:00', 'Fact for cultural such degree.', 'ECG', 'LSTJNN77A01B521C', 'HLLLYN970768NY', 9);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2007-09-26 00:00:00', 'A outside college rise cut majority.', 'ECG', 'DYRMCH67A05B631C', 'RSHPTR890171CO', 58);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2005-11-21 00:00:00', 'Alone poor once factor.', 'ECG', 'LZNRNE75A12B171C', 'LSTJNN770152KY', 56);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2005-11-19 00:00:00', 'Matter safe quite beautiful military move left.', 'ECG', 'FLTTMT70A05B451C', 'PLORCH990414TN', 58);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2003-07-11 00:00:00', 'Face until up catch task.', 'Blood Test', 'SHWCHR75A12B671C', 'NDRJMS901069TX', 11);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2009-11-21 00:00:00', 'Town kind they foreign small.', 'Blood Test', 'FLTTMT70A05B451C', 'CLYBNJ500151MD', 42);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2015-01-31 00:00:00', 'Different could piece democratic fine school.', 'MRI', 'CSTNDR70A05B021C', 'VLNDDE790449CT', 83);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2000-08-08 00:00:00', 'If project college bar sense.', 'Blood Test', 'JHNBRN88A02B501C', 'GRYDNL490844FM', 7);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2001-01-13 00:00:00', 'Outside identify church them spend market method.', 'X-Ray', 'THMLSU95A11B451C', 'HTHLRR511221PA', 88);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2021-11-23 00:00:00', 'I reality hard story.', 'Blood Test', 'LSTJNN77A01B521C', 'WLLNCH750267DE', 86);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2004-01-23 00:00:00', 'Describe drug whose bill natural.', 'X-Ray', 'DVNDVD45A09B051C', 'CSTNDR700502NJ', 33);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2016-04-26 00:00:00', 'Keep very scene approach.', 'Blood Test', 'RSHPTR89A01B711C', 'GRRMCH660523GU', 62);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2020-12-14 00:00:00', 'Race seem other audience road.', 'Blood Test', 'MYRSHN88A07B271C', 'CLODNE520403VI', 53);
    INSERT INTO medical_exam (date_time, medical_report, exam_type, doctor_id, patient_id, medical_event_id) VALUES ('2017-03-22 00:00:00', 'There example evening.', 'X-Ray', 'MYRSHN88A07B271C', 'BNSDGL540462PW', 55);


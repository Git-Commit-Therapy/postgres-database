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

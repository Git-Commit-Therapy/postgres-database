import random
import string
from datetime import datetime, timedelta
from faker import Faker

# Initialize Faker for generating fake names and other info
fake = Faker()


# Helper function to generate Codice Fiscale
def generate_codice_fiscale(name, surname, dob, gender, place_code):
    def extract_chars(name, num_chars=3):
        consonants = "".join([c for c in name.upper() if c in "BCDFGHJKLMNPQRSTVWXYZ"])
        vowels = "".join([c for c in name.upper() if c in "AEIOU"])
        if len(consonants) >= num_chars:
            return consonants[:num_chars]
        else:
            remaining_chars = num_chars - len(consonants)
            return consonants + vowels[:remaining_chars]

    surname = extract_chars(surname)
    name = extract_chars(name)

    year = dob.year
    month = dob.month
    day = dob.day
    date_part = f"{year % 100:02d}{month:02d}{day:02d}"

    if gender == "F":
        day += 40
        date_part = f"{year % 100:02d}{month:02d}{day:02d}"

    place_code = place_code.upper()

    codice_fiscale = f"{surname}{name}{date_part}{place_code}"
    return codice_fiscale[:16]


# Helper function to generate a random SID (unique string)
def generate_sid():
    return "".join(random.choices(string.ascii_letters + string.digits, k=50))


# Helper function to generate a random phone number
def generate_phone_number():
    return f"+39{random.randint(300000000, 399999999)}"


# Helper function to generate a random date for appointments, medical events, etc.
def generate_random_date(start_year=2000, end_year=2024):
    start_date = datetime(year=start_year, month=1, day=1)
    end_date = datetime(year=end_year, month=12, day=31)
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    random_date = start_date + timedelta(days=random_days)
    return random_date


# List of ward names
ward_names = [
    "Cardiology",
    "Neurology",
    "Pediatrics",
    "Surgical Unit",
    "Emergency Room",
    "Intensive Care Unit",
    "Orthopedic Ward",
    "Maternity Ward",
    "General Medicine",
    "Oncology",
    "Psychiatry",
    "Trauma Unit",
    "Urology",
    "Renal Care",
    "Gastroenterology",
    "Respiratory Care",
    "Endocrinology",
    "Dermatology",
    "Hematology",
    "Rheumatology",
    "Infectious Diseases",
    "Palliative Care",
    "Rehabilitation Unit",
    "Cardiothoracic Surgery",
    "Neonatal Intensive Care Unit",
    "Pediatric Surgery",
    "Post-Operative Recovery",
    "Stroke Unit",
    "Burn Unit",
    "Spinal Cord Injury Center",
]


# Function to escape single quotes in strings for SQL
def escape_sql_string(value):
    return value.replace("'", "''")


# Open the file to write SQL statements
with open("generate_data.sql", "w") as file:
    users = []
    staff_ids = []
    patient_ids = []
    doctor_ids = []
    wards_data = [
        {"WardID": i + 1, "Name": random.choice(ward_names)} for i in range(5)
    ]
    medical_events = []

    # Generate 100 users
    for _ in range(100):
        name = fake.first_name()
        surname = fake.last_name()
        dob = fake.date_of_birth(minimum_age=18, maximum_age=80)
        gender = random.choice(["M", "F"])
        place_code = fake.state_abbr()  # Random state code as a placeholder

        codice_fiscale = generate_codice_fiscale(name, surname, dob, gender, place_code)
        sid = generate_sid()
        phone_number = generate_phone_number()

        user = {
            "ID": codice_fiscale,
            "Name": name,
            "Surname": surname,
            "DateOfBirth": dob,
            "SID": sid,
            "PhoneNumber": phone_number,
        }
        users.append(user)

        # Assign some of the users as Staff, Patients, and Doctors
        if random.random() < 0.1:
            staff_ids.append(codice_fiscale)
        if random.random() < 0.3:
            patient_ids.append(codice_fiscale)
        if random.random() < 0.2:
            doctor_ids.append(codice_fiscale)

    # Write SQL INSERT Statements for Wards first (ensures WardID is available for Doctors)
    for ward in wards_data:
        file.write(
            f"INSERT INTO \"Ward\" (\"WardID\", \"Name\") VALUES ({ward['WardID']}, '{ward['Name']}');\n"
        )

    # Write SQL INSERT Statements for Users
    for user in users:
        file.write(
            f'INSERT INTO "User" ("ID", "Name", "Surname", "DateOfBirth", "SID", "PhoneNumber") '
            f"VALUES ('{user['ID']}', '{user['Name']}', '{user['Surname']}', '{user['DateOfBirth']}', "
            f"'{user['SID']}', '{user['PhoneNumber']}');\n"
        )

    # Write SQL INSERT Statements for Staff
    for staff_id in staff_ids:
        file.write(f'INSERT INTO "Staff" ("StaffID") VALUES (\'{staff_id}\');\n')

    # Write SQL INSERT Statements for Patient
    for patient_id in patient_ids:
        file.write(f'INSERT INTO "Patient" ("PatientID") VALUES (\'{patient_id}\');\n')

    # Write SQL INSERT Statements for Doctor (after Wards are populated)
    for doctor_id in doctor_ids:
        med_specialization = escape_sql_string(
            fake.job()
        )  # Escape the specialization string
        ward_id = random.choice(wards_data)["WardID"]
        file.write(
            f'INSERT INTO "Doctor" ("DoctorID", "MedSpecialization", "OfficePhoneNumber", "WardID") '
            f"VALUES ('{doctor_id}', '{med_specialization}', '{generate_phone_number()}', {ward_id});\n"
        )

    # Write SQL INSERT Statements for MedicalInfo (for each patient)
    for patient_id in patient_ids:
        description = fake.paragraph(nb_sentences=1)
        file.write(
            f'INSERT INTO "MedicalInfo" ("PatientID", "Description") VALUES (\'{patient_id}\', \'{description}\');\n'
        )

    # Write SQL INSERT Statements for Appointments
    for _ in range(100):
        appointment_date = generate_random_date()
        staff_id = random.choice(staff_ids)
        doctor_id = random.choice(doctor_ids)
        patient_id = random.choice(patient_ids)
        file.write(
            f'INSERT INTO "Appointment" ("DateTime", "StaffID", "DoctorID", "PatientID") '
            f"VALUES ('{appointment_date}', '{staff_id}', '{doctor_id}', '{patient_id}');\n"
        )

    # Generate 100 MedicalEvent records first (so they exist before we reference them in MedicalExams)
    for event_id in range(1, 101):
        event_start = generate_random_date()
        event_end = event_start + timedelta(days=random.randint(1, 5))
        severity = random.choice(["WHITE", "GREEN", "YELLOW", "ORANGE", "RED"])
        discharge_letter = fake.paragraph(nb_sentences=1)
        ward_id = random.choice(wards_data)["WardID"]
        medical_events.append(event_id)  # Store event ID for later use in MedicalExam
        file.write(
            f'INSERT INTO "MedicalEvent" ("FromDateTime", "ToDateTime", "SeverityCode", "DischargeLetter", '
            f"\"PatientID\", \"WardID\") VALUES ('{event_start}', '{event_end}', '{severity}', '{discharge_letter}', "
            f"'{random.choice(patient_ids)}', {ward_id});\n"
        )

    # Write SQL INSERT Statements for MedicalExams (after MedicalEvents are generated)
    for patient_id in patient_ids:
        exam_date = generate_random_date()
        medical_report = fake.paragraph(nb_sentences=1)
        exam_type = random.choice(["Blood Test", "X-Ray", "MRI", "ECG"])
        doctor_id = random.choice(doctor_ids)
        medical_event_id = random.choice(
            medical_events
        )  # Link to one of the generated MedicalEvents
        file.write(
            f'INSERT INTO "MedicalExam" ("DateTime", "MedicalReport", "ExamType", "DoctorID", "PatientID", '
            f"\"MedicalEvent\") VALUES ('{exam_date}', '{medical_report}', '{exam_type}', '{doctor_id}', "
            f"'{patient_id}', {medical_event_id});\n"
        )

print("SQL file generated successfully.")

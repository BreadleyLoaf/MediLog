CREATE TABLE users (
    userID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    role ENUM('doctor', 'nurse', 'patient') NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
)

CREATE TABLE patients (
    patientID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    dateOfBirth DATE,
    healthCardNo VARCHAR(50) UNIQUE,
    phoneNo VARCHAR(15),
    FOREIGN KEY (userID) REFERENCES users(userID)
)

CREATE TABLE doctors (
    doctorID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    specialty VARCHAR(100),
    phoneNo VARCHAR(15),
    FOREIGN KEY (userID) REFERENCES users(userID)
)

CREATE TABLE medications (
    medicationID INT PRIMARY KEY AUTO_INCREMENT,
    patientID INT,
    name VARCHAR(100) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    instructions TEXT,
    prevRefillDate DATE,
    refill_frequency INT,
    FOREIGN KEY (patientID) REFERENCES patients(patientID)
)

CREATE TABLE refill_requests (
    requestID INT PRIMARY KEY AUTO_INCREMENT,
    medicationID INT,
    patientID INT,
    notes TEXT,
    prevRefillDate DATE,
    refill_frequency INT,
    requestDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'approved', 'denied') DEFAULT 'pending',
    approvedBy INT NULL,
    approvalDate TIMESTAMP NULL,
    FOREIGN KEY (medicationID) REFERENCES medications(medicationID),
    FOREIGN KEY (patientID) REFERENCES patients(patientID),
    FOREIGN KEY (approvedBy) REFERENCES doctors(doctorID)
)
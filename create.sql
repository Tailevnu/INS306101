-- 1. KHỞI TẠO DATABASE
DROP DATABASE IF EXISTS SmartBookingDB;
CREATE DATABASE SmartBookingDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE SmartBookingDB;

-- =====================================================
-- 2. TẠO CÁC BẢNG (TABLES)
-- =====================================================

-- Tạo bảng Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    phone_number VARCHAR(50) NULL,
    created_at DATETIME NULL,
    updated_at DATETIME NULL
);

-- Tạo bảng Rooms
CREATE TABLE Rooms (
    room_id VARCHAR(50) PRIMARY KEY NOT NULL,
    room_name VARCHAR(255) NOT NULL,
    location TEXT NOT NULL,
    capacity INT NOT NULL,
    room_type VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL,
    description TEXT NULL
);

-- Tạo bảng Bookings
CREATE TABLE Bookings (
    booking_id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT NOT NULL,
    room_id VARCHAR(50) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    purpose TEXT NOT NULL,
    status VARCHAR(50) NOT NULL,
    check_in_time DATETIME NULL,
    check_out_time DATETIME NULL,
    created_at DATETIME NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Tạo bảng QR_Tokens
CREATE TABLE QR_Tokens (
    token_id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    booking_id BIGINT NOT NULL,
    token_string VARCHAR(255) NOT NULL,
    token_type VARCHAR(50) NOT NULL,
    expires_at DATETIME NOT NULL,
    is_used BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Tạo bảng Violations
CREATE TABLE Violations (
    violation_id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT NOT NULL,
    booking_id BIGINT NOT NULL,
    violation_type VARCHAR(100) NOT NULL,
    penalty_note TEXT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Tạo bảng Notifications
CREATE TABLE Notifications (
    NotiID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    isRead INT NOT NULL,
    createdAt DATETIME NOT NULL,
    booking_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Tạo bảng BookingLogs
CREATE TABLE BookingLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    action VARCHAR(255) NOT NULL,
    timestamp DATETIME NOT NULL,
    note TEXT NOT NULL,
    booking_id BIGINT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

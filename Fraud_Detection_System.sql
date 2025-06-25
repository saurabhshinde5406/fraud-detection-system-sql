
-- Project: SQL-Based Fraud Detection System

-- Create Tables
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE Transactions (
    txn_id INT PRIMARY KEY,
    user_id INT,
    txn_amount DECIMAL(10,2),
    txn_date TIMESTAMP,
    ip_address VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Sample Queries

-- 1. Detect transactions above a certain threshold (e.g., 50,000)
SELECT user_id, txn_id, txn_amount
FROM Transactions
WHERE txn_amount > 50000;

-- 2. Identify users with unusually frequent transactions in a short time
SELECT user_id, COUNT(*) AS txn_count, DATE(txn_date) AS txn_day
FROM Transactions
GROUP BY user_id, DATE(txn_date)
HAVING COUNT(*) > 5;

-- 3. Find users with multiple transactions from different IPs in a short period (possible fraud)
SELECT user_id, COUNT(DISTINCT ip_address) AS unique_ips, DATE(txn_date) AS txn_day
FROM Transactions
GROUP BY user_id, DATE(txn_date)
HAVING unique_ips > 3;

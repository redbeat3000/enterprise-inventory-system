-- Enterprise Inventory Management System
-- GitHub Repository Starter: Database Schema and Logic

-- 1. Product Categorization and Stock Tracking
CREATE TABLE Categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    category_id INT,
    sku VARCHAR(100) UNIQUE,
    description TEXT,
    FOREIGN KEY (category_id) REFERENCES Categories(id)
);

-- 2. Warehouse vs Store-Level Inventory
CREATE TABLE Branches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type ENUM('store', 'warehouse') NOT NULL,
    location VARCHAR(255)
);

CREATE TABLE Inventory (
    product_id INT,
    branch_id INT,
    quantity INT DEFAULT 0,
    PRIMARY KEY (product_id, branch_id),
    FOREIGN KEY (product_id) REFERENCES Products(id),
    FOREIGN KEY (branch_id) REFERENCES Branches(id)
);

-- 3. Low-Stock Alert System Using Triggers
DELIMITER $$
CREATE TRIGGER trg_low_stock_alert
AFTER UPDATE ON Inventory
FOR EACH ROW
BEGIN
    IF NEW.quantity < 10 THEN
        INSERT INTO Alerts (product_id, branch_id, alert_message, created_at)
        VALUES (NEW.product_id, NEW.branch_id, 'Low stock alert!', NOW());
    END IF;
END $$
DELIMITER ;

CREATE TABLE Alerts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    branch_id INT,
    alert_message TEXT,
    created_at DATETIME,
    FOREIGN KEY (product_id) REFERENCES Products(id),
    FOREIGN KEY (branch_id) REFERENCES Branches(id)
);

-- 4. Audit Logs for Inventory Changes
CREATE TABLE Inventory_Audit (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    branch_id INT,
    old_quantity INT,
    new_quantity INT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_inventory_audit
BEFORE UPDATE ON Inventory
FOR EACH ROW
BEGIN
    INSERT INTO Inventory_Audit (product_id, branch_id, old_quantity, new_quantity)
    VALUES (OLD.product_id, OLD.branch_id, OLD.quantity, NEW.quantity);
END $$
DELIMITER ;

-- 5. Partitioned Tables (for Inventory_Audit - by month)
-- Example with MySQL range partitioning on changed_at
-- Requires using a partitionable storage engine like InnoDB and proper date formatting
-- Optional: use for large-scale systems

-- END OF DATABASE STARTER FILE

# 🏬 Enterprise Inventory Management System (SQL)

This project is a robust **Inventory Management System** designed for a multi-branch retail enterprise, showcasing **senior-level database design** and features including audit logging, stock alerts, and warehouse/store segmentation.

---

## 🔧 Tech Stack

- SQL (MySQL or MariaDB)
- Triggers & Stored Logic
- Partitioning Concepts (Optional for large data volumes)

---

## 📁 Features

### ✅ Core Functionalities
- Product & Category management
- Inventory tracking per branch (store or warehouse)
- Alerts for low stock using `AFTER UPDATE` triggers
- Change logs for every inventory modification
- Scalable schema with partitioning support for audits

### ⚙️ Tables Included
- `Categories`  
- `Products`  
- `Branches`  
- `Inventory`  
- `Alerts`  
- `Inventory_Audit`

---

## 🚀 How to Use

### 1. Clone the Repo
```bash
git clone https://github.com/redbeat3000/enterprise-inventory-system.git
cd enterprise-inventory-system

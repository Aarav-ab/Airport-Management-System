# ✈️ Airport Management System

## 📌 Overview

A simple full-stack web application to manage **flights, airports, and bookings**.
The system is integrated with a MySQL database and ensures **data integrity using constraints**.

---

## 🛠️ Tech Stack

* Frontend: HTML, CSS, JavaScript
* Backend: Node.js, Express
* Database: MySQL

---

## ⚙️ Features

* View and search flights
* View airport details
* Book and cancel tickets
* Check booking status

---

## 🔐 Key Constraints

* **PRIMARY KEY** – Unique records
* **FOREIGN KEY** – Maintains relationships
* **UNIQUE (passenger_id, flight_id)** – Prevents duplicate bookings
* **NOT NULL** – Ensures required data

---

## 🚀 How to Run
1. Open a terminal in `Project code`
2. Run `npm install`
3. Start the server with `npm start`
4. Open `http://localhost:3000` in your browser
---

## 🧪 Testing

* ✔ Valid booking works
* ❌ Duplicate booking blocked
* ❌ Invalid IDs rejected

---

## 🎯 Conclusion

Ensures reliable booking system with proper validation and database constraints.

---
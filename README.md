Salon Appointment Scheduler 💇‍♂️📅

Relational database project built using PostgreSQL and Bash scripting. This project simulates a professional hair salon booking system, managing customers, services, and appointment schedules through an interactive terminal interface.
📌 Project Overview

The system is designed to handle the complete workflow of a service business, ensuring data integrity and a seamless user experience. Key features include:

    Dynamic Customer Registration: Automatically detects new customers by phone number and adds them to the database.

    Interactive Menu: A Bash-driven interface that lists available services and handles user input.

    Relational Logic: Links customers to specific services through an appointments table.

    Data Validation: Uses SQL constraints (NOT NULL, UNIQUE, FOREIGN KEY) to maintain a clean database.

The data follows this logical flow:

Service Selection → Customer Identification → Appointment Scheduling
🗂 Database Structure
Tables

    services: Stores the names of the treatments offered (e.g., Cut, Color, Perm).

    customers: Stores unique client information (name and phone number).

    appointments: The junction table that records who is getting what service and at what time.

Relationships

    A customer can have many appointments.

    A service can be linked to many appointments.

    Each appointment belongs to exactly one customer and one service.

🛠 Technologies Used

    PostgreSQL: For relational data storage and management.

    Bash (Shell Script): For building the interactive CLI (Command Line Interface).

    SQL: For complex queries and data manipulation.

    Git & GitHub: For version control.

💾 Database Dump

The file salon.sql contains the full database structure, including:

    Schema definitions and sequences.

    Constraints and Foreign Key relationships.

    Initial service data.

To rebuild the database and run the script:

    Rebuild the database:
    Bash

    psql -U postgres < salon.sql

    Give execution permissions to the script:
    Bash

    chmod +x salon.sh

    Run the scheduler:
    Bash

    ./salon.sh

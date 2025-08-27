# alx-airbnb-database

# ER Diagram Requirements - AirBnB Database

## Objective
Define the entities, attributes, constraints, and relationships for the **AirBnB Database**.  
This document is the basis for the ER diagram representation.

---

## Entities & Attributes

### **User**
- `user_id`: Primary Key, UUID, Indexed  
- `first_name`: VARCHAR, NOT NULL  
- `last_name`: VARCHAR, NOT NULL  
- `email`: VARCHAR, UNIQUE, NOT NULL  
- `password_hash`: VARCHAR, NOT NULL  
- `phone_number`: VARCHAR, NULL  
- `role`: ENUM (guest, host, admin), NOT NULL  
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

### **Property**
- `property_id`: Primary Key, UUID, Indexed  
- `host_id`: Foreign Key → User(user_id)  
- `name`: VARCHAR, NOT NULL  
- `description`: TEXT, NOT NULL  
- `location`: VARCHAR, NOT NULL  
- `price_per_night`: DECIMAL, NOT NULL  
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
- `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP  

---

### **Booking**
- `booking_id`: Primary Key, UUID, Indexed  
- `property_id`: Foreign Key → Property(property_id)  
- `user_id`: Foreign Key → User(user_id)  
- `start_date`: DATE, NOT NULL  
- `end_date`: DATE, NOT NULL  
- `total_price`: DECIMAL, NOT NULL  
- `status`: ENUM (pending, confirmed, canceled), NOT NULL  
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

### **Payment**
- `payment_id`: Primary Key, UUID, Indexed  
- `booking_id`: Foreign Key → Booking(booking_id)  
- `amount`: DECIMAL, NOT NULL  
- `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
- `payment_method`: ENUM (credit_card, paypal, stripe), NOT NULL  

---

### **Review**
- `review_id`: Primary Key, UUID, Indexed  
- `property_id`: Foreign Key → Property(property_id)  
- `user_id`: Foreign Key → User(user_id)  
- `rating`: INTEGER, CHECK (rating >= 1 AND rating <= 5), NOT NULL  
- `comment`: TEXT, NOT NULL  
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

### **Message**
- `message_id`: Primary Key, UUID, Indexed  
- `sender_id`: Foreign Key → User(user_id)  
- `recipient_id`: Foreign Key → User(user_id)  
- `message_body`: TEXT, NOT NULL  
- `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

## Relationships

- **User ↔ Property**  
  - One user (host) can list many properties.  
  - Each property belongs to one host.  
  - **1:N**

- **User ↔ Booking**  
  - One user (guest) can make many bookings.  
  - Each booking belongs to one user.  
  - **1:N**

- **Property ↔ Booking**  
  - One property can have many bookings.  
  - A booking belongs to one property.  
  - **1:N**

- **Booking ↔ Payment**  
  - Each booking can have one or more payments.  
  - **1:N**

- **User ↔ Review**  
  - A user can write many reviews.  
  - Each review belongs to one user.  
  - **1:N**

- **Property ↔ Review**  
  - A property can have many reviews.  
  - A review belongs to one property.  
  - **1:N**

- **Booking ↔ Review**  
  - Each booking may have one review (optional).  
  - **1:1 (optional)**

- **User ↔ Message**  
  - A user can send and receive many messages.  
  - Each message has one sender and one recipient.  
  - **1:N (self-referencing)**

---

## Constraints

- **User Table**  
  - Unique constraint on `email`.  
  - Non-null constraints on required fields.  

- **Property Table**  
  - Foreign key constraint on `host_id`.  
  - Non-null constraints on essential attributes.  

- **Booking Table**  
  - Foreign key constraints on `property_id` and `user_id`.  
  - `status` must be one of *pending, confirmed, canceled*.  

- **Payment Table**  
  - Foreign key constraint on `booking_id`.  
  - Ensures payments are linked to valid bookings.  

- **Review Table**  
  - Constraint on `rating` values (1–5).  
  - Foreign key constraints on `property_id` and `user_id`.  

- **Message Table**  
  - Foreign key constraints on `sender_id` and `recipient_id`.  

---

## Indexing

- Primary Keys: Indexed automatically.  
- Additional Indexes:  
  - `email` in **User** table.  
  - `property_id` in **Property** and **Booking** tables.  
  - `booking_id` in **Booking** and **Payment** tables.  

---

## Directory Structure



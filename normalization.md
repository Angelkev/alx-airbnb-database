# Database Normalization - AirBnB Database

## Objective
Ensure the AirBnB database schema adheres to **Third Normal Form (3NF)** to remove redundancy, ensure data integrity, and simplify maintenance.

---

## Step 1: First Normal Form (1NF)

**Rule:** Eliminate repeating groups; ensure atomic values.

- All attributes in the schema are **atomic** (no multi-valued or repeating groups).  
  - Example: `email`, `phone_number`, `password_hash` are single-valued.  
  - No arrays or composite attributes exist in the tables.  

✅ The schema is in **1NF**.

---

## Step 2: Second Normal Form (2NF)

**Rule:** Eliminate partial dependencies (non-key attributes must depend on the whole primary key).

- All primary keys are **single-column UUIDs** (`user_id`, `property_id`, `booking_id`, etc.).  
- No non-key attribute depends on only part of a composite key (since no composite PKs are used).  

✅ The schema is in **2NF**.

---

## Step 3: Third Normal Form (3NF)

**Rule:** Eliminate transitive dependencies (non-key attributes must depend only on the key, not on other non-key attributes).

- **User Table**  
  - `email` is unique and depends only on `user_id`.  
  - `role`, `first_name`, `last_name` depend only on `user_id`.  
  - No transitive dependency exists.  

- **Property Table**  
  - `host_id` is a foreign key referencing `User`.  
  - `name`, `description`, `location`, `price_per_night` depend only on `property_id`.  
  - `updated_at` depends only on `property_id`.  
  - No attributes depend on non-key attributes.  

- **Booking Table**  
  - `total_price` could potentially be a derived attribute (`price_per_night × duration`), but storing it improves performance.  
  - All attributes (`status`, `start_date`, `end_date`) depend only on `booking_id`.  
  - No transitive dependencies.  

- **Payment Table**  
  - `amount`, `payment_method`, `payment_date` depend only on `payment_id`.  
  - Linked correctly to `Booking`.  
  - No redundancy.  

- **Review Table**  
  - `rating` and `comment` depend only on `review_id`.  
  - Linked to `User` and `Property` via FKs.  
  - Constraint ensures `rating` stays between 1 and 5.  
  - No transitive dependencies.  

- **Message Table**  
  - `message_body` and `sent_at` depend only on `message_id`.  
  - `sender_id` and `recipient_id` are proper foreign keys.  
  - No redundancy.  

✅ The schema is in **3NF**.

---

## Notes on Design Choices

- `total_price` in **Booking** is technically a derived value. While this slightly denormalizes the schema, it is a common **practical optimization** for performance (avoids recalculation on every query).  
- No multi-valued attributes exist.  
- All tables are fully normalized without transitive dependencies.  

---

## Conclusion
The AirBnB database schema meets the requirements of **Third Normal Form (3NF)**.  
No further normalization is required, except for possible optimization trade-offs (like keeping `total_price` for efficiency).  

---

## Directory Structure


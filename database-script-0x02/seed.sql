-- seed.sql (PostgreSQL sample data)
-- Inserts rely on defaults that generate UUIDs.

-- Users (hosts and guests)
INSERT INTO users (first_name,last_name,email,password_hash,phone_number,role) VALUES
('Alice','Johnson','alice@example.com','$2b$hash_example','+234700000001','host'),
('Bob','Smith','bob@example.com','$2b$hash_example','+234700000002','guest'),
('Carol','Adams','carol@example.com','$2b$hash_example','+234700000003','guest');

-- Properties (host_id resolved via subquery)
INSERT INTO properties (host_id,name,description,location,pricepernight) VALUES
(
  (SELECT user_id FROM users WHERE email='alice@example.com'),
  'Cozy Lagos Apartment',
  'A comfy 2BR apartment close to Lekki',
  'Lekki, Lagos, Nigeria',
  45.00
),
(
  (SELECT user_id FROM users WHERE email='alice@example.com'),
  'Beachfront Bungalow',
  'Bungalow with direct beach access and BBQ area',
  'Epe, Lagos, Nigeria',
  90.00
);

-- Bookings
INSERT INTO bookings (property_id,user_id,start_date,end_date,total_price,status) VALUES
(
  (SELECT property_id FROM properties WHERE name='Cozy Lagos Apartment'),
  (SELECT user_id FROM users WHERE email='bob@example.com'),
  '2025-09-10','2025-09-14', 180.00, 'confirmed'
),
(
  (SELECT property_id FROM properties WHERE name='Beachfront Bungalow'),
  (SELECT user_id FROM users WHERE email='carol@example.com'),
  '2025-10-01','2025-10-05', 360.00, 'pending'
);

-- Payments
INSERT INTO payments (booking_id,amount,payment_method) VALUES
(
  (SELECT booking_id FROM bookings WHERE total_price = 180.00 LIMIT 1),
  180.00, 'credit_card'
);

-- Reviews
INSERT INTO reviews (property_id,user_id,rating,comment) VALUES
(
  (SELECT property_id FROM properties WHERE name='Cozy Lagos Apartment'),
  (SELECT user_id FROM users WHERE email='bob@example.com'),
  5, 'Great stay, clean and central.'
);

-- Messages
INSERT INTO messages (sender_id,recipient_id,message_body) VALUES
(
  (SELECT user_id FROM users WHERE email='bob@example.com'),
  (SELECT user_id FROM users WHERE email='alice@example.com'),
  'Hi Alice — is the apartment available for early check-in?'
);

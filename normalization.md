# Normalization Notes (to 3NF)

## Goal
Bring the schema to Third Normal Form (3NF): 
- 1NF: atomic values per field
- 2NF: no partial dependency on part of a composite PK
- 3NF: no transitive dependencies (non-key → non-key)

## Starting point (common issues)
- Repeating groups (multiple image URLs in one column) → split into `property_images`.
- Multiple amenities per property stored as comma list → split into `amenities` + `property_amenities`.
- Redundant owner contact info repeated across properties → keep contact in `users`.

## Changes applied (summary)
1. `users` table contains each user once (PK: `id`).
2. `properties` references owner via `owner_id` (FK → `users.id`).
3. Multi-valued attributes moved to separate tables:
   - `property_images` (one image row per image),
   - `amenities` + `property_amenities` (many-to-many).
4. `bookings` links `users` and `properties`; `payments` references `bookings`.
5. `reviews` linked to `bookings` and `users` to avoid orphan reviews.

## Why this is 3NF
- All non-key columns depend on the primary key of their table (no partial/transitive dependencies).
- No multi-value attributes or comma-separated lists remain.


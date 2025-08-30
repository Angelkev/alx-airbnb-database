# Normalization to 3NF — AirBnB schema

## Goal
Bring the database design to Third Normal Form (3NF):
- 1NF: each column holds atomic values (no lists / CSV in a column).
- 2NF: no partial dependency on a composite primary key.
- 3NF: no transitive dependency (non-key → non-key).

## What we checked and fixed
1. **Multi-valued attributes**  
   - If a property had multiple images or amenities, they must be in separate tables (e.g., `property_images`, `amenities`) rather than comma lists. (This repo's schema leaves space for those auxiliary tables if needed.)
2. **No partial/transitive dependencies**  
   - Each table’s non-key columns depend only on that table’s primary key (e.g., `pricepernight` is specific to `properties`, not stored redundantly in `bookings`).
3. **Use of UUID PKs**  
   - Primary keys are UUIDs (stable across distributed systems). Non-key columns do not contain identifying info for other entities.
4. **Enums and constraints**  
   - `role`, `status`, and `payment_method` are constrained via ENUM types to avoid invalid data.
5. **Referential integrity**  
   - Foreign keys are declared between entities. Deletion/update rules are chosen to reduce orphaned rows (see schema comments).

## Result
- The schema is in 3NF: no repeating groups, no partial keys, and no transitive dependencies among non-key attributes.
- Any future many-to-many additions (property ↔ amenity) should be implemented with join tables, preserving 3NF.

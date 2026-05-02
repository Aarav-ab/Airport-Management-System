# Airport Management System Frontend

This frontend now fetches live data from a local backend API and supports database validation for ticket bookings.

## Contents

- `index.html` — main UI for viewing flights, airports, airlines, passengers, tickets, and feedback
- `styles.css` — responsive styling for cards, tables, and forms
- `data.js` — helper functions for rendering data
- `script.js` — API fetch logic, rendering, and ticket creation

## How to run

1. Open a terminal in `Project code`
2. Run `npm install`
3. Start the server with `npm start`
4. Open `http://localhost:3000` in your browser

## Database configuration

The backend uses the following defaults:

- `DB_HOST=localhost`
- `DB_USER=root`
- `DB_PASSWORD=` (blank by default)
- `DB_NAME=airport_management_system`

If your MySQL credentials differ, set the environment variables before running the server.

## API endpoints used

- `GET /api/airports`
- `GET /api/airlines`
- `GET /api/flights`
- `GET /api/fares`
- `GET /api/passengers`
- `GET /api/tickets`
- `GET /api/feedback`
- `POST /api/tickets`
- `GET /api/test/duplicate-booking`
- `GET /api/test/invalid-booking`

## Notes

- The backend now connects to MySQL and returns JSON error responses for constraint failures.
- Duplicate passenger-flight bookings are rejected by a database UNIQUE index.
- Invalid flight or passenger IDs return a clean JSON error.
- Use `db_constraints.sql` to apply the database constraint and trigger changes.

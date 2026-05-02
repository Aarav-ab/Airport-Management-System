const express = require("express");
const mysql = require("mysql2/promise");
const path = require("path");
const app = express();
const port = process.env.PORT || 3000;

const dbConfig = {
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "airport_management_system",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
};

const pool = mysql.createPool(dbConfig);

async function query(sql, params = []) {
  const [rows] = await pool.query(sql, params);
  return rows;
}

function parseSqlError(err) {
  if (!err) {
    return { status: 500, body: { error: "Unknown database error" } };
  }

  if (err.code === "ER_DUP_ENTRY") {
    return {
      status: 409,
      body: { error: "Duplicate booking not allowed" },
    };
  }

  if (
    err.code === "ER_NO_REFERENCED_ROW_2" ||
    err.code === "ER_NO_REFERENCED_ROW"
  ) {
    return {
      status: 400,
      body: { error: "Invalid flight or passenger" },
    };
  }

  if (err.code === "ER_SIGNAL_EXCEPTION") {
    return {
      status: 400,
      body: { error: err.sqlMessage || "Constraint violation" },
    };
  }

  return {
    status: 500,
    body: { error: "Database error", detail: err.sqlMessage || err.message },
  };
}

function logSqlError(err, context) {
  console.error("[DB ERROR]", context, {
    code: err.code,
    errno: err.errno,
    sqlState: err.sqlState,
    sqlMessage: err.sqlMessage,
    message: err.message,
  });
}

app.use(express.json());
app.use(express.static(path.join(__dirname, "frontend")));

app.get("/api/airports", async (req, res) => {
  try {
    const rows = await query(
      "SELECT Code AS code, Name AS name, Location AS location FROM AIRPORT",
    );
    res.json(rows);
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/airports");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("/api/airlines", async (req, res) => {
  try {
    const rows = await query(
      "SELECT A_Code AS code, Airline_Name AS name, Rating AS rating FROM AIRLINES",
    );
    res.json(rows);
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/airlines");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("/api/flights", async (req, res) => {
  try {
    const rows = await query(
      "SELECT Flight_ID AS id, Source AS source, Destination AS destination, Time_On AS date, Uses AS airplane FROM FLIGHT",
    );
    res.json(rows);
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/flights");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("/api/fares", async (req, res) => {
  try {
    const rows = await query(
      "SELECT Flight_ID AS flightId, Amount AS amount, Charges AS charges FROM FARE",
    );
    res.json(rows);
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/fares");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("/api/passengers", async (req, res) => {
  try {
    const rows = await query(
      "SELECT PID AS id, Name AS name, Gender AS gender, Age AS age, Email AS email, Contact AS contact FROM PASSENGER",
    );
    res.json(rows);
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/passengers");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("/api/tickets", async (req, res) => {
  try {
    const rows = await query(
      "SELECT Ticket_ID AS ticketId, Flight_ID AS flightId, PID AS pid, Booking_Date AS bookingDate, Mode_of_Booking AS mode FROM TICKET",
    );
    res.json(rows);
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/tickets");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("/api/feedback", async (req, res) => {
  try {
    const rows = await query(
      "SELECT Fbk_ID AS id, PID AS pid, Flight_ID AS flightId, Message AS message, Email AS email FROM FEEDBACK",
    );
    res.json(rows);
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/feedback");
    res.status(errResp.status).json(errResp.body);
  }
});

app.post("/api/tickets", async (req, res) => {
  const { ticketId, flightId, pid, bookingDate, mode } = req.body;

  if (!ticketId || !flightId || !pid || !bookingDate || !mode) {
    return res.status(400).json({ error: "Missing ticket fields" });
  }

  try {
    await query(
      "INSERT INTO TICKET (Ticket_ID, Flight_ID, PID, Booking_Date, Mode_of_Booking) VALUES (?, ?, ?, ?, ?)",
      [ticketId, flightId, pid, bookingDate, mode],
    );

    res.status(201).json({ ticketId, flightId, pid, bookingDate, mode });
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "POST /api/tickets");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("/api/test/duplicate-booking", async (req, res) => {
  const ticket = {
    ticketId: 999900,
    flightId: 101,
    pid: 1,
    bookingDate: new Date().toISOString().slice(0, 10),
    mode: "Online",
  };

  try {
    await query(
      "INSERT INTO TICKET (Ticket_ID, Flight_ID, PID, Booking_Date, Mode_of_Booking) VALUES (?, ?, ?, ?, ?)",
      [
        ticket.ticketId,
        ticket.flightId,
        ticket.pid,
        ticket.bookingDate,
        ticket.mode,
      ],
    );
    res.json({ success: true, ticket });
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/test/duplicate-booking");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("/api/test/invalid-booking", async (req, res) => {
  const ticket = {
    ticketId: 999901,
    flightId: 9999,
    pid: 9999,
    bookingDate: new Date().toISOString().slice(0, 10),
    mode: "Online",
  };

  try {
    await query(
      "INSERT INTO TICKET (Ticket_ID, Flight_ID, PID, Booking_Date, Mode_of_Booking) VALUES (?, ?, ?, ?, ?)",
      [
        ticket.ticketId,
        ticket.flightId,
        ticket.pid,
        ticket.bookingDate,
        ticket.mode,
      ],
    );
    res.json({ success: true, ticket });
  } catch (error) {
    const errResp = parseSqlError(error);
    logSqlError(error, "GET /api/test/invalid-booking");
    res.status(errResp.status).json(errResp.body);
  }
});

app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "frontend", "index.html"));
});

(async function verifyConnection() {
  try {
    const connection = await pool.getConnection();
    connection.release();
    console.log("Connected to MySQL database:", dbConfig.database);
  } catch (error) {
    console.error("Unable to connect to MySQL database.", error);
    process.exit(1);
  }
})();

app.listen(port, () => {
  console.log(`Airport management backend running on http://localhost:${port}`);
});

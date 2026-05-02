let airports = [];
let airlines = [];
let flights = [];
let fares = [];
let passengers = [];
let tickets = [];
let feedbackList = [];

const sections = document.querySelectorAll(".section");
const navButtons = document.querySelectorAll(".top-nav button");
const flightsBody = document.getElementById("flightsTableBody");
const airportsBody = document.getElementById("airportsTableBody");
const airlinesBody = document.getElementById("airlinesTableBody");
const passengersBody = document.getElementById("passengersTableBody");
const ticketsBody = document.getElementById("ticketsTableBody");
const feedbackBody = document.getElementById("feedbackTableBody");
const totalFlights = document.getElementById("totalFlights");
const totalAirports = document.getElementById("totalAirports");
const totalAirlines = document.getElementById("totalAirlines");
const totalPassengers = document.getElementById("totalPassengers");
const sourceFilter = document.getElementById("sourceFilter");
const destinationFilter = document.getElementById("destinationFilter");
const sourceFilterFlights = document.getElementById("sourceFilterFlights");
const destinationFilterFlights = document.getElementById(
  "destinationFilterFlights",
);
const ticketMessage = document.getElementById("ticketMessage");

function showSection(sectionId) {
  sections.forEach((section) => {
    section.classList.toggle("active-section", section.id === sectionId);
  });
  navButtons.forEach((button) => {
    button.classList.toggle("active", button.dataset.section === sectionId);
  });
}

function fillSelect(select, values) {
  select.innerHTML =
    '<option value="">All</option>' +
    values
      .map((value) => `<option value="${value}">${value}</option>`)
      .join("");
}

function renderDashboard() {
  totalFlights.textContent = flights.length;
  totalAirports.textContent = airports.length;
  totalAirlines.textContent = airlines.length;
  totalPassengers.textContent = passengers.length;
}

function renderFlights(list = flights) {
  flightsBody.innerHTML = list
    .map((flight) => {
      const source = getAirportName(flight.source);
      const destination = getAirportName(flight.destination);
      const airplane = flight.airplane;
      const fare = getFareForFlight(flight.id);
      return `
            <tr>
                <td>${flight.id}</td>
                <td>${source}</td>
                <td>${destination}</td>
                <td>${flight.date}</td>
                <td>${airplane}</td>
                <td>${fare}</td>
            </tr>
        `;
    })
    .join("");
}

function renderAirports() {
  airportsBody.innerHTML = airports
    .map(
      (airport) => `
        <tr>
            <td>${airport.code}</td>
            <td>${airport.name}</td>
            <td>${airport.location}</td>
        </tr>
    `,
    )
    .join("");
}

function renderAirlines() {
  airlinesBody.innerHTML = airlines
    .map(
      (airline) => `
        <tr>
            <td>${airline.code}</td>
            <td>${airline.name}</td>
            <td>${airline.rating}</td>
        </tr>
    `,
    )
    .join("");
}

function renderPassengers() {
  passengersBody.innerHTML = passengers
    .map(
      (passenger) => `
        <tr>
            <td>${passenger.id}</td>
            <td>${passenger.name}</td>
            <td>${passenger.gender}</td>
            <td>${passenger.age}</td>
            <td>${passenger.email}</td>
            <td>${passenger.contact}</td>
        </tr>
    `,
    )
    .join("");
}

function renderTickets() {
  ticketsBody.innerHTML = tickets
    .map(
      (ticket) => `
        <tr>
            <td>${ticket.ticketId}</td>
            <td>${getPassengerName(ticket.pid)}</td>
            <td>${ticket.flightId}</td>
            <td>${ticket.bookingDate}</td>
            <td>${ticket.mode}</td>
        </tr>
    `,
    )
    .join("");
}

function renderFeedback() {
  feedbackBody.innerHTML = feedbackList
    .map(
      (item) => `
        <tr>
            <td>${item.id}</td>
            <td>${getPassengerName(item.pid)}</td>
            <td>${item.flightId}</td>
            <td>${item.message}</td>
            <td>${item.email}</td>
        </tr>
    `,
    )
    .join("");
}

function populateFilters() {
  const airportCodes = airports.map((a) => a.code);
  fillSelect(sourceFilter, airportCodes);
  fillSelect(destinationFilter, airportCodes);
  fillSelect(sourceFilterFlights, airportCodes);
  fillSelect(destinationFilterFlights, airportCodes);
}

function filterFlights(source, destination) {
  return flights.filter((flight) => {
    const matchesSource = source ? flight.source === source : true;
    const matchesDestination = destination
      ? flight.destination === destination
      : true;
    return matchesSource && matchesDestination;
  });
}

function clearTicketMessage() {
  ticketMessage.textContent = "";
  ticketMessage.className = "message hidden";
  ticketMessage.hidden = true;
}

function showTicketMessage(message, type = "error") {
  ticketMessage.textContent = message;
  ticketMessage.className = `message ${type}`;
  ticketMessage.hidden = false;
}

function initEvents() {
  document.querySelectorAll(".top-nav button").forEach((button) => {
    button.addEventListener("click", () => showSection(button.dataset.section));
  });

  document.getElementById("flightSearchBtn").addEventListener("click", () => {
    const filtered = filterFlights(sourceFilter.value, destinationFilter.value);
    renderFlights(filtered);
    showSection("flights");
  });

  document.getElementById("flightResetBtn").addEventListener("click", () => {
    sourceFilter.value = "";
    destinationFilter.value = "";
    renderFlights();
  });

  document.getElementById("searchFlightsBtn").addEventListener("click", () => {
    const filtered = filterFlights(
      sourceFilterFlights.value,
      destinationFilterFlights.value,
    );
    renderFlights(filtered);
  });

  document.getElementById("resetFlightsBtn").addEventListener("click", () => {
    sourceFilterFlights.value = "";
    destinationFilterFlights.value = "";
    renderFlights();
  });

  document
    .getElementById("ticketForm")
    .addEventListener("submit", async (event) => {
      event.preventDefault();
      clearTicketMessage();
      const newTicket = {
        ticketId: Number(document.getElementById("ticketId").value),
        pid: Number(document.getElementById("ticketPid").value),
        flightId: Number(document.getElementById("ticketFlightId").value),
        bookingDate: document.getElementById("ticketDate").value,
        mode: document.getElementById("ticketMode").value,
      };

      const response = await fetch("/api/tickets", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(newTicket),
      });

      if (!response.ok) {
        const error = await response
          .json()
          .catch(() => ({ error: "Unable to save ticket" }));
        const message = error.error || "Unable to save ticket";
        showTicketMessage(message, "error");
        return;
      }

      const createdTicket = await response.json();
      tickets.push(createdTicket);
      renderTickets();
      event.target.reset();
      showTicketMessage("Ticket added successfully.", "success");
    });
}

async function fetchData() {
  const endpoints = [
    "airports",
    "airlines",
    "flights",
    "fares",
    "passengers",
    "tickets",
    "feedback",
  ];
  const results = await Promise.all(
    endpoints.map((endpoint) =>
      fetch(`/api/${endpoint}`).then((res) => res.json()),
    ),
  );

  [airports, airlines, flights, fares, passengers, tickets, feedbackList] =
    results;
}

async function initApp() {
  try {
    await fetchData();
  } catch (error) {
    alert(
      "Unable to load data from the backend. Make sure the server is running.",
    );
    console.error(error);
    return;
  }

  populateFilters();
  renderDashboard();
  renderFlights();
  renderAirports();
  renderAirlines();
  renderPassengers();
  renderTickets();
  renderFeedback();
  initEvents();
}

document.addEventListener("DOMContentLoaded", initApp);

function getAirportName(code) {
  const airport = airports.find((a) => a.code === code);
  return airport ? `${airport.code} — ${airport.name}` : code;
}

function getPassengerName(pid) {
  const passenger = passengers.find((p) => p.id === pid);
  return passenger ? passenger.name : `PID ${pid}`;
}

function getAirlineName(code) {
  const airline = airlines.find((a) => a.code === code);
  return airline ? airline.name : code;
}

function getFareForFlight(flightId) {
  const fare = fares.find((f) => f.flightId === flightId);
  if (!fare) return "N/A";
  return `₹${fare.amount + fare.charges}`;
}

const express = require("express");

const app = express();
app.use(express.json());

let nextId = 3;
const shipments = [
  { id: 1, trackingNumber: "ST-1001", destination: "Mumbai", status: "in_transit" },
  { id: 2, trackingNumber: "ST-1002", destination: "Bengaluru", status: "delivered" }
];

app.get("/health", (_request, response) => {
  response.status(200).json({ status: "ok", service: "shiptrack" });
});

app.get("/shipments", (_request, response) => {
  response.json({ data: shipments });
});

app.get("/shipments/:id", (request, response) => {
  const shipment = shipments.find((item) => item.id === Number(request.params.id));
  if (!shipment) return response.status(404).json({ error: "Shipment not found" });
  return response.json({ data: shipment });
});

app.post("/shipments", (request, response) => {
  const { trackingNumber, destination } = request.body;
  if (!trackingNumber || !destination) {
    return response.status(400).json({ error: "trackingNumber and destination are required" });
  }

  const shipment = { id: nextId++, trackingNumber, destination, status: "created" };
  shipments.push(shipment);
  return response.status(201).json({ data: shipment });
});

module.exports = app;

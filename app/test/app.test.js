const test = require("node:test");
const assert = require("node:assert/strict");
const request = require("supertest");
const app = require("../src/app");

test("GET /health reports a healthy service", async () => {
  const response = await request(app).get("/health");
  assert.equal(response.status, 200);
  assert.equal(response.body.status, "ok");
});

test("GET /shipments returns shipment data", async () => {
  const response = await request(app).get("/shipments");
  assert.equal(response.status, 200);
  assert.ok(response.body.data.length >= 2);
});

test("POST /shipments validates required fields", async () => {
  const response = await request(app).post("/shipments").send({ trackingNumber: "ST-2000" });
  assert.equal(response.status, 400);
});

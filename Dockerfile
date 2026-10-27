# Build a small production image for the API.
FROM node:20-alpine AS dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000
COPY --from=dependencies /app/node_modules ./node_modules
COPY app ./app
USER node
EXPOSE 3000
CMD ["node", "app/src/server.js"]

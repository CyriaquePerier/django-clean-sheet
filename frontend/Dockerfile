# --- Common base ---
FROM node:20-slim AS base
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# --- Stage 1: local dev ---
FROM base AS dev
EXPOSE 5173
CMD ["npx", "vite", "--host", "0.0.0.0"]

# --- Stage 2: Builder ---
FROM base AS builder
EXPOSE 5173
RUN npm run build

# --- Stage 3: Prod ---
FROM nginx:alpine AS prod
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
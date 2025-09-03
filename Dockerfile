# syntax=docker/dockerfile:1

########### Builder ###########
FROM node:20-bookworm AS builder
WORKDIR /app

# Prisma requiere OpenSSL en build
RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

# Dependencias
COPY package*.json ./
RUN npm ci

# Prisma client
COPY prisma ./prisma
RUN npx prisma generate

# Código
COPY . .

# Si el proyecto es TypeScript, compila a /dist
# (si no existe script build, no falla el deploy por esto)
RUN npm run build || echo "No build step found, continuing..."

########### Runtime ###########
FROM node:20-bookworm
WORKDIR /app

# OpenSSL para Prisma en runtime
RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production
ENV PORT=3000

# Solo deps de producción
COPY package*.json ./
RUN npm ci --omit=dev --no-audit --no-fund

# Artefactos y prisma
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma
COPY . .

EXPOSE 3000

# Usa el start del package.json (recomendado que apunte a dist)
# Ej.: "start": "node dist/main.js"
CMD ["npm", "start"]


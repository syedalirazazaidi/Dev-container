# ---- Step 1: Build the Gatsby site ----
FROM node:20.11.0-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm install

# Copy project files and build
COPY . .
RUN npm run build


# ---- Step 2: Serve with gatsby serve ----
FROM node:20.11.0-alpine

# Install serve globally
RUN npm install -g serve

WORKDIR /app

# Copy only the built files from builder
COPY --from=builder /app/public ./public

# Expose Gatsby's default serve port
EXPOSE 8000

# Serve the static site
CMD ["serve", "-s", "public", "-l", "9000"]

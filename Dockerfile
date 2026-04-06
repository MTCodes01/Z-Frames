# Base image
FROM node:20-slim

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    pkg-config \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY package*.json ./
RUN npm install --omit=dev && \
    npm cache clean --force

# Copy project
COPY . .

# Move existing data into a single data directory for volume persistence
RUN mkdir -p data/image && \
    mv image/* data/image/ 2>/dev/null || true && \
    mv database.sqlite data/database.sqlite 2>/dev/null || true && \
    rm -rf image/

# Expose port
EXPOSE 3000

# Start server
CMD ["node", "server.js"]

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

# Ensure image directory exists
RUN mkdir -p image

# Expose port
EXPOSE 3000

# Start server
CMD ["node", "server.js"]

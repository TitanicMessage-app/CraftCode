# Use an official Node.js runtime as a parent image
FROM node:18

# Install system dependencies and set npm to the latest version
RUN apt-get update && \
    apt-get install -y \
    libcairo2-dev \
    libjpeg-dev \
    libpango1.0-dev \
    libgif-dev \
    build-essential \
    g++ \
    pkg-config && \
    npm install -g npm@latest && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy all application files
COPY . /app

# Verify all files are copied
RUN ls -R /app

# Build the project (if required)
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Set the command to start the application
CMD ["node", "./dev-server/index.js"]

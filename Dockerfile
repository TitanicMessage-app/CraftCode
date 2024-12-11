# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Ensure npm is installed and usable, verify Node.js environment
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

# Copy package files and install dependencies
COPY package*.json ./

# Clear npm cache to prevent stale packages
RUN npm cache clean --force && \
    npm install

# Install missing dependencies like express-http-proxy
RUN npm install express-http-proxy canvas

# Copy all application files
COPY . .

# Build the project (if required)
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the app
CMD ["npm", "start"]

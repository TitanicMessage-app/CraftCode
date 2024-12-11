# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Install dependencies for canvas module (cairo, pixman, etc.)
RUN apt-get update && \
    apt-get install -y \
    libcairo2-dev \
    libjpeg-dev \
    libpango1.0-dev \
    libgif-dev \
    build-essential \
    g++ \
    pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Clear npm cache and remove existing node_modules (if any)
RUN npm cache clean --force

# Copy the current directory contents into the container at /app
COPY . /app

# Install all dependencies from package.json
RUN npm install

# Install express-http-proxy
RUN npm install express-http-proxy

# Expose the port your app runs on (optional, but useful for Koyeb)
EXPOSE 3000

# Define the command to run your app
CMD ["npm", "start"]

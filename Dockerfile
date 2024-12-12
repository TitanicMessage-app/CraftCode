# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

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

# Copy package files and install dependencies
COPY package*.json ./

# Install node dependencies
RUN npm install --legacy-peer-deps
# Copy all application files
COPY . .

# Verify files are copied (Optional for debugging)
RUN ls -R /app

# Run npm audit fix to resolve vulnerabilities automatically
RUN npm audit fix --force

RUN npm run build --force

RUN npm start

# Run the translation process
RUN npm run translate

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]

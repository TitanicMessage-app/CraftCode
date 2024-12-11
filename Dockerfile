# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed dependencies
RUN npm install

# Expose the port your app runs on (optional, but useful for Koyeb)
EXPOSE 3000

# Define the command to run your app
CMD ["npm", "start"]

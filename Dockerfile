# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed dependencies
RUN npm install

# Make your app available on the required port (usually 3000 for Node apps)
EXPOSE 3000

# Run the app
CMD ["npm", "start"]

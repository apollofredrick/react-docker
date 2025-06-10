FROM node:18-alpine AS builder
# Use a lightweight Node.js image for building the application
# Use the official Node.js image as the base image
WORKDIR /app
# Set the working directory inside the container

COPY package*.json ./
# Copy package.json and package-lock.json to the working directory
# This allows us to install dependencies before copying the rest of the application code

RUN npm install
# Install the dependencies defined in package.json
# This will create a node_modules directory with all the dependencies

COPY . .
# Copy the rest of the application code to the working directory
# This includes the source code, configuration files, etc.

RUN npm run build
# Build the application using the build script defined in package.json
# This will create a production-ready build of the application

RUN npm install -g serve
# Install the serve package globally to serve the built application

EXPOSE 5173
# Expose port 5173 for the application to be accessible from outside the container

CMD ["serve", "-s", "dist", "-l", "5173"]
# Start the application using serve, serving the built files from the dist directory on port 5173
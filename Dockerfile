# Stage 1: Build stage
FROM node:18 AS build

# Set the working directory
WORKDIR /testapp

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build your application (if needed, e.g., transpiling TypeScript or bundling)
#  RUN npm run build

# Stage 2: Production stage
FROM node:18-slim

# Set the working directory
WORKDIR /testapp

# Copy only the necessary files from the build stage
COPY --from=build /testapp /testapp

# Expose the necessary port
EXPOSE 3000

# Run the application
CMD ["npm", "start"]





# FROM node

# WORKDIR /testapp

# COPY . .

# RUN npm install

# EXPOSE 3000

# ENTRYPOINT ["npm", "start"]
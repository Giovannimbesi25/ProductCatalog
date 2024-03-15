FROM node:21 

WORKDIR /app
# Copy package.json and package-lock.json to the container
COPY package*.json .
# Install dependencies
RUN npm install
# Copy the rest of the application code
COPY . .
# Build the React app
RUN npm run build

#Expose port 3000 (or any other port your app is configured to run on)
EXPOSE 3000

# Start the React app
CMD ["npm", "start"]


# # Build stage
# FROM node:21 AS build

# WORKDIR /app

# # Copy package.json and package-lock.json to the container
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Build the React app
# RUN npm run build

# # Serve stage
# FROM nginx:1.25.1

# # Copy the custom nginx.conf file to the container
# COPY .docker/nginx.conf /etc/nginx/nginx.conf

# # Copy the built React app from the build stage to the nginx container
# COPY --from=build /app/build /usr/share/nginx/html

# # Expose port 80
# EXPOSE 80

# # Start Nginx
# CMD ["nginx", "-g", "daemon off;"]
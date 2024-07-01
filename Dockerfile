# Use an official Node runtime as a parent image
FROM node:22.2.0 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular application
RUN npm run build --prod

# Use NGINX to serve the Angular application
FROM nginx:alpine
COPY --from=build /app/dist/forRailway/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

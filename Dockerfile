# Use NGINX base image
FROM nginx:alpine

# Copy build artifacts to NGINX html directory
COPY ./build /usr/share/nginx/html

# Copy nginx configuration file if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Command to start NGINX
CMD ["nginx", "-g", "daemon off;"]

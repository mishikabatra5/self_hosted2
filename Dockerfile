# Dockerfile for nginx server
FROM nginx:latest

# Copy your static files into the nginx html directory
COPY ./path/to/your/static/files /usr/share/nginx/html

# Expose port 80
EXPOSE 80

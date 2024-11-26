FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/

# Create directories for static and media files
RUN mkdir -p /usr/share/nginx/html/static \
    && mkdir -p /usr/share/nginx/html/media

# Set proper permissions
RUN chown -R nginx:nginx /usr/share/nginx/html
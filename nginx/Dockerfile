FROM nginx:stable-alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Create necessary directories
RUN mkdir -p /usr/share/nginx/html/static \
    && mkdir -p /usr/share/nginx/html/media \
    && chown -R nginx:nginx /usr/share/nginx/html

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=gutendex.settings

WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        gcc \
        python3-dev \
        libpq-dev \
        build-essential \
        rsync \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories including catalog structure
RUN mkdir -p /app/staticfiles /app/static /app/media \
    && mkdir -p /app/catalog_files/tmp/cache/epub

# Clean up any existing static files
RUN rm -rf /app/staticfiles/* /app/static/* /app/media/*

# Copy requirements first for better caching
COPY project/requirements.txt .

# Upgrade pip and install requirements with verbose output
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -v -r requirements.txt

# Copy entrypoint script and make it executable
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Copy application code
COPY project/ .

# Clean up static files again after copying project files
RUN rm -rf /app/staticfiles/* /app/static/*

# Ensure proper permissions for catalog files directory
RUN chown -R root:root /app/catalog_files && \
    chmod -R 755 /app/catalog_files

ENTRYPOINT ["/app/entrypoint.sh"]

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
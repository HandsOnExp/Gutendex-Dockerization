FROM python:3.9-slim

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
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /app/staticfiles /app/static /app/media

# Clean up any existing static files
RUN rm -rf /app/staticfiles/* /app/static/* /app/media/*

# Copy requirements first for better caching
COPY project/requirements.txt .

# Upgrade pip and install requirements with verbose output
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -v -r requirements.txt

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

COPY project/ .

# Clean up static files again after copying project files
# This ensures no stale static files remain
RUN rm -rf /app/staticfiles/* /app/static/*

ENTRYPOINT ["/app/entrypoint.sh"]

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
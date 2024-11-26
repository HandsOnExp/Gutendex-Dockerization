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
    && rm -rf /var/lib/apt/lists/*

COPY project/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
COPY project/ .

ENTRYPOINT ["/app/entrypoint.sh"]
# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

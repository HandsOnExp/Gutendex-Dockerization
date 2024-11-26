#!/bin/bash
set -e

# Wait for postgres
until PGPASSWORD=$DATABASE_PASSWORD psql -h "$DATABASE_HOST" -U "$DATABASE_USER" -d "$DATABASE_NAME" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 2
done

echo "PostgreSQL is available"

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Update catalog if needed
if [ ! -d "catalog_files" ] || [ "$UPDATE_CATALOG" = "true" ]; then
    echo "Updating catalog..."
    python manage.py updatecatalog
fi

# Execute the main command
exec "$@"
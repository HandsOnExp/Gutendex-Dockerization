#!/bin/bash
set -e

# Environment variables that should be passed to the container:
# POSTGRES_DB (optional, default: gutendex)
# POSTGRES_USER (optional, default: gutendex)
# POSTGRES_PASSWORD (required)

# Use default values if not provided
DB_NAME="${POSTGRES_DB:-gutendex}"
DB_USER="${POSTGRES_USER:-gutendex}"

# Create the database if it doesn't exist
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Create the database if it doesn't exist
    SELECT 'CREATE DATABASE ${DB_NAME}'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '${DB_NAME}');

    -- Grant privileges to user
    GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${DB_USER};

    -- Connect to the database and set ownership
    \c ${DB_NAME}
    
    -- Set default privileges
    ALTER DEFAULT PRIVILEGES GRANT ALL ON TABLES TO ${DB_USER};
    ALTER DEFAULT PRIVILEGES GRANT ALL ON SEQUENCES TO ${DB_USER};
EOSQL

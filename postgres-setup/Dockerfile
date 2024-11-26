# Use PostgreSQL 14 as specified in requirements
FROM postgres:14-alpine

# Create directory for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d
COPY init-scripts/ /docker-entrypoint-initdb.d/
# Set default environment variables
ENV POSTGRES_DB=gutendex \
    POSTGRES_USER=gutendex

EXPOSE 5432

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB} || exit 1

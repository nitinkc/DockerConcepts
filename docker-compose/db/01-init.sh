#!/bin/bash
set -e # Exit immediately if any command in the script exits with a non-zero status, indicating an error.

echo "Running init.sh.... reading .env file"

# Execute SQL commands using psql with the DEFAULT USER
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  -- Create the appdbuser if it doesn't exist
  CREATE ROLE $APP_DB_USER LOGIN PASSWORD '$APP_DB_PASS';

  CREATE DATABASE $APP_DB_NAME;

  -- Grant all privileges on the database to the appdbuser
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
EOSQL

echo "The user is $APP_DB_USER"

psql -v ON_ERROR_STOP=1 --username "$APP_DB_USER" --dbname "$APP_DB_NAME" <<-EOSQL
  -- Create a new schema if it doesn't exist
  CREATE SCHEMA IF NOT EXISTS $APP_DB_SCHEMA;

  -- Set the default search path for the user to the new schema
  SET search_path to $APP_DB_SCHEMA;

  -- Create a table 'event' if it doesn't exist
  CREATE TABLE IF NOT EXISTS event (
    id CHAR(26) NOT NULL CHECK (CHAR_LENGTH(id) = 26) PRIMARY KEY,
    aggregate_id CHAR(26) NOT NULL CHECK (CHAR_LENGTH(aggregate_id) = 26),
    event_data JSON NOT NULL,
    version INT,
    UNIQUE(aggregate_id, version)
  );

  -- Create an index on the 'aggregate_id' column if it doesn't exist
  CREATE INDEX IF NOT EXISTS idx_event_aggregate_id ON event (aggregate_id);
EOSQL

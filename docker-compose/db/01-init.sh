#!/bin/bash
set -e #exit immediately if any command in the script exits with a non-zero status, indicating an error.

echo the user is $POSTGRES_USER
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \connect $APP_DB_NAME $APP_DB_USER;

  CREATE SCHEMA IF NOT EXISTS $APP_DB_SCHEMA;
  -- Create a custom schema - variables from docker-compose
  SET search_path TO $APP_DB_SCHEMA;
  -- Set as the default schema for the user
  ALTER ROLE $APP_DB_USER SET search_path = $APP_DB_SCHEMA;

  BEGIN;
    CREATE TABLE IF NOT EXISTS event (
	  id CHAR(26) NOT NULL CHECK (CHAR_LENGTH(id) = 26) PRIMARY KEY,
	  aggregate_id CHAR(26) NOT NULL CHECK (CHAR_LENGTH(aggregate_id) = 26),
	  event_data JSON NOT NULL,
	  version INT,
	  UNIQUE(aggregate_id, version)
	);
	CREATE INDEX idx_event_aggregate_id ON event (aggregate_id);
  COMMIT;
EOSQL

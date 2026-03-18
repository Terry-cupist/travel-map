#!/bin/bash
set -e

echo "Waiting for PostgreSQL to be ready..."
until pg_isready -h "$PGHOST" -p "$PGPORT" -U "$PGUSER"; do
  sleep 2
done
echo "PostgreSQL is ready."

echo "Loading OSM data..."
osm2pgsql \
  --output=flex \
  --style=/data/poi.lua \
  --host="$PGHOST" \
  --port="$PGPORT" \
  --database="$PGDATABASE" \
  --user="$PGUSER" \
  --slim \
  --drop \
  /data/south-korea-latest.osm.pbf

echo "OSM data loaded successfully."

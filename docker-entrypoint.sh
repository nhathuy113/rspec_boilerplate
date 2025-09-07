#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Install gems if missing
if ! bundle check > /dev/null 2>&1; then
  echo "Gems missing; running bundle install..."
  bundle install --jobs=4 --retry=3
fi

# Wait for MySQL to be ready
DB_HOST="${DB_HOST:-mysql}"
DB_USER="${DB_USER:-root}"
DB_PASSWORD="${DB_PASSWORD:-password}"
echo "Waiting for MySQL ($DB_HOST) to be ready..."
until mysqladmin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
  echo "MySQL is not ready yet. Waiting..."
  sleep 2
done
echo "MySQL is ready!"

# Prepare database once per container lifecycle
mkdir -p /app/tmp
if [ ! -f /app/tmp/.db_prepared ]; then
  echo "Preparing database (create/migrate if needed)..."
  bundle exec rails db:prepare
  touch /app/tmp/.db_prepared
else
  echo "Database already prepared. Skipping."
fi

# Exec the container's main process
exec "$@"

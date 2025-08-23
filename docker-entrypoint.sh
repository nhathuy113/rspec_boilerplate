#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Run at the very start of the image build once
if ! bundle check > /dev/null 2>&1; then
  echo "Gems missing; running bundle install..."
  bundle install --jobs=4 --retry=3
fi

# Wait for MySQL to be ready
echo "Waiting for MySQL to be ready..."
until mysqladmin ping -h"mysql" -u"root" -p"password" --silent; do
  echo "MySQL is not ready yet. Waiting..."
  sleep 2
done
echo "MySQL is ready!"

# Create and migrate database only once per container lifecycle
mkdir -p /app/tmp
if [ ! -f /app/tmp/.db_prepared ]; then
  echo "Preparing database (create/migrate if needed)..."
  bundle exec rails db:prepare
  touch /app/tmp/.db_prepared
else
  echo "Database already prepared. Skipping."
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

#!/bin/sh

echo "⏳ Waiting for MySQL to be ready..."

until nc -z -v -w30 $DB_HOST 3306
do
  echo "⏳ Waiting for MySQL at $DB_HOST:3306..."
  sleep 5
done

echo "✅ MySQL is up - running migrations..."

# Run Sequelize create and migrate
npx sequelize db:create --config config/config.js || true
npx sequelize db:migrate --config config/config.js

# Start the app
pm2-runtime ecosystem.config.js

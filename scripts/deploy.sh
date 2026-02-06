#!/bin/bash
set -e

echo "Starting {APP_NAME} in production mode..."

echo "Building containers..."
docker-compose -f docker-compose.yml -f docker-compose.prod.yml build

echo "Starting containers..."
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

echo "Applying database migration..."
sleep 1
docker-compose exec -T backend python manage.py migrate --noinput

echo "Collecting Django static files..."
docker-compose exec -u root -T backend chown -R 1000:1000 /app/staticfiles || true
docker-compose exec -T backend python manage.py collectstatic --noinput --clear

echo "Cleaning..."
docker image prune -f

echo "Deployment complete!"
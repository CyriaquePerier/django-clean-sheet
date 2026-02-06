#!/bin/bash
set -e

echo "Initializing project..."

# 1. Creating .env
if [ ! -f .env ]; then
    echo "📄 Création du fichier .env par défaut..."
    cp .env.example .env || echo "DB_NAME=app_db\nDB_USER=user\nDB_PASSWORD=password\nDB_HOST=db\nDB_PORT=5432\nDEBUG=1" > .env
fi

# 2. Building containers
echo "Building containers..."
docker-compose build

# 3. Lancement temporaire pour initialiser la DB
echo "Initializing database..."
docker-compose up -d db backend
sleep 5 # Waiting for postgre to be ready

# 4. Migrations
docker-compose exec backend python manage.py migrate

# 5. Load variables from .env to the shell
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# 6. Creating a superuser
echo "Creating a superuser..."
docker-compose exec -e DJANGO_SUPERUSER_PASSWORD=${BACKEND_SUPERUSER_PASSWORD} backend \
  python manage.py createsuperuser \
  --username ${BACKEND_SUPERUSER_USERNAME} \
  --email ${BACKEND_SUPERUSER_EMAIL} \
  --no-input || echo "Can't create this superuser (already existing?)"

docker-compose stop
echo "Installation complete"
#!/bin/bash
set -e

echo "Running tests..."

# 1. Backend
docker-compose run --rm backend python manage.py test

# 2. Frontend
docker-compose run --rm frontend sh -c "npm run lint && npm run test"

echo "PASS"
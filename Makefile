.PHONY: help setup dev test stop clean build-prod deploy shell-back logs

# Variables
COMPOSE_DEV = docker-compose
COMPOSE_PROD = docker-compose -f docker-compose.yml -f docker-compose.prod.yml

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Install project (build, migrations, superuser)
	@chmod +x scripts/*.sh
	./scripts/setup.sh

dev: ## Start development environment
	./scripts/start-dev.sh

test: ## Run frontend and backend tests
	./scripts/run-tests.sh

stop: ## Stop all running containers
	$(COMPOSE_DEV) stop

clean: ## Remove containers, networks, and orphan images
	$(COMPOSE_DEV) down --remove-orphans

build-prod: ## Build production images
	$(COMPOSE_PROD) build

deploy: ## Execute production deployment
	@chmod +x scripts/deploy.sh
	./scripts/deploy.sh

shell-back: ## Open a bash shell in the backend container
	$(COMPOSE_DEV) exec backend bash

logs: ## Follow container logs
	$(COMPOSE_DEV) logs -f
# Makefile for Docker Development Workflow
# Provides convenient commands for common Docker operations

.PHONY: help dev prod build up down logs shell test clean rebuild

# Default target
.DEFAULT_GOAL := help

# Variables
COMPOSE_DEV := docker-compose -f docker-compose.yml -f docker-compose.dev.yml
COMPOSE_PROD := docker-compose -f docker-compose.yml -f docker-compose.prod.yml
COMPOSE_BASE := docker-compose
SERVICE_NAME := cloud-platform

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

##@ General

help: ## Display this help message
	@echo "$(BLUE)Docker Development Workflow - Available Commands$(NC)"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make $(GREEN)<target>$(NC)\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2 } /^##@/ { printf "\n$(BLUE)%s$(NC)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development

dev: ## Start development environment with live reload
	@echo "$(GREEN)Starting development environment...$(NC)"
	$(COMPOSE_DEV) up -d
	@echo "$(GREEN)✓ Development environment running at http://localhost:3000$(NC)"
	@echo "$(YELLOW)Tip: Use 'make logs' to view logs$(NC)"

dev-build: ## Build and start development environment
	@echo "$(GREEN)Building development environment...$(NC)"
	$(COMPOSE_DEV) up -d --build
	@echo "$(GREEN)✓ Development environment built and running$(NC)"

dev-down: ## Stop development environment
	@echo "$(YELLOW)Stopping development environment...$(NC)"
	$(COMPOSE_DEV) down
	@echo "$(GREEN)✓ Development environment stopped$(NC)"

##@ Production

prod: ## Start production environment
	@echo "$(GREEN)Starting production environment...$(NC)"
	$(COMPOSE_PROD) up -d
	@echo "$(GREEN)✓ Production environment running at http://localhost:3000$(NC)"

prod-build: ## Build and start production environment
	@echo "$(GREEN)Building production environment...$(NC)"
	$(COMPOSE_PROD) up -d --build
	@echo "$(GREEN)✓ Production environment built and running$(NC)"

prod-down: ## Stop production environment
	@echo "$(YELLOW)Stopping production environment...$(NC)"
	$(COMPOSE_PROD) down
	@echo "$(GREEN)✓ Production environment stopped$(NC)"

##@ Docker Operations

build: ## Build Docker images
	@echo "$(GREEN)Building Docker images...$(NC)"
	$(COMPOSE_BASE) build
	@echo "$(GREEN)✓ Build complete$(NC)"

up: ## Start services (base configuration)
	@echo "$(GREEN)Starting services...$(NC)"
	$(COMPOSE_BASE) up -d
	@echo "$(GREEN)✓ Services started$(NC)"

down: ## Stop all services
	@echo "$(YELLOW)Stopping all services...$(NC)"
	$(COMPOSE_BASE) down
	@echo "$(GREEN)✓ All services stopped$(NC)"

restart: ## Restart services
	@echo "$(YELLOW)Restarting services...$(NC)"
	$(COMPOSE_BASE) restart
	@echo "$(GREEN)✓ Services restarted$(NC)"

rebuild: down build up ## Rebuild and restart services
	@echo "$(GREEN)✓ Services rebuilt and restarted$(NC)"

##@ Monitoring & Debugging

logs: ## View logs (use CTRL+C to exit)
	@echo "$(BLUE)Viewing logs... (Press CTRL+C to exit)$(NC)"
	$(COMPOSE_BASE) logs -f

logs-dev: ## View development logs
	@echo "$(BLUE)Viewing development logs...$(NC)"
	$(COMPOSE_DEV) logs -f

logs-prod: ## View production logs
	@echo "$(BLUE)Viewing production logs...$(NC)"
	$(COMPOSE_PROD) logs -f

ps: ## List running containers
	@echo "$(BLUE)Running containers:$(NC)"
	$(COMPOSE_BASE) ps

shell: ## Open shell in running container
	@echo "$(BLUE)Opening shell in $(SERVICE_NAME)...$(NC)"
	docker exec -it cloud-io-platform /bin/sh

stats: ## Show container resource usage
	@echo "$(BLUE)Container resource usage:$(NC)"
	docker stats cloud-io-platform --no-stream

inspect: ## Inspect container configuration
	@echo "$(BLUE)Container configuration:$(NC)"
	docker inspect cloud-io-platform

##@ Cleanup

clean: ## Remove containers, networks, and volumes
	@echo "$(RED)Cleaning up Docker resources...$(NC)"
	$(COMPOSE_BASE) down -v
	@echo "$(GREEN)✓ Cleanup complete$(NC)"

clean-all: ## Remove everything including images
	@echo "$(RED)Removing all Docker resources...$(NC)"
	$(COMPOSE_BASE) down -v --rmi all
	@echo "$(GREEN)✓ All resources removed$(NC)"

prune: ## Remove unused Docker resources
	@echo "$(YELLOW)Pruning unused Docker resources...$(NC)"
	docker system prune -f
	@echo "$(GREEN)✓ Prune complete$(NC)"

##@ Quickstart (Plaid Integration)

quickstart-dev: ## Start Plaid quickstart in development mode
	@echo "$(GREEN)Starting Plaid quickstart (development)...$(NC)"
	cd quickstart && $(COMPOSE_BASE) up -d
	@echo "$(GREEN)✓ Quickstart running:$(NC)"
	@echo "  Frontend: http://localhost:3000"
	@echo "  Backend:  http://localhost:8000"

quickstart-down: ## Stop Plaid quickstart
	@echo "$(YELLOW)Stopping Plaid quickstart...$(NC)"
	cd quickstart && $(COMPOSE_BASE) down
	@echo "$(GREEN)✓ Quickstart stopped$(NC)"

quickstart-logs: ## View Plaid quickstart logs
	@echo "$(BLUE)Viewing quickstart logs...$(NC)"
	cd quickstart && $(COMPOSE_BASE) logs -f

##@ Testing

test: ## Run tests in Docker
	@echo "$(BLUE)Running tests...$(NC)"
	@echo "$(YELLOW)Test configuration not yet implemented$(NC)"

health: ## Check health of running services
	@echo "$(BLUE)Checking service health...$(NC)"
	@curl -f http://localhost:3000/health || echo "$(RED)Health check failed$(NC)"

##@ Information

version: ## Show Docker and Docker Compose versions
	@echo "$(BLUE)Docker version:$(NC)"
	@docker --version
	@echo "$(BLUE)Docker Compose version:$(NC)"
	@docker-compose --version

info: ## Show detailed system information
	@echo "$(BLUE)Docker system information:$(NC)"
	@docker info

images: ## List Docker images
	@echo "$(BLUE)Docker images:$(NC)"
	@docker images | grep -E "dashboard|nginx|REPOSITORY"

networks: ## List Docker networks
	@echo "$(BLUE)Docker networks:$(NC)"
	@docker network ls

volumes: ## List Docker volumes
	@echo "$(BLUE)Docker volumes:$(NC)"
	@docker volume ls

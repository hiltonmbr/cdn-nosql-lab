.PHONY: help up down status logs clean shell-redis shell-mongo shell-cassandra shell-postgres setup-env jupyter jupyter-lab clean-env

# Variables
COMPOSE = docker compose
UV_BIN := $(shell command -v uv 2> /dev/null)

help: ## ❓ Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

# --- VIRTUAL ENVIRONMENT & NOTEBOOKS ---

setup-env: ## 🐍 Create virtual environment (.venv) and install dependencies via uv
ifndef UV_BIN
	@echo "⚠️  uv not found. Installing uv (ultra-fast package manager)..."
	curl -LsSf https://astral.sh/uv/install.sh | sh
endif
	@echo "🔄 Syncing dependencies with uv..."
	uv sync
	@echo "✅ Environment ready! Run 'make jupyter' to open the notebooks."

jupyter: ## 📓 Start Jupyter Notebook server in the isolated environment
	@echo "🚀 Starting Jupyter Notebook..."
	uv run jupyter notebook --notebook-dir=notebooks

jupyter-lab: ## 🔬 Start JupyterLab (advanced IDE) in the isolated environment
	@echo "🚀 Starting JupyterLab..."
	uv run jupyter lab --notebook-dir=notebooks

clean-env: ## 🧹 Remove the isolated Python virtual environment (.venv)
	rm -rf .venv
	@echo "🗑️ Virtual environment removed."

# --- DOCKER SERVICES (Databases) ---

up: ## 🐳 Start all compose services in background
	$(COMPOSE) up -d

down: ## 🛑 Stop all compose services keeping volumes intact
	$(COMPOSE) down

status: ## 📊 Show status and ports of active containers
	$(COMPOSE) ps

logs: ## 📜 Tail logs in real time
	$(COMPOSE) logs -f

clean: ## 🧨 Remove containers and permanently delete all data
	$(COMPOSE) down -v

# --- DATABASE CLIs ---

shell-redis: ## 🔴 Open interactive Redis CLI
	docker exec -it redis redis-cli

shell-mongo: ## 🟢 Open interactive MongoDB shell
	docker exec -it mongo mongosh -u mongo -p mongo

shell-cassandra: ## 🔵 Open interactive Cassandra CLI
	docker exec -it cassandra cqlsh

shell-postgres: ## 🐘 Open interactive PostgreSQL CLI
	docker exec -it postgres psql -U postgres


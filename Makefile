.PHONY: help up down status logs clean shell-redis shell-mongo shell-cassandra shell-postgres setup-env jupyter jupyter-lab clean-env

# Variáveis
COMPOSE = docker compose
UV_BIN := $(shell command -v uv 2> /dev/null)

help: ## ❓ Exibe esta mensagem de ajuda
	@echo "Uso: make [target]"
	@echo ""
	@echo "Targets disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

# --- AMBIENTE VIRTUAL E NOTEBOOKS ---

setup-env: ## 🐍 Cria o ambiente virtual (.venv) e instala dependências via uv
ifndef UV_BIN
	@echo "⚠️  uv não encontrado. Instalando o uv (gerenciador de pacotes ultra-rápido)..."
	curl -LsSf https://astral.sh/uv/install.sh | sh
endif
	@echo "🔄 Sincronizando dependências com uv..."
	uv sync
	@echo "✅ Ambiente configurado com sucesso! Use 'make jupyter' para abrir os notebooks."

jupyter: ## 📓 Inicia o servidor Jupyter Notebook no ambiente isolado
	@echo "🚀 Iniciando Jupyter Notebook..."
	uv run jupyter notebook --notebook-dir=notebooks

jupyter-lab: ## 🔬 Inicia o JupyterLab (IDE avançada) no ambiente isolado
	@echo "🚀 Iniciando JupyterLab..."
	uv run jupyter lab --notebook-dir=notebooks

clean-env: ## 🧹 Remove o ambiente virtual Python isolado (.venv)
	rm -rf .venv
	@echo "🗑️ Ambiente virtual removido."

# --- SERVIÇOS DOCKER (Bancos de Dados) ---

up: ## 🐳 Inicializa todos os serviços do compose em background
	$(COMPOSE) up -d

down: ## 🛑 Para todos os serviços do compose mantendo volumes intactos
	$(COMPOSE) down

status: ## 📊 Exibe o status e portas dos containers ativos
	$(COMPOSE) ps

logs: ## 📜 Exibe e acompanha os logs em tempo real
	$(COMPOSE) logs -f

clean: ## 🧨 Remove os containers e exclui permanentemente os dados
	$(COMPOSE) down -v

# --- TERMINAIS DE BANCO DE DADOS (CLI) ---

shell-redis: ## 🔴 Abre a CLI interativa do Redis
	docker exec -it redis redis-cli

shell-mongo: ## 🟢 Abre o shell interativo do MongoDB
	docker exec -it mongo mongosh -u mongo -p mongo

shell-cassandra: ## 🔵 Abre a CLI interativa do Cassandra
	docker exec -it cassandra cqlsh

shell-postgres: ## 🐘 Abre a CLI interativa do PostgreSQL
	docker exec -it postgres psql -U postgres


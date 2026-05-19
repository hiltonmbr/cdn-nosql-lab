.PHONY: help up down status logs clean shell-redis shell-mongo shell-cassandra

# Variáveis
COMPOSE = docker compose

help: ## Exibe esta mensagem de ajuda
	@echo "Uso: make [target]"
	@echo ""
	@echo "Targets disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

up: ## Inicializa todos os serviços do compose em background (modo detached)
	$(COMPOSE) up -d

down: ## Para todos os serviços do compose mantendo volumes intactos
	$(COMPOSE) down

status: ## Exibe o status e portas dos containers ativos
	$(COMPOSE) ps

logs: ## Exibe e acompanha os logs em tempo real de todos os serviços
	$(COMPOSE) logs -f

clean: ## Remove os containers e exclui permanentemente os volumes de dados persistidos
	$(COMPOSE) down -v

shell-redis: ## Abre a CLI interativa do Redis (redis-cli)
	docker exec -it redis redis-cli

shell-mongo: ## Abre o shell interativo do MongoDB (mongosh) com credenciais inclusas
	docker exec -it mongo mongosh -u mongo -p mongo

shell-cassandra: ## Abre a CLI interativa do Cassandra (cqlsh)
	docker exec -it cassandra cqlsh

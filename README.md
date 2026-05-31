# 🧪 Laboratório de Bancos de Dados: SQL e NoSQL

### **O Guia Prático para Escala e Persistência de Dados Modernos**
Experimente os cinco principais paradigmas de bancos de dados do mercado rodando simultaneamente na sua máquina local, com teoria embasada e código iterativo.

![Docker](https://img.shields.io/badge/Docker-27.x-2496ED?logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Compose-v2-2496ED?logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?logo=jupyter&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 🎯 O que é este repositório?

Um **laboratório hands-on** para explorar a revolução dos dados. Durante as últimas décadas, saímos do reinado absoluto do modelo Relacional para a diversidade arquitetural do movimento NoSQL. Aqui, você experimentará ambos:

- 📖 **Documentação Rica** — Teoria baseada em fundamentos sólidos (ACID, Teorema CAP e Padrões de Acesso).
- ⚙️ **Ambiente de Teste Universal** — Suba um cluster com os 5 principais bancos com 1 único comando.
- 💻 **Guias Interativos (Labs)** — Interaja de verdade usando Python e Jupyter Notebooks.

> **Público-alvo:** Estudantes, cientistas de dados e engenheiros que querem dominar a persistência de dados moderna, entendendo o porquê de cada escolha arquitetural.

---

## ⚡ Quick Start (5 minutos)

Se você já tem o Docker e o `make` instalados, pode iniciar o laboratório em três passos simples:

```bash
# 1. Clone o repositório
git clone https://github.com/hiltonmbr/cdn-docker-nosql.git
cd cdn-docker-nosql

# 2. Inicie a infraestrutura de Bancos de Dados (roda em background)
make up

# 3. Configure o ambiente Python virtual e inicie os Laboratórios
make setup-env
make jupyter
```

Seu navegador será aberto automaticamente com os cadernos de exercícios interativos na pasta `notebooks/`.

> **⚠️ Observação sobre o Cassandra:** A inicialização do Cassandra é intensa para o sistema. Pode demorar de 1 a 2 minutos para ele ficar pronto para receber conexões após o `make up`.

---

## ⚙️ Pré-requisitos

Para realizar os laboratórios, garanta que sua máquina cumpra os seguintes requisitos:

| Requisito | Detalhes |
|---|---|
| **Docker Engine** | Essencial para instanciar os bancos de forma isolada ([Instalação](https://docs.docker.com/get-docker/)) |
| **Docker Compose** | Já vem embutido no Docker Desktop (orquestra nossos 5 serviços) |
| **Make (opcional)** | Usado para atalhos no terminal. Se não tiver, use comandos brutos do Docker. |
| **Python 3.8+** | Recomendado para executar os notebooks em ambiente virtual Python. |
| **Recursos** | Recomenda-se 8GB RAM ou superior. |

Verifique a instalação das ferramentas vitais:
```bash
docker version
docker compose version
```

---

## 🗺️ Mapa de Aprendizagem

Para extrair o máximo do laboratório, sugerimos a seguinte jornada: primeiro a base teórica, e então a imersão guiada no terminal/notebook de cada paradigma.

### 📖 Teoria: Fundamentos da Escala
| # | Módulo Teórico | O que você vai aprender | Link |
|:---:|:---|:---|:---:|
| 1 | **Desafio da Escala e Teorema CAP** | O limite relacional, garantia ACID, e o Teorema que governa sistemas distribuídos. | [📖 Ler](docs/01-sql-vs-nosql-cap.md) |
| 2 | **Paradigmas NoSQL e Modelos de Dados** | Como o armazenamento difere: Tabela, Hash, Documento, Coluna Larga e Grafo. | [📖 Ler](docs/02-paradigmas-nosql.md) |

### 🧪 Labs Práticos: Mãos na Massa
Nossos laboratórios ocorrem dentro da pasta `notebooks/`. Siga a ordem ou pule direto para o banco do seu interesse:

| # | Banco | Paradigma | Casos de Uso Reais | Lab Interativo |
|:---:|:---|:---|:---|:---:|
| 1 | 🔴 **Redis** | Chave-Valor | Caches, sessões web, carrinhos abandonados, placares em tempo real. | [🧪 Ir para o Lab](notebooks/01_redis.ipynb) |
| 2 | 🟢 **MongoDB** | Documento | Catálogos de e-commerce flexíveis, CMS, prototipagem ágil, perfis multi-facetados. | [🧪 Ir para o Lab](notebooks/02_mongodb.ipynb) |
| 3 | 🔵 **Cassandra** | Colunar | Escrita massiva: sensores de IoT industriais, métricas temporais, log de logs contínuos. | [🧪 Ir para o Lab](notebooks/03_cassandra.ipynb) |
| 4 | 🟡 **Neo4j** | Grafo | Redes sociais (amigo do amigo), recomendação de produtos, rotas ótimas, detecção de fraude. | [🧪 Ir para o Lab](notebooks/04_neo4j.ipynb) |
| 5 | 🐘 **PostgreSQL** | Relacional | Sistemas financeiros rigorosos, folha de pagamento, onde 100% de consistência é vital. | [🧪 Ir para o Lab](notebooks/05_postgres.ipynb) |

> [!NOTE]
> Você também pode explorar grafos visualmente. Quando o laboratório estiver rodando, acesse o painel **[Neo4j Browser](http://localhost:7475)** e insira `bolt://localhost:7688` para explorar arestas de forma interativa!

---

## 🏗️ Arquitetura do Laboratório

Abaixo a arquitetura da frota de bancos rodando através do Docker Compose, usando redes isoladas e persistência garantida via volumes.

```mermaid
graph TD
    subgraph "Docker Compose Network (Isolada)"
    
        redis["🔴 Redis<br>Chave-Valor<br>Porta: 6379"]
        mongo["🟢 MongoDB<br>Documento<br>Porta: 27017"]
        cassandra["🔵 Cassandra<br>Colunas Largas<br>Porta: 9042"]
        neo4j["🟡 Neo4j<br>Grafo<br>Porta: 7475 / 7688"]
        postgres["🐘 PostgreSQL<br>Relacional<br>Porta: 5432"]
        
    end

    subgraph "Volumes Docker (Persistência)"
        v_redis[(redis_data)]
        v_mongo[(mongo_data)]
        v_cass[(cassandra_data)]
        v_neo[(neo4j_data)]
        v_pg[(postgres_data)]
    end

    %% Ligações com Volumes
    redis -.-> v_redis
    mongo -.-> v_mongo
    cassandra -.-> v_cass
    neo4j -.-> v_neo
    postgres -.-> v_pg

    %% Ambiente Local / Python
    local["💻 Máquina Local do Estudante<br>(Python Jupyter / IDE DataGrip)"]
    
    local ==> redis
    local ==> mongo
    local ==> cassandra
    local ==> neo4j
    local ==> postgres

    classDef db fill:#f5f5f5,stroke:#333,stroke-width:2px;
    class redis,mongo,cassandra,neo4j,postgres db;
    classDef volume fill:#d0e6f5,stroke:#0f52ba,stroke-width:1px;
    class v_redis,v_mongo,v_cass,v_neo,v_pg volume;
    classDef comp fill:#fcfcff,stroke:#2496ED,stroke-dasharray: 5 5;
    class "Docker Compose Network (Isolada)" comp;
```

---

## 📝 Cheatsheet de Administração do Lab

Além dos notebooks, você pode "entrar" nos bancos via linha de comando para fazer consultas curtas. Use as ferramentas já configuradas no `Makefile`:

```bash
# ── Orquestração do Laboratório ──
make up            # Sobe o laboratório todo em background
make down          # Pausa o lab (mas não apaga seus dados)
make clean         # ⚠️ DESTRÓI os containers E zera todos os dados (útil para recomeçar)
make status        # Veja quais bancos estão rodando

# ── Acessando os Terminais Nativos ──
make shell-redis       # Abre a CLI do Redis (redis-cli)
make shell-mongo       # Abre o Shell do MongoDB (mongosh)
make shell-cassandra   # Abre a CLI de Consulta (cqlsh)
make shell-postgres    # Abre a CLI do Postgres (psql)
```

---

## 💾 Persistência de Dados e Limpeza

Sua experimentação está segura. O projeto utiliza **volumes Docker nomeados**.

Isso significa que se você desligar o computador (ou rodar `make down`), as tabelas, documentos e grafos criados dentro dos notebooks estarão preservados na próxima vez que você subir os containers.

Se você fez bagunça e quer "resetar" todos os bancos para o estado inicial virgem de fábrica, basta executar `make clean`.

---

## 📄 Referências Oficiais e Licença

- [MongoDB University](https://learn.mongodb.com/)
- [Neo4j GraphAcademy](https://graphacademy.neo4j.com/)
- [DataStax Cassandra](https://www.datastax.com/learn)

> **Material educacional aberto.** Criado para as aulas práticas da disciplina de **Ciência de Dados para Negócios** (UFPB). Desenvolvido por Hilton Martins.

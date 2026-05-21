# NoSQL com Docker & Docker Compose 🐳

Este projeto de caráter educacional demonstra como executar e interagir de forma rápida com quatro diferentes sistemas de bancos de dados **NoSQL**, cada um representando um paradigma diferente. Através do Docker e do Docker Compose, você poderá rodar todas as instâncias localmente com um único comando, permitindo explorar e comparar suas principais características de forma prática.

## 📑 Sumário

- [Paradigmas de Bancos de Dados Cobertos](#️-paradigmas-de-bancos-de-dados-cobertos)
- [Pré-requisitos](#-pré-requisitos)
- [Início Rápido](#-início-rápido)
- [Referência de Comandos (Makefile)](#️-referência-de-comandos-makefile)
- [Arquitetura do Projeto](#-arquitetura-do-projeto)
- [Guia de Interação por Banco de Dados](#-guia-de-interação-prática-por-banco-de-dados)
- [Notebooks Python (Guias Interativos)](#-notebooks-python-guias-interativos)
- [Conexão via DataGrip (IDE)](#️-conexão-via-datagrip-ide)
- [Persistência de Dados](#-persistência-de-dados)
- [Sugestões de Estudo e Prática](#-sugestões-de-estudo-e-prática)

---

## 🛠️ Paradigmas de Bancos de Dados Cobertos

Este projeto inclui quatro bancos de dados, cada um representando um paradigma fundamental do universo NoSQL:

| Banco de Dados | Paradigma | Imagem Docker | Porta Exposta | CLI |
|:--|:--|:--|:--|:--|
| 🔴 **Redis** | Chave-Valor | `redis:alpine` | `6379` | `redis-cli` |
| 🟢 **MongoDB** | Documento | `mongo:8.3` | `27017` | `mongosh` |
| 🔵 **Cassandra** | Família de Colunas | `cassandra:5.0.8-bookworm` | `9042` | `cqlsh` |
| 🟡 **Neo4j** | Grafo | `neo4j:5.26.26-community-ubi10` | `7475` (HTTP) / `7688` (Bolt) | Navegador Web |

### Por que esses quatro?

Cada paradigma resolve um tipo diferente de problema:

- **🔴 Chave-Valor (Redis):** Otimizado para leitura e escrita ultrarrápida em memória RAM. Ideal para **cache**, sessões de usuário, filas de mensagens e contadores em tempo real.
- **🟢 Documento (MongoDB):** Armazena dados como documentos JSON flexíveis, sem esquema fixo. Perfeito para **catálogos de produtos**, CMS, aplicações com dados semiestruturados e prototipagem rápida.
- **🔵 Família de Colunas (Cassandra):** Projetado para **escrita massiva** e distribuição geográfica de dados. Excelente para séries temporais (IoT, logs), métricas e sistemas com altíssima disponibilidade.
- **🟡 Grafo (Neo4j):** Modela dados como redes de entidades e conexões. Superior para **redes sociais**, recomendações, detecção de fraudes e análise de dependências.

---

## 🚀 Pré-requisitos

Antes de iniciar, certifique-se de ter instalado em sua máquina:

| Ferramenta | Obrigatório | Descrição | Instalação |
|:--|:--:|:--|:--|
| **Docker** | ✅ | Motor de containers para rodar os bancos de dados | [Instruções de Instalação](https://docs.docker.com/get-docker/) |
| **Docker Compose** | ✅ | Orquestrador de múltiplos containers (geralmente integrado ao Docker Desktop) | Incluído no Docker Desktop |
| **Python 3.8+** | Recomendado | Necessário para executar os notebooks interativos | [python.org](https://www.python.org/downloads/) |
| **Jupyter Notebook** | Recomendado | Ambiente interativo para os notebooks (`pip install jupyter`) | `pip install jupyter` |
| **DataGrip** | Opcional | IDE para gerenciar e consultar bancos de dados SQL/NoSQL | [Página Oficial](https://www.jetbrains.com/datagrip/) |

> **💡 Verificação rápida:** Execute `docker --version` e `docker compose version` no terminal para confirmar que as ferramentas estão instaladas corretamente.

---

## ⚡ Início Rápido

Três passos para ter todo o ambiente funcional:

```bash
# 1. Clone o repositório (caso ainda não tenha feito)
git clone <url-do-repositorio>
cd cdn-docker-nosql

# 2. Inicie todos os bancos de dados em segundo plano
docker compose up -d
# ou, se tiver o make instalado:
make up

# 3. Verifique se todos os containers estão rodando
docker compose ps
# ou:
make status
```

> **⚠️ Atenção:** O **Cassandra** pode demorar entre **1 e 2 minutos** para inicializar completamente. Os outros bancos iniciam quase instantaneamente. Se a conexão com o Cassandra falhar logo após o `docker compose up -d`, aguarde alguns instantes e tente novamente.

Para **parar** todos os serviços (mantendo os dados salvos):

```bash
docker compose down    # ou: make down
```

Para **parar e apagar todos os dados** dos volumes:

```bash
docker compose down -v    # ou: make clean
```

---

## 🛠️ Referência de Comandos (Makefile)

Se você tiver o `make` instalado, pode utilizar atalhos simplificados. Execute `make help` para ver todos os comandos disponíveis:

| Comando | Descrição | Equivalente Docker |
|:--|:--|:--|
| `make up` | Inicializa todos os serviços em background | `docker compose up -d` |
| `make down` | Para todos os serviços (preserva dados) | `docker compose down` |
| `make status` | Exibe status e portas dos containers | `docker compose ps` |
| `make logs` | Acompanha logs em tempo real | `docker compose logs -f` |
| `make clean` | Remove containers **e dados persistidos** | `docker compose down -v` |
| `make shell-redis` | Abre a CLI interativa do Redis | `docker exec -it redis redis-cli` |
| `make shell-mongo` | Abre o shell do MongoDB (com credenciais) | `docker exec -it mongo mongosh -u mongo -p mongo` |
| `make shell-cassandra` | Abre a CLI do Cassandra | `docker exec -it cassandra cqlsh` |

---

## 🏗️ Arquitetura do Projeto

```
cdn-docker-nosql/
├── docker-compose.yml    # Define os 4 serviços e volumes persistentes
├── Makefile              # Atalhos para gerenciar o ambiente
├── README.md             # Esta documentação
└── notebooks/            # Guias interativos em Python (Jupyter)
    ├── 01_redis.ipynb        # CRUD, TTL, Hashes, Lists, Sets
    ├── 02_mongodb.ipynb      # CRUD, Projeção, Agregação
    ├── 03_cassandra.ipynb    # Keyspace, Partition Key, Prepared Statements
    └── 04_neo4j.ipynb        # Nós, Relacionamentos, Cypher, Recomendação
```

### Diagrama de Serviços

```
┌─────────────────────────────────────────────────────────────┐
│                    Docker Compose Network                    │
│                                                             │
│   ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│   │  Redis   │  │ MongoDB  │  │Cassandra │  │  Neo4j   │  │
│   │ :6379    │  │ :27017   │  │ :9042    │  │ :7475    │  │
│   │          │  │          │  │          │  │ :7688    │  │
│   └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘  │
│        │             │             │              │         │
│   redis_data    mongo_data   cassandra_data  neo4j_data    │
│   (volume)      (volume)      (volume)       (volume)      │
└─────────────────────────────────────────────────────────────┘
```

---

## 💻 Guia de Interação Prática por Banco de Dados

Abaixo, encontram-se instruções de como conectar a cada serviço via terminal e executar operações de teste.

---

### 🔴 1. Redis (Chave-Valor)

O Redis armazena dados na **memória RAM** como pares chave-valor, oferecendo tempos de resposta de **microssegundos**. É o banco mais rápido deste projeto.

| Propriedade | Valor |
|:--|:--|
| **Porta** | `6379` |
| **Autenticação** | Nenhuma |
| **Persistência** | Assíncrona em disco (RDB/AOF) |
| **Linguagem de consulta** | Comandos Redis |

**Conectar via CLI:**

```bash
docker exec -it redis redis-cli
# ou: make shell-redis
```

**Exemplos de Operações:**

```redis
# ── Strings (tipo mais básico) ──

# Definir uma chave com um valor
SET usuario:nome "Carlos Silva"

# Recuperar o valor da chave
GET usuario:nome

# Definir uma chave com tempo de expiração (10 segundos)
SETEX sessao:token 10 "xyz123"

# Verificar tempo restante de expiração (retorna -2 se já expirou)
TTL sessao:token

# ── Hashes (objetos/dicionários) ──

# Armazenar um objeto com múltiplos campos
HSET usuario:1 nome "Ana" email "ana@email.com" idade "28"

# Recuperar todos os campos do objeto
HGETALL usuario:1

# Sair da CLI
exit
```

---

### 🟢 2. MongoDB (Documento)

O MongoDB armazena dados como **documentos BSON** (JSON binário), permitindo estruturas flexíveis e aninhadas sem necessidade de esquema fixo.

| Propriedade | Valor |
|:--|:--|
| **Porta** | `27017` |
| **Autenticação** | Usuário `mongo` / Senha `mongo` |
| **URI de Conexão** | `mongodb://mongo:mongo@localhost:27017/?authSource=admin&directConnection=true` |
| **Linguagem de consulta** | MQL (MongoDB Query Language) |

**Conectar via CLI (`mongosh`):**

```bash
docker exec -it mongo mongosh -u mongo -p mongo
# ou: make shell-mongo
```

**Exemplos de Operações:**

```javascript
// Criar ou selecionar um banco de dados
use faculdade

// Inserir um documento na coleção 'alunos'
db.alunos.insertOne({
  nome: "Ana Costa",
  curso: "Ciência da Computação",
  ano: 2024,
  notas: [9.0, 8.5, 9.5]  // Arrays são suportados nativamente
})

// Buscar todos os documentos cadastrados
db.alunos.find()

// Buscar alunos com filtro (equivalente ao WHERE do SQL)
db.alunos.find({ curso: "Ciência da Computação" })

// Buscar apenas nome e curso, omitindo o _id
db.alunos.find({}, { nome: 1, curso: 1, _id: 0 })
```

---

### 🔵 3. Apache Cassandra (Família de Colunas)

O Cassandra foi projetado para gerenciar **grandes volumes de dados distribuídos** entre vários servidores. A modelagem de dados é orientada pelas **consultas** que a aplicação fará.

| Propriedade | Valor |
|:--|:--|
| **Porta** | `9042` |
| **Autenticação** | Nenhuma |
| **Tempo de inicialização** | ~1-2 minutos (mais lento que os demais) |
| **Linguagem de consulta** | CQL (Cassandra Query Language) |

> **⚠️ Importante:** Aguarde o Cassandra inicializar completamente antes de conectar. Se receber erro de conexão, espere mais 1-2 minutos.

**Conectar via CLI (`cqlsh`):**

```bash
docker exec -it cassandra cqlsh
# ou: make shell-cassandra
```

**Exemplos de Operações (CQL):**

```sql
-- Criar um Keyspace (equivalente ao Banco de Dados)
-- SimpleStrategy com fator 1 = uma cópia, ideal para desenvolvimento local
CREATE KEYSPACE escola
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Utilizar o Keyspace criado
USE escola;

-- Criar uma tabela com Chave Primária Composta
-- ((curso)) = Partition Key → define em qual nó os dados são armazenados
-- id = Clustering Key → define a ordenação dentro da partição
CREATE TABLE estudantes (
    curso text,
    id int,
    nome text,
    email text,
    PRIMARY KEY ((curso), id)
);

-- Inserir registros
INSERT INTO estudantes (curso, id, nome, email)
  VALUES ('Ciência da Computação', 1, 'Felipe Souza', 'felipe@email.com');

-- Consulta eficiente (filtrando pela Partition Key)
SELECT * FROM estudantes WHERE curso = 'Ciência da Computação';
```

---

### 🟡 4. Neo4j (Grafo)

O Neo4j modela dados como **nós** (entidades) e **relacionamentos** (conexões direcionadas). A linguagem **Cypher** usa uma sintaxe visual baseada em padrões ASCII para representar grafos.

| Propriedade | Valor |
|:--|:--|
| **Porta HTTP** | `7475` (interface web) |
| **Porta Bolt** | `7688` (protocolo binário do driver) |
| **Autenticação** | Desativada (`NEO4J_AUTH=none`) |
| **Linguagem de consulta** | Cypher |

**Conectar via Interface Gráfica (Browser):**

Abra seu navegador e acesse: **[http://localhost:7475](http://localhost:7475)**

**Passo a passo para conectar:**
1. Vá até o campo **Connection URL** na parte de baixo da tela inicial.
2. Apague o `7687` e digite `7688` (ficando `localhost:7688` ou `neo4j://localhost:7688`).
3. Deixe os campos de **"Database user"** e **"Password"** em branco (pois a autenticação está desativada).
4. Clique no botão azul **Connect**.

> **💡 Dica:** O Neo4j Browser oferece visualização interativa dos grafos com nós coloridos e arestas animadas — é a melhor forma de explorar dados em grafo.

**Exemplos de Operações (Linguagem Cypher):**

Execute as consultas abaixo na barra de comandos do console Web do Neo4j:

```cypher
// Criar dois nós de Pessoa
CREATE (p1:Pessoa {nome: 'Maria', idade: 28})
CREATE (p2:Pessoa {nome: 'João', idade: 30})

// Criar um relacionamento de amizade direcionado entre eles
CREATE (p1)-[:AMIGO_DE {desde: 2022}]->(p2);

// Buscar e visualizar todos os nós e relacionamentos
MATCH (n) RETURN n;

// Buscar amigos de Maria
MATCH (m:Pessoa {nome: 'Maria'})-[:AMIGO_DE]->(amigo)
RETURN amigo.nome, amigo.idade;
```

---

## 📓 Notebooks Python (Guias Interativos)

O diretório `notebooks/` contém **4 notebooks Jupyter** com guias completos e interativos para cada banco de dados. Cada notebook cobre:

| Notebook | Banco | Tópicos Cobertos |
|:--|:--|:--|
| `01_redis.ipynb` | 🔴 Redis | Conexão, CRUD com Strings, TTL/Expiração, Hashes, Lists, Sets |
| `02_mongodb.ipynb` | 🟢 MongoDB | Conexão, CRUD com Documentos, Filtros, Projeção, Aggregation Pipeline |
| `03_cassandra.ipynb` | 🔵 Cassandra | Keyspace, Partition Key, Prepared Statements, ALLOW FILTERING |
| `04_neo4j.ipynb` | 🟡 Neo4j | Nós, Relacionamentos, Travessia de Grafos, Recomendação (amigo de amigo) |

### Como executar os notebooks (com ambiente isolado)

Para garantir que os pacotes Python não entrem em conflito com o seu sistema, utilizamos o **[uv](https://github.com/astral-sh/uv)** (um gerenciador de pacotes ultra-rápido) para criar um ambiente virtual isolado (`.venv`) contendo o Jupyter e os drivers dos bancos de dados.

```bash
# 1. Configure o ambiente virtual (instala o uv, cria o .venv e baixa as dependências)
make setup-env

# 2. Inicie o servidor Jupyter Notebook (ou jupyter-lab) no ambiente isolado
make jupyter
# ou: make jupyter-lab

# 3. O navegador será aberto automaticamente. Acesse a pasta notebooks/ e divirta-se!
```

> **💡 Dica:** Todo o gerenciamento de dependências é feito de forma declarativa pelo arquivo `pyproject.toml`. Os notebooks não precisam de comandos `!pip install` espalhados pelas células, tornando a experiência mais limpa.

---

## 🗄️ Conexão via DataGrip (IDE)

O **DataGrip** (da JetBrains) é uma ferramenta integrada para gerenciar, visualizar e consultar múltiplos bancos de dados SQL e NoSQL em um só lugar. Abaixo, as instruções de configuração para cada banco:

### 🔴 1. Redis

1. No painel **Database**, clique no botão `+` (New) → **Data Source** → **Redis**.
2. No campo **Host**, insira `localhost`.
3. No campo **Port**, mantenha `6379`.
4. No campo **Authentication**, selecione **No Auth** (deixe a senha em branco).
5. Clique em **Test Connection** (se solicitado, permita o download do driver JDBC) e depois em **OK**.

### 🟢 2. MongoDB

1. Clique no botão `+` → **Data Source** → **MongoDB**.
2. No campo **Host**, insira `localhost`.
3. No campo **Port**, insira `27017`.
4. No campo **Authentication**, selecione **User & Password**:
   - **User**: `mongo`
   - **Password**: `mongo`
   - **Database**: `admin` (banco de autenticação).
5. _Alternativa (via URI):_ Mude para **URL only** e cole:
   `mongodb://mongo:mongo@localhost:27017/?authSource=admin&directConnection=true`
6. Clique em **Test Connection** e em **OK**.

### 🔵 3. Apache Cassandra

1. Clique no botão `+` → **Data Source** → **Cassandra**.
2. No campo **Host**, insira `localhost`.
3. No campo **Port**, insira `9042`.
4. No campo **Authentication**, selecione **No Auth**.
5. Clique em **Test Connection** e em **OK**.

### 🟡 4. Neo4j (Requer Plugin ou Driver Manual)

O DataGrip **não possui suporte nativo** para o Neo4j. Existem duas opções:

- **Opção 1: Plugin do Marketplace (Recomendado)**
  1. Acesse **Settings/Preferences** → **Plugins**.
  2. Pesquise por **Graph Database support** ou **GraphDB for Neo4j** no Marketplace e instale.
  3. Após reiniciar a IDE, configure a conexão apontando para `bolt://localhost:7688` com autenticação **No Auth**.

- **Opção 2: Driver JDBC Manual**
  1. Baixe o `.jar` do driver JDBC oficial do Neo4j.
  2. No DataGrip: **Database Explorer** → `+` (New) → **Driver** → importe o `.jar`.
  3. Crie um Data Source com URL: `jdbc:neo4j:bolt://localhost:7688` e sem autenticação.

> **💡 Recomendação:** Para a melhor experiência com grafos, use o próprio **[Neo4j Browser](http://localhost:7475)** — ele oferece visualização interativa de nós e arestas sem configuração adicional.

---

## 💾 Persistência de Dados

O projeto utiliza **volumes Docker nomeados** para garantir que os dados sejam preservados mesmo ao parar ou recriar os containers. Os volumes são declarados no final do `docker-compose.yml`:

| Volume | Banco de Dados | O que é persistido |
|:--|:--|:--|
| `redis_data` | Redis | Snapshots RDB e logs de append-only (AOF) |
| `mongo_data` | MongoDB | Bancos de dados, coleções e índices |
| `cassandra_data` | Cassandra | SSTables, commit logs e dados de partição |
| `neo4j_data` | Neo4j | Nós, relacionamentos e índices do grafo |

### Cenários comuns

| Ação | Dados preservados? |
|:--|:--:|
| `docker compose stop` / `docker compose start` | ✅ Sim |
| `docker compose down` | ✅ Sim (containers removidos, volumes mantidos) |
| `docker compose down -v` / `make clean` | ❌ **Não** (volumes removidos permanentemente) |
| Reiniciar o computador | ✅ Sim (containers reiniciam com `restart: unless-stopped`) |

---

## 📚 Sugestões de Estudo e Prática

### 🎯 Exercícios Práticos

1. **Comparação de Modelagem:** Modele um sistema de "Seguidores de Rede Social" em cada um dos 4 bancos. Compare como cada paradigma representa o mesmo problema:
   - **Redis:** Sets para lista de seguidores/seguidos.
   - **MongoDB:** Documentos com arrays de referências.
   - **Cassandra:** Tabela orientada por consulta (quem segue X? quem X segue?).
   - **Neo4j:** Nós `Pessoa` com relacionamentos `SEGUE`.

2. **Arquitetura Polyglot:** Construa uma pequena aplicação que combine dois bancos:
   - **Redis** para cache/sessão + **MongoDB** para dados persistentes.
   - **Neo4j** para recomendações + **Redis** para cache dos resultados.

3. **Performance:** Compare o tempo de inserção de 10.000 registros no Redis vs MongoDB vs Cassandra. Qual é o mais rápido para escrita em lote?

4. **Consultas Avançadas:** Experimente os recursos mais poderosos de cada banco:
   - **Redis:** Sorted Sets com `ZADD` para criar um ranking.
   - **MongoDB:** Pipeline de agregação com `$lookup` (equivalente ao JOIN).
   - **Cassandra:** Tabelas com TTL para dados temporários (`USING TTL 3600`).
   - **Neo4j:** Algoritmo `shortestPath()` para encontrar o menor caminho entre dois nós.

### 📖 Referências e Documentação Oficial

| Banco | Documentação | Tutorial Rápido |
|:--|:--|:--|
| 🔴 Redis | [redis.io/docs](https://redis.io/docs/) | [Try Redis (online)](https://try.redis.io/) |
| 🟢 MongoDB | [mongodb.com/docs](https://www.mongodb.com/docs/manual/) | [MongoDB University](https://learn.mongodb.com/) |
| 🔵 Cassandra | [cassandra.apache.org/doc](https://cassandra.apache.org/doc/latest/) | [DataStax Academy](https://www.datastax.com/learn) |
| 🟡 Neo4j | [neo4j.com/docs](https://neo4j.com/docs/) | [Neo4j Sandbox](https://neo4j.com/sandbox/) |

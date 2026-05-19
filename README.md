# NoSQL com Docker & Docker Compose 🐳

Este projeto de caráter educacional demonstra como executar e interagir de forma rápida com quatro diferentes sistemas de bancos de dados **NoSQL**, cada um representando um paradigma diferente. Através do Docker e do Docker Compose, você poderá rodar todas as instâncias localmente com um único comando, permitindo explorar e comparar suas principais características de forma prática.

---

## 🛠️ Paradigmas de Bancos de Dados Cobertos

| Banco de Dados | Paradigma                  | Imagem Docker                   | Porta Exposta                 | Ferramenta de CLI inclusa |
| :------------- | :------------------------- | :------------------------------ | :---------------------------- | :------------------------ |
| **Redis**      | Chave-Valor                | `redis:alpine`                  | `6379`                        | `redis-cli`               |
| **MongoDB**    | Documento                  | `mongo:8.3`                     | `27017`                       | `mongosh`                 |
| **Cassandra**  | Família de Colunas / Larga | `cassandra:5.0.8-bookworm`      | `9042`                        | `cqlsh`                   |
| **Neo4j**      | Grafo                      | `neo4j:5.26.26-community-ubi10` | `7474` (HTTP) / `7687` (Bolt) | Navegador Web (Interface) |

---

## 🚀 Pré-requisitos

Antes de iniciar, certifique-se de ter instalado em sua máquina:

- **Docker**: [Instruções de Instalação](https://docs.docker.com/get-docker/)
- **Docker Compose**: Geralmente integrado ao Docker Desktop.
- **DataGrip**: [Página Oficial e Download](https://www.jetbrains.com/datagrip/) (ou IDE/cliente SQL/NoSQL de sua preferência).

---

## 🏗️ Como Executar o Projeto

### 1. Iniciar todos os serviços

Para rodar todos os bancos de dados em segundo plano (modo _detached_), execute o seguinte comando no terminal na raiz do projeto:

```bash
docker compose up -d
```

### 2. Verificar o status dos containers

Para garantir que todos os serviços foram iniciados corretamente e conferir as portas expostas:

```bash
docker compose ps
```

### 3. Encerrar os serviços

Caso queira parar e remover os containers mantendo os volumes de dados preservados:

```bash
docker compose down
```

Se desejar remover também os dados salvos nos volumes persistentes, adicione a flag `-v`:

```bash
docker compose down -v
```

### 🛠️ Atalhos via Makefile (Opcional)

Se você tiver o `make` instalado em seu sistema operacional, pode optar por utilizar atalhos simplificados para gerenciar o ambiente e acessar as CLIs:

- **Iniciar todos os serviços:** `make up`
- **Verificar o status:** `make status`
- **Ver logs em tempo real:** `make logs`
- **Parar serviços:** `make down`
- **Limpar tudo (remove volumes e dados):** `make clean`
- **Entrar nos shells interativos:**
  - **Redis:** `make shell-redis`
  - **MongoDB:** `make shell-mongo`
  - **Cassandra:** `make shell-cassandra`

Para ver a lista completa de comandos disponíveis diretamente no terminal:

```bash
make help
```

---

## 💻 Guia de Interação Prática por Banco de Dados

Abaixo, encontram-se instruções rápidas de como conectar a cada serviço e executar comandos simples para fins de teste.

---

### 🔴 1. Redis (Chave-Valor)

O Redis é ideal para cache e armazenamento temporário de alta performance.

- **Conectar via CLI:**

  ```bash
  docker exec -it redis redis-cli
  ```

- **Exemplos de Operações:**

  ```redis
  # Definir uma chave com um valor
  SET usuario:nome "Carlos Silva"

  # Recuperar o valor da chave
  GET usuario:nome

  # Definir uma chave com tempo de expiração (10 segundos)
  SETEX sessao:token 10 "xyz123"

  # Verificar tempo restante de expiração
  TTL sessao:token

  # Sair da CLI
  exit
  ```

---

### 🟢 2. MongoDB (Documento)

Armazena dados no formato BSON (semelhante ao JSON), perfeito para estruturas dinâmicas e escalabilidade.
_Nota: A imagem utiliza autenticação integrada básica (`mongo` / `mongo` como usuário e senha padrão)._

- **Conectar via CLI (`mongosh`):**

  ```bash
  docker exec -it mongo mongosh -u mongo -p mongo
  ```

- **Exemplos de Operações:**

  ```javascript
  // Criar ou selecionar um banco de dados
  use faculdade

  // Inserir um documento em uma coleção 'alunos'
  db.alunos.insertOne({ nome: "Ana Costa", curso: "Ciência da Computação", ano: 2026 })

  // Buscar todos os documentos cadastrados
  db.alunos.find().pretty()

  // Buscar alunos de um curso específico
  db.alunos.find({ curso: "Ciência da Computação" })


  ```

---

### 🔵 3. Apache Cassandra (Família de Colunas)

Ideal para lidar com grandes volumes de dados distribuídos entre vários nós, com alta disponibilidade e sem ponto único de falha.
_Nota: O Cassandra pode levar cerca de 1 a 2 minutos para inicializar completamente. Se a conexão falhar de primeira, aguarde alguns instantes e tente novamente._

- **Conectar via CLI (`cqlsh`):**

  ```bash
  docker exec -it cassandra cqlsh
  ```

- **Exemplos de Operações (CQL):**

  ```sql
  -- Criar um Keyspace (equivalente ao Banco de Dados)
  CREATE KEYSPACE escola WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

  -- Utilizar o Keyspace criado
  USE escola;

  -- Criar uma tabela
  CREATE TABLE estudantes (id int PRIMARY KEY, nome text, email text);

  -- Inserir registros
  INSERT INTO estudantes (id, nome, email) VALUES (1, 'Felipe Souza', 'felipe@email.com');

  -- Consultar dados
  SELECT * FROM estudantes;

  ```

---

### 🟡 4. Neo4j (Grafo)

Focado no relacionamento entre dados. Excelente para redes sociais, sistemas de recomendação e detecção de fraudes.
_Nota: A autenticação está temporariamente desativada (`NEO4J_AUTH=none`) para facilitar o aprendizado rápido local._

- **Conectar via Interface Gráfica (Browser):**
  Abra seu navegador de preferência e acesse: [http://localhost:7474](http://localhost:7474)

- **Exemplos de Operações (Linguagem Cypher):**
  Execute as consultas abaixo na barra de comandos do console Web do Neo4j:

  ```cypher
  // Criar dois nós de Pessoa e um relacionamento de amizade entre eles
  CREATE (p1:Pessoa {nome: 'Maria', idade: 28})
  CREATE (p2:Pessoa {nome: 'João', idade: 30})
  CREATE (p1)-[:AMIGO_DE]->(p2);

  // Buscar e visualizar todos os nós e relacionamentos criados
  MATCH (n) RETURN n;
  ```

---

## 🗄️ Conexão via DataGrip (IDE)

O **DataGrip** (da JetBrains) é uma ferramenta integrada excelente para gerenciar, visualizar e consultar múltiplos bancos de dados SQL e NoSQL em um só lugar. Siga os passos abaixo para configurar a conexão com cada banco de dados no DataGrip:

### 🔴 1. Redis

1. No painel **Database**, clique no botão `+` (New) -> **Data Source** -> **Redis**.
2. No campo **Host**, insira `localhost`.
3. No campo **Port**, mantenha `6379`.
4. No campo **Authentication**, selecione **No Auth** (deixe a senha em branco).
5. Clique em **Test Connection** (se solicitado, permita que o DataGrip faça o download do driver JDBC do Redis) e depois em **OK**.

### 🟢 2. MongoDB

1. Clique no botão `+` -> **Data Source** -> **MongoDB**.
2. No campo **Host**, insira `localhost`.
3. No campo **Port**, insira `27017`.
4. No campo **Authentication**, selecione **User & Password**:
   - **User**: `mongo`
   - **Password**: `mongo`
   - **Database**: `admin` (banco de dados que gerencia a autenticação).
5. _Alternativa:_ Se preferir conectar via URI, mude a opção de conexão para **URL only** e cole:
   `mongodb://mongo:mongo@localhost:27017/?authSource=admin`
6. Clique em **Test Connection** e em **OK**.

### 🔵 3. Apache Cassandra

1. Clique no botão `+` -> **Data Source** -> **Cassandra**.
2. No campo **Host**, insira `localhost`.
3. No campo **Port**, insira `9042`.
4. No campo **Authentication**, selecione **No Auth**.
5. Clique em **Test Connection** e em **OK**.

### 🟡 4. Neo4j (Requer Plugin ou Driver Manual)

O DataGrip **não possui suporte nativo padrão** para o Neo4j. Por isso, para utilizá-lo na IDE, é necessário instalar um plugin ou configurar o driver manualmente:

- **Opção 1: Utilizar um Plugin do Marketplace (Recomendado)**
  1. No DataGrip, acesse **Settings/Preferences** -> **Plugins**.
  2. Pesquise por **Graph Database support** ou **GraphDB for Neo4j** no Marketplace e faça a instalação.
  3. Após reiniciar a IDE, uma nova aba dedicada a Grafos aparecerá.
  4. Configure a conexão apontando para `bolt://localhost:7687` com autenticação definida como **No Auth** (sem usuário/senha).

- **Opção 2: Configurar o Driver JDBC Manualmente**
  1. Baixe o arquivo `.jar` do driver JDBC oficial do Neo4j.
  2. No DataGrip, vá em **Database Explorer** -> `+` (New) -> **Driver**.
  3. Crie um novo driver importando o arquivo `.jar` baixado.
  4. Crie um novo Data Source a partir desse driver informando a URL de conexão: `jdbc:neo4j:bolt://localhost:7687` e sem autenticação.

_Dica: Para o aprendizado rápido e visualização interativa de grafos (nós e arestas), o próprio **Neo4j Browser** em [http://localhost:7474](http://localhost:7474) oferece a melhor experiência e não requer configurações adicionais._

---

## 💾 Persistência de Dados

O projeto está configurado para salvar os dados criados no disco do seu computador, garantindo que nada seja perdido ao reiniciar ou recriar os containers. Isso é feito utilizando os seguintes volumes declarados no final do arquivo `docker-compose.yml`:

- `redis_data`
- `mongo_data`
- `cassandra_data`
- `neo4j_data`

---

## 📚 Sugestões de Estudo e Prática

1. **Desenvolvimento de Aplicações:** Tente construir uma pequena aplicação em Python, Node.js ou Java que conecte em pelo menos dois desses bancos (ex: usar Redis para sessão e MongoDB para o perfil do usuário).
2. **Modelagem de Dados:** Compare como você representaria um sistema de "Seguidores" em Grafo (Neo4j), Relacional (Cassandra), Documento (MongoDB) e Chave-Valor (Redis).
3. **Desempenho e Benchmarks:** Experimente realizar inserções em lote no Redis e no MongoDB para comparar o tempo de resposta das duas tecnologias.

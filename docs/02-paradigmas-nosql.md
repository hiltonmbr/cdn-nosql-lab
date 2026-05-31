# 🧩 Explorando os Modelos de Dados NoSQL

Bancos "NoSQL" não são uma tecnologia única, mas sim um guarda-chuva que abriga sistemas com filosofias muito diferentes de organização de dados.

Neste laboratório, temos a oportunidade única de ter 5 bancos rodando simultaneamente, representando os 5 principais paradigmas do mercado. 

Vamos explorar como cada um organiza a informação e qual problema ele foi desenhado para resolver.

---

## 🐘 1. Relacional Clássico (PostgreSQL)

Antes de ver o novo, relembramos o clássico.

Os dados são organizados rigorosamente em **tabelas** de linhas e colunas. Relacionamentos (*Foreign Keys*) garantem a integridade. A inserção só acontece se o dado obedecer à risca o *schema* previamente desenhado (*Schema-on-write*).

* **Organização Física:** Tabelas interligadas.
* **Pontos Fortes:** Transações complexas 100% seguras (ACID), integridade referencial profunda, flexibilidade absurda para fazer perguntas aos dados via `SQL` (cláusula `JOIN`).
* **Calcanhar de Aquiles:** Dificuldade extrema de escala horizontal e engessamento diante de dados semi-estruturados ou dados com campos que mudam constantemente.
* **Mão na massa:** Abra o notebook `05_postgres.ipynb`.

---

## 🔴 2. Chave-Valor (Redis)

O paradigma mais simples de todos. Funciona literalmente como um dicionário Python gigante em memória (RAM).

Tudo é armazenado no formato **Chave → Valor**. O banco não se importa muito com o que está dentro do "Valor", ele apenas localiza a "Chave" de forma absurdamente veloz.

* **Organização Física:** Tabelas de Hash na Memória RAM.
* **Pontos Fortes:** A leitura e escrita mais rápida do planeta (tempo de resposta na casa dos microssegundos). Excelente para lidar com milhões de acessos simultâneos temporários.
* **Casos de Uso:** Caches de sistemas (ex: guardar temporariamente a página inicial de um site que é montada consultando o PostgreSQL), carrinhos de compras abandonados, ranking em tempo real de games, gerenciamento de sessões de login.
* **Calcanhar de Aquiles:** Se você precisar consultar o banco por um valor (ex: "Me traga todos os usuários cuja idade seja 20"), o Redis não é a ferramenta certa. A busca é primariamente sempre por Chave.
* **Mão na massa:** Abra o notebook `01_redis.ipynb`.

---

## 🟢 3. Orientado a Documentos (MongoDB)

Em vez de linhas amarradas por tabelas, cada registro é um **Documento** independente e auto-contido. O MongoDB armazena esses documentos usando um formato binário de JSON (BSON).

Se um cliente compra três produtos, no modelo Relacional eu guardaria o Cliente em uma tabela e os 3 Produtos em outra tabela conectada. No MongoDB, o documento do Cliente pode ter um `Array` chamado "compras" contendo os produtos dentro dele. A informação fica aglutinada junta.

* **Organização Física:** Coleções de Documentos (JSON/BSON).
* **Pontos Fortes:** Flexibilidade extrema. Um documento "Cliente" pode ter um campo "telefone", e outro documento "Cliente" na mesma coleção pode ter o campo "perfil_instagram". Ideal para desenvolvimento ágil.
* **Casos de Uso:** Catálogos de E-commerce, perfis de usuários mutáveis, CMS (Gerenciamento de Conteúdo como blogs).
* **Calcanhar de Aquiles:** Não deve ser usado se a sua aplicação exige fazer relatórios complexos cruzando dados constantemente de várias coleções distintas (*Joins* são custosos no MongoDB).
* **Mão na massa:** Abra o notebook `02_mongodb.ipynb`.

---

## 🔵 4. Família de Colunas Largas (Cassandra)

Desenvolvido originalmente no Facebook para lidar com a busca na caixa de entrada do usuário.

A arquitetura de hardware é incrível: todos os nós no cluster são iguais (modelo P2P, sem nó Mestre/Escravo). Os dados são distribuídos baseados em um *hash* da chave principal. A modelagem aqui é feita ao contrário: **você primeiro projeta a consulta (o SELECT), e então constrói a tabela sob medida para responder a essa consulta específica.**

* **Organização Física:** Dados agrupados na mesma partição de disco baseados na *Partition Key*, com colunas ordenadas fisicamente.
* **Pontos Fortes:** Pode engolir volumes de escrita estratosféricos sem degradar a performance. É linearmente escalável: se 1 servidor aguenta 100k writes/s, 2 servidores aguentarão 200k writes/s. Altíssima disponibilidade.
* **Casos de Uso:** Dados de IoT (sensores que disparam dados 20 vezes por segundo), Logs de atividades, séries temporais.
* **Calcanhar de Aquiles:** Quase zero flexibilidade na consulta. Se você tentar filtrar por uma coluna que não seja a chave primária ou que não esteja nos índices, a consulta falhará.
* **Mão na massa:** Abra o notebook `03_cassandra.ipynb`.

---

## 🟡 5. Grafos (Neo4j)

A joia da coroa para dados hiper-conectados. O foco não é o dado em si, mas a **relação** entre os dados.

Os dados são organizados em **Nós** (como objetos) e **Arestas** (os relacionamentos direcionados). Ao contrário do relacional, onde as chaves estrangeiras precisam ser avaliadas durante a consulta (*Join* em tempo de execução), em um banco de Grafos, o relacionamento é um "ponteiro físico" no disco, criado assim que o dado é inserido. Navegar pelas conexões é incrivelmente barato.

* **Organização Física:** Nós e Relacionamentos conectados diretamente por ponteiros em memória e disco.
* **Pontos Fortes:** Responde consultas do tipo "amigo de amigo de amigo que comprou produto X" em milissegundos (o que derrubaria um banco relacional via múltiplos *joins*).
* **Casos de Uso:** Redes Sociais, sistemas avançados de recomendação, detecção de fraude de cartões de crédito (análise de padrões de circulação), gestão de redes e TI.
* **Calcanhar de Aquiles:** Não é bom para varreduras simples em massa (ex: somar o salário de todos os funcionários de uma empresa), pois não acessa os dados de forma tabular e contínua.
* **Mão na massa:** Abra o notebook `04_neo4j.ipynb`.

---

> [!TIP]
> **Poliglotismo de Dados (Polyglot Persistence)**
> Na arquitetura de software moderna, as empresas raramente usam um único banco. Um e-commerce gigante guarda o carrinho abandonado no **Redis**, o catálogo dinâmico de produtos no **MongoDB**, recomenda os produtos via **Neo4j** e finaliza a transação financeira da venda através do rigor do **PostgreSQL**. Tudo trabalhando junto!

### Mãos à Obra!

Agora que você tem uma visão nítida do panorama dos bancos, retorne ao [README principal](../README.md) e siga a trilha abrindo os **Notebooks de Laboratório**!

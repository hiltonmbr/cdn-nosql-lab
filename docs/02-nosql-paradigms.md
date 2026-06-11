# 🧩 Exploring NoSQL Data Models

"NoSQL" databases are not a single technology, but rather an umbrella that houses systems with very different data organization philosophies.

In this lab, we have the unique opportunity to have 5 databases running simultaneously, representing the 5 main paradigms in the market.

Let's explore how each one organizes information and what problem it was designed to solve.

---

## 🐘 1. Classic Relational (PostgreSQL)

Before looking at the new, we revisit the classic.

Data is strictly organized into **tables** of rows and columns. Relationships (*Foreign Keys*) guarantee integrity. Insertion only happens if the data strictly follows the previously designed *schema* (*Schema-on-write*).

* **Physical Organization:** Interconnected tables.
* **Strengths:** 100% safe complex transactions (ACID), deep referential integrity, incredible flexibility to query data via `SQL` (`JOIN` clause).
* **Achilles' Heel:** Extreme difficulty with horizontal scaling and rigidity when dealing with semi-structured data or data with constantly changing fields.
* **Hands-on:** Open the notebook `05_postgres.ipynb`.

---

## 🔴 2. Key-Value (Redis)

The simplest paradigm of all. It works literally like a giant Python dictionary in memory (RAM).

Everything is stored in the **Key → Value** format. The database doesn't really care about what's inside the "Value", it just locates the "Key" incredibly fast.

* **Physical Organization:** Hash Tables in RAM.
* **Strengths:** The fastest read and write on the planet (response time in the microsecond range). Excellent for handling millions of temporary concurrent accesses.
* **Use Cases:** System caches (e.g., temporarily storing a website's homepage that is built by querying PostgreSQL), abandoned shopping carts, real-time game rankings, login session management.
* **Achilles' Heel:** If you need to query the database by a value (e.g., "Bring me all users whose age is 20"), Redis is not the right tool. Lookup is primarily always by Key.
* **Hands-on:** Open the notebook `01_redis.ipynb`.

---

## 🟢 3. Document-Oriented (MongoDB)

Instead of rows tied to tables, each record is an independent and self-contained **Document**. MongoDB stores these documents using a binary JSON format (BSON).

If a customer buys three products, in the Relational model you would store the Customer in one table and the 3 Products in another connected table. In MongoDB, the Customer document can have an `Array` called "purchases" containing the products inside it. The information stays grouped together.

* **Physical Organization:** Collections of Documents (JSON/BSON).
* **Strengths:** Extreme flexibility. One "Customer" document can have a "phone" field, and another "Customer" document in the same collection can have the "instagram_profile" field. Ideal for agile development.
* **Use Cases:** E-commerce catalogs, mutable user profiles, CMS (Content Management like blogs).
* **Achilles' Heel:** Should not be used if your application requires complex reports that constantly cross-reference data from multiple collections (*Joins* are costly in MongoDB).
* **Hands-on:** Open the notebook `02_mongodb.ipynb`.

---

## 🔵 4. Wide-Column Family (Cassandra)

Originally developed at Facebook to handle user inbox search.

The hardware architecture is amazing: all nodes in the cluster are equal (P2P model, no Master/Slave node). Data is distributed based on a *hash* of the primary key. Modeling here is done backwards: **you first design the query (the SELECT), and then build the table specifically to answer that particular query.**

* **Physical Organization:** Data grouped in the same disk partition based on the *Partition Key*, with columns physically ordered.
* **Strengths:** Can handle stratospheric write volumes without degrading performance. It is linearly scalable: if 1 server handles 100k writes/s, 2 servers will handle 200k writes/s. Very high availability.
* **Use Cases:** IoT data (sensors that fire data 20 times per second), activity logs, time series.
* **Achilles' Heel:** Almost zero query flexibility. If you try to filter by a column that is not the primary key or is not in the indexes, the query will fail.
* **Hands-on:** Open the notebook `03_cassandra.ipynb`.

---

## 🟡 5. Graphs (Neo4j)

The crown jewel for hyper-connected data. The focus is not the data itself, but the **relationship** between the data.

Data is organized into **Nodes** (like objects) and **Edges** (directed relationships). Unlike relational databases, where foreign keys need to be evaluated during the query (*Join* at runtime), in a Graph database, the relationship is a "physical pointer" on disk, created as soon as the data is inserted. Navigating connections is incredibly cheap.

* **Physical Organization:** Nodes and Relationships directly connected by pointers in memory and disk.
* **Strengths:** Answers queries like "friend of a friend of a friend who bought product X" in milliseconds (which would bring down a relational database through multiple *joins*).
* **Use Cases:** Social Networks, advanced recommendation systems, credit card fraud detection (analysis of circulation patterns), network and IT management.
* **Achilles' Heel:** Not good for simple bulk scans (e.g., summing the salaries of all employees in a company), because it does not access data in a tabular and contiguous manner.
* **Hands-on:** Open the notebook `04_neo4j.ipynb`.

---

> [!TIP]
> **Data Polyglot (Polyglot Persistence)**
> In modern software architecture, companies rarely use a single database. A giant e-commerce store keeps the abandoned cart in **Redis**, the dynamic product catalog in **MongoDB**, recommends products via **Neo4j**, and finalizes the financial transaction of the sale through the rigor of **PostgreSQL**. All working together!

### Hands On!

Now that you have a clear view of the database landscape, return to the main [README](../README.md) and follow the trail by opening the **Lab Notebooks**!

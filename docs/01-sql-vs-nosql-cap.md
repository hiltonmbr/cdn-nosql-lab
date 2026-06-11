# ⚖️ The Scale Challenge: SQL vs NoSQL and the CAP Theorem

Welcome to the theoretical foundation of our **NoSQL Lab**!

Before we dive hands-on with the databases in the *notebooks*, it is essential to understand **why** the NoSQL movement emerged and what problems it attempts to solve.

---

## 📍 The Problem of Scale in Big Data

During the 1980s, 1990s, and early 2000s, Relational Databases (such as **PostgreSQL** which we have in our lab, as well as Oracle, MySQL, etc.) dominated the market absolutely.

However, with the explosion of the internet, companies like Google, Amazon, and Facebook began dealing with an unprecedented volume of data. The traditional relational paradigm faced a physical limit.

### Vertical Scale vs Horizontal Scale

When a relational database needs more capacity (to handle more requests or more data), the standard approach is **Vertical Scaling** (*Scale-up*):
- ⬆️ Add more RAM
- ⬆️ Upgrade the processor to a more powerful one
- ⬆️ Add faster disks

> [!WARNING]
> **The Single Server Limit**
> There is a physical limit to how large (and expensive) a single server can be. If that mega-server fails, all data becomes unavailable. Vertical scaling is finite and extremely costly in the long run.

The industry's answer to this problem was **Horizontal Scaling** (*Scale-out*):
- ➡️ Add multiple common (cheap) servers to the network and make them work together as a single system (a **cluster**).

Relational databases are difficult to scale horizontally efficiently because they guarantee referential integrity (relationships) and transactional consistency across the entire database. This is where the need for new paradigms emerged: **NoSQL**.

---

## 🔐 ACID Guarantees (The Relational World)

**PostgreSQL** (our relational database in the lab) is a prime example of a system that strictly follows **ACID** properties:

- **A (Atomicity):** All or nothing. In a bank transfer transaction, withdrawing from one account and depositing into another are executed as a block. If one fails, the database undoes the other.
- **C (Consistency):** Data is always in a valid state, obeying rules (such as balance >= 0).
- **I (Isolation):** Two concurrent transactions do not interfere with each other.
- **D (Durability):** Once a transaction is committed (the "Commit"), the data is saved even if the server catches fire.

> [!TIP]
> **When to use SQL?**
> For financial systems, billing, payroll, and systems where absolute consistency is non-negotiable and unquestionable, the relational model remains the absolute king.

---

## 🌐 The NoSQL Movement

The term **NoSQL** (*Not Only SQL*) gained traction in 2009 to describe storage systems primarily designed for **native horizontal scaling**, handling *petabytes* of data.

They deliberately forgo certain properties of the relational model (such as native complex *joins* or rigid schema) in exchange for performance, flexibility, and availability.

**Common characteristics of NoSQL databases:**
1. **Flexible Schema (*Schema-on-Read*):** The data structure does not need to be strictly defined in advance. This brilliantly handles semi-structured data (JSON).
2. **Native Horizontal Scalability:** Adding a new server to the network is a routine operation, and the database automatically redistributes the data (classic example: **Cassandra**).

### 🧱 BASE: The Alternative to ACID

While the relational world relies on the rigid ACID model, many NoSQL databases (especially those designed for very high scale) adopt the **BASE** semantics:

- **B**asically **A**vailable: The system guarantees that the application always receives a response, maximizing continuous availability.
- **S**oft state: The system state may change over time, even without new write operations, as replicas spread across the world synchronize in the background.
- **E**ventual consistency: The system does not guarantee that the data will be consistent the millisecond after a write, but it guarantees that **eventually** (usually in milliseconds) all replicas will converge to the final state.

### 🔪 Sharding (Horizontal Partitioning)

Another vital concept in NoSQL is **Sharding**. Instead of trying to place all 10 Terabytes of data on a single giant disk, the database mathematically divides the load across dozens of smaller servers.

When you insert a piece of data, the system uses a **Shard Key** (Partition Key) — such as `User ID` or `Region` — to compute a *hash*. This hash physically determines which server will store the data. This is what allows databases like MongoDB and Cassandra to process hundreds of thousands of requests per second: they parallelize the work!

---

## ⚖️ The CAP Theorem

To understand how distributed databases make architectural choices, there is a fundamental theoretical pillar called the **CAP Theorem**, formulated by Eric Brewer in the year 2000.

The theorem states that it is **impossible** for a distributed data storage system to simultaneously provide the following three guarantees:

1. **C (Consistency):** All nodes (servers) in the cluster see exactly the same data at the same time. If you write data to node A, a read from node B will return the most recent data.
2. **A (Availability):** The system always responds (with success or failure), regardless of the individual state of any node. The system does not "hang."
3. **P (Partition Tolerance):** The system continues to function even if the network connecting the nodes is disrupted (a network partition).

> [!IMPORTANT]
> **The harsh reality of networks**
> In any real distributed system across a network, communication failures **will** happen. Therefore, Partition Tolerance (P) is not optional; it is a constraint of the physical world. Thus, in the event of a network failure, a distributed database must choose between **Consistency** or **Availability**.

### Databases and CAP

In our lab, we have systems that adopt different postures regarding CAP:

- **Cassandra** chooses **AP (Availability and Partition Tolerance)**: If the network goes down, it accepts that different nodes may have slightly outdated versions of the data (Eventual Consistency), but it **never stops responding** and accepting new writes (very high availability).
- **MongoDB** (depending on cluster configuration) tends to focus on **CP (Consistency and Partition Tolerance)**: In case of a severe network failure, it prefers to halt writes to prevent inconsistent data from being read or written.

### 🗳️ Quorum and Tunable Consistency

In NoSQL databases like Cassandra, you are not rigidly stuck with absolute "AP." You can **adjust** the consistency level per query or insert through the concept of **Quorum** (majority).

Imagine a cluster where data is replicated across 3 servers (Replication Factor = 3).
- **Read/Write with Quorum:** You require the majority of nodes (2 out of 3) to confirm the operation. If 1 node goes down, the system continues operating.
- **Read/Write at ONE level (Fast, Less Consistent):** Only 1 node needs to confirm. It is extremely fast, but the data may be outdated compared to other nodes.
- **Read/Write at ALL level (Slow, Very Consistent):** All 3 nodes must confirm. You gain absolute consistency, but lose availability (if 1 node goes down, the operation fails).

> [!TIP]
> Cassandra's magic formula for ensuring Strong Consistency even as an AP database is to guarantee that:
> **Nodes Read + Nodes Written > Replication Factor**.
> Example: Reading from 2 nodes and writing to 2 nodes (in a cluster of 3), you will always intersect with the most recent data!

---

## 🚀 Next Steps

Now that we understand *why* the models changed, we need to understand the *different ways* of organizing information.

Move on to the next article to explore the different paradigms: **[Exploring NoSQL Data Models](./02-nosql-paradigms.md)**.

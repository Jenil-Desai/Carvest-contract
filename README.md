# 💰 Carvest Contract — Decentralized Crowdfunding on Ethereum

**Carvest Contract** is a Solidity smart contract powering a decentralized crowdfunding platform. It allows users to create campaigns, accept donations, and handle refunds in a transparent, trustless manner — without intermediaries.

---

## 📑 Table of Contents

1. [Overview](#-overview)
2. [Tech Stack](#-tech-stack)
3. [Getting Started](#-getting-started)
4. [Setup](#-setup)
5. [Features](#-features)
6. [Demo](#-demo)
7. [Acknowledgments](#-acknowledgments)
8. [License](#-license)

---

## 🌟 Overview

Carvest enables users to launch and participate in crowdfunding campaigns entirely on-chain. Campaign creators set a **goal amount**, **start date**, and **end date**, while supporters can contribute funds securely through Ethereum. If a campaign does not meet its goal by the end date, contributors can claim **refunds** automatically.

---

## 🧠 Tech Stack

| Layer        | Tech            |
|--------------|-----------------|
| Language     | Solidity        |
| Framework    | Foundry (Forge) |
| Package Tool | Bun             |
| Editor       | VS Code         |

---

## 🚀 Getting Started

> **Prerequisites:**
> - [Foundry (Forge)](https://book.getfoundry.sh/)
> - Bun.js
> - Git
> - VS Code

---

## ⚙️ Setup

1. Clone the repository:
   ```bash
   git clone <repo_url>
   ```

2. Navigate into the project folder:

   ```bash
   cd carvest-contract
   ```

3. Install dependencies:

   ```bash
   bun install
   ```

4. Compile and test the contract:

   ```bash
   forge build
   forge test
   ```

---

## 🎯 Features

* 📅 **Campaign Creation** — Users can create campaigns with:

  * Start Date & End Date
  * Goal Amount
  * Campaign Name
  * Description

* 💵 **Donation Support** — Anyone can donate to active campaigns.

* 🔄 **Refund Mechanism** — If a campaign fails to reach its funding goal before the end date, donors can claim refunds.

* 🔍 **Fully On-Chain** — No middlemen, transparent state, and verifiable history.

---

## 📸 Demo

*Backend smart contract — no screenshots provided.*

---

## 🙏 Acknowledgments

*None*

---

## 📜 License

This project is licensed under the **MIT License**.

---

> **Carvest Contract** – Transparent, trustless, and community-powered crowdfunding.

# 🍔 Food Delivery Database Design

This repository contains the **Entity-Relationship Diagram (ERD)** and the corresponding **SQL schema** for a food delivery platform database.

## 📦 Files

- `erd.mmd`: ERD in Mermaid.js format (view with Mermaid Live Editor)
- `ecommerce.sql`: SQL file to create all necessary tables

## 🧩 ERD Overview

The database includes the following core entities:
- `user` — Customers, restaurant owners, and admins
- `restaurant` — Listings of restaurants
- `menu_item` — Menu items offered by restaurants
- `menu_item_image` — Images for menu items
- `order` — Orders placed by users
- `order_item` — Items within each order

## 🔄 Relationships

- A **user** can place many **orders**
- A **restaurant** has many **menu_items**
- A **menu_item** can have many **images**
- An **order** contains many **order_items**
- Each **order_item** references one **menu_item**

## 📊 ERD Preview

Paste the content of `erd.mmd` into [Mermaid Live Editor](https://mermaid.live) to view the diagram.

---

Built with ❤️ for a database design challenge.

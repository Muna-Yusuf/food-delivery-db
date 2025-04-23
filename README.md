# 🍽️ Food Delivery Platform – Relational Database Schema

This repository contains the relational database schema for a food delivery platform. The schema is designed to efficiently manage users, restaurants, menus, orders, and reviews while ensuring data integrity and scalability.

## 📦 Project Overview

The goal of this project is to demonstrate strong database design principles through:

- A clear Entity-Relationship Diagram (ERD)
- A normalized, production-ready PostgreSQL schema
- Proper use of constraints, triggers, and indexing

> This schema is part of a collaborative challenge focused on mastering database architecture for a full-featured e-commerce or service-based application.

---

## 📁 Repository Structure

| File              | Description                                           |
|-------------------|-------------------------------------------------------|
| `ecommerce.sql`   | SQL file with full schema creation, triggers, and indexes |
| `Final ERD.png`         | ERD image illustrating entities and relationships     |
| `README.md`       | Project documentation and implementation overview     |

---

## 🧱 Database Entities

### 👤 Users
Stores customer, restaurant owner, and admin data.

- Includes role-based access via the `user_role` ENUM.
- Validates phone numbers and ensures unique emails.

### 🍽️ Restaurants
Details about registered restaurants and their cuisine type.

- Linked to a `cuisine` category.
- Supports automatic `updated_at` timestamping.

### 🍛 Menu Items
Represents dishes offered by each restaurant.

- Tracks availability and pricing.
- Includes image support via a related table.

### 📸 Menu Item Images
Stores image URLs for menu items.

### 🧾 Orders
Represents a customer order with delivery details and order status.

- Tracks status using the `order_status` ENUM.
- Linked to both the customer and the restaurant.

### 📦 Order Items
Detailed list of menu items in a specific order, including quantity and price.

### ⭐ Reviews
User-generated reviews of restaurants with rating and comments.

### 🍴 Cuisine
Defines types of cuisine (e.g., Italian, Chinese).

---

## ✅ Key Features

- **ENUM Types**  
  - `user_role`: `customer`, `restaurant_owner`, `admin`  
  - `order_status`: `pending`, `confirmed`, `preparing`, `in_transit`, `delivered`, `cancelled`

- **Constraints & Validations**
  - Phone number format validation
  - Rating and pricing checks
  - Unique constraints on emails and cuisine names

- **Referential Integrity**
  - Foreign keys with `ON DELETE CASCADE`
  - Logical relationship mapping across entities

- **Timestamps & Triggers**
  - Auto-updating `updated_at` on record modification via triggers

- **Indexes**
  - Speeds up lookups by email, order status, and cuisine

---

**Built with ❤️ for a database design challenge.**

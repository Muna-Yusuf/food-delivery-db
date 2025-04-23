-- Users
CREATE TABLE user (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password_hash TEXT,
    phone VARCHAR(20),
    address TEXT,
    role VARCHAR(50)
);

-- Restaurants
CREATE TABLE restaurant (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    address TEXT,
    cuisine_type VARCHAR(100),
    rating DECIMAL(3, 2)
);

-- Menu Items
CREATE TABLE menu_item (
    id SERIAL PRIMARY KEY,
    restaurant_id INTEGER REFERENCES restaurant(id) ON DELETE CASCADE,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    is_available BOOLEAN DEFAULT true
);

-- Menu Item Images
CREATE TABLE menu_item_image (
    id SERIAL PRIMARY KEY,
    menu_item_id INTEGER REFERENCES menu_item(id) ON DELETE CASCADE,
    image_url TEXT
);

-- Orders
CREATE TABLE "order" (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES user(id),
    restaurant_id INTEGER REFERENCES restaurant(id),
    status VARCHAR(50),
    total_price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order Items
CREATE TABLE order_item (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES "order"(id) ON DELETE CASCADE,
    menu_item_id INTEGER REFERENCES menu_item(id),
    quantity INTEGER,
    price DECIMAL(10, 2)
);

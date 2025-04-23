-- Create ENUM types
CREATE TYPE user_role AS ENUM ('customer', 'restaurant_owner', 'admin');
CREATE TYPE order_status AS ENUM ('pending', 'confirmed', 'preparing', 'in_transit', 'delivered', 'cancelled');

-- Users
CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    phone VARCHAR(20) CHECK (phone ~ '^\+?[0-9]{8,15}$'),
    address TEXT NOT NULL,
    role user_role NOT NULL DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Cuisine Types
CREATE TABLE cuisine (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

-- Restaurants
CREATE TABLE restaurant (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    cuisine_id INTEGER REFERENCES cuisine(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reviews
CREATE TABLE review (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES "user"(id) ON DELETE CASCADE,
    restaurant_id INTEGER REFERENCES restaurant(id) ON DELETE CASCADE,
    rating DECIMAL(2,1) NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Menu Items
CREATE TABLE menu_item (
    id SERIAL PRIMARY KEY,
    restaurant_id INTEGER REFERENCES restaurant(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    is_available BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Menu Item Images
CREATE TABLE menu_item_image (
    id SERIAL PRIMARY KEY,
    menu_item_id INTEGER REFERENCES menu_item(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL
);

-- Orders
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES "user"(id),
    restaurant_id INTEGER REFERENCES restaurant(id),
    status order_status NOT NULL DEFAULT 'pending',
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price >= 0),
    delivery_address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order Items
CREATE TABLE order_item (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
    menu_item_id INTEGER REFERENCES menu_item(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0)
);

-- Indexes
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_restaurant_cuisine ON restaurant(cuisine_id);

-- Trigger function for updated_at
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers
CREATE TRIGGER update_user_modified
BEFORE UPDATE ON "user"
FOR EACH ROW EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_restaurant_modified
BEFORE UPDATE ON restaurant
FOR EACH ROW EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_menu_item_modified
BEFORE UPDATE ON menu_item
FOR EACH ROW EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_orders_modified
BEFORE UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION update_modified_column();

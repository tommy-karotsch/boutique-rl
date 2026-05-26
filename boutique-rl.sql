CREATE DATABASE IF NOT EXISTS boutique_rl
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE boutique_rl;

CREATE TABLE users (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(150) UNIQUE NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    password        VARCHAR(255) NOT NULL,
    role            ENUM('user', 'admin') DEFAULT 'user',
    address         TEXT NOT NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL
);

CREATE TABLE colors (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    hex_code        VARCHAR(7) NOT NULL
);

CREATE TABLE rarities (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    color_code      VARCHAR(7) NOT NULL 
);

CREATE TABLE items (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(150) NOT NULL,
    description     TEXT NOT NULL,
    price           DECIMAL(10,2) NOT NULL,
    stock           INT NOT NULL,
    image           VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
    id                  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id             INT UNSIGNED NOT NULL,
    status              ENUM('pending', 'paid', 'shipped', 'delivered', 'cancelled') NOT NULL DEFAULT 'pending',
    total               DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    delivery_address    TEXT NOT NULL,
    ordered_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT
);

CREATE TABLE order_items (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quantity        INT UNSIGNED NOT NULL DEFAULT 1,
    unit_price      DECIMAL(10,2) NOT NULL,
    order_id        INT UNSIGNED NOT NULL,
    item_id         INT UNSIGNED NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE RESTRICT
);

CREATE TABLE carts (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id         INT UNSIGNED NOT NULL UNIQUE,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE cart_items (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quantity        INT UNSIGNED NOT NULL DEFAULT 1,
    cart_id         INT UNSIGNED NOT NULL,
    item_id         INT UNSIGNED NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE,
    UNIQUE KEY unique_cart_item (cart_id, item_id)
);


INSERT INTO categories (name) VALUES
    ('Voiture'),
    ('Sticker'),
    ('Roues'),
    ('Boost'),
    ('Traînée'),
    ('Explosion de but'),
    ('Chapeau'),
    ('Antenne');

INSERT INTO rarities (name, color_code) VALUES
    ('Commun',      '#B0B0B0'),
    ('Peu commun',  '#44C864'),
    ('Rare',        '#4F97E1'),
    ('Très rare',   '#9E4FE1'),
    ('Importé',     '#E14F4F'),
    ('Exotique',    '#FFD700'),
    ('Marché noir', '#000000'),
    ('Limité',      '#FF8C00');

INSERT INTO colors (name, hex_code) VALUES
    ('Titanium White', '#F5F5F5'),
    ('Noir',           '#1A1A1A'),
    ('Pourpre',        '#DC143C'),
    ('Bleu ciel',      '#87CEEB'),
    ('Cobalt',         '#0047AB'),
    ('Vert',           '#228B22'),
    ('Citron vert',    '#75cd32'),
    ('Safran',         '#FFA500'),
    ('Orange',         '#FF6600'),
    ('Rose',           '#FF69B4'),
    ('Violet',         '#8B00FF'),
    ('Gris',           '#808080'),
    ('Terre de sienne','#A0522D');
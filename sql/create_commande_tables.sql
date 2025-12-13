-- =====================================================
-- SQL Script for Orders (Commande) Tables
-- Run this in phpMyAdmin to create the required tables
-- =====================================================

-- Create the commande (orders) table
CREATE TABLE IF NOT EXISTS commande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT DEFAULT NULL,
    user_email VARCHAR(255) NOT NULL,
    user_fullname VARCHAR(255),
    subtotal DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    discount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_user_email (user_email),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the commande_item (order items) table
CREATE TABLE IF NOT EXISTS commande_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    item_total DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (commande_id) REFERENCES commande(id) ON DELETE CASCADE,
    INDEX idx_commande_id (commande_id),
    INDEX idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Explanation of table structure:
-- =====================================================
-- 
-- commande table:
--   - id: Primary key, auto-increment
--   - user_id: Optional link to users table
--   - user_email: Email of the customer
--   - user_fullname: Full name of the customer
--   - subtotal: Sum of all items before discount
--   - discount: Discount amount applied
--   - total: Final amount after discount
--   - status: Order status (PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED)
--   - created_at: When the order was placed
--
-- commande_item table:
--   - id: Primary key, auto-increment
--   - commande_id: Foreign key to commande table
--   - product_id: Reference to the product
--   - product_name: Product name at time of order (stored for history)
--   - product_price: Product price at time of order (stored for history)
--   - quantity: Number of items ordered
--   - item_total: Total for this line item (price × quantity)
--
-- =====================================================

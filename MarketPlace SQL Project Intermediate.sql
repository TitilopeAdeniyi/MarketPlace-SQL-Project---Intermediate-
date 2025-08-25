-- Part 1: Creating Database MarketPlace
SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE IF NOT EXISTS MarketPlace;
USE MarketPlace;

-- Create table Products
CREATE TABLE IF NOT EXISTS products (
id INT auto_increment primary key,
product_name VARCHAR(50) NOT NULL,
product_source VARCHAR(50) NOT NULL,
product_weight DECIMAL(10,2),
product_pricePerKg DECIMAL (10,2),
product_season VARCHAR(50),
product_cutType VARCHAR(50),
product_isOrganic TINYINT(1) DEFAULT 0 -- 0 = Not Organic, 1 = Organic
);

INSERT INTO products (product_name, product_source, product_weight, product_pricePerKg, product_season, product_cutType, product_isOrganic)
VALUES
('Apple', 'Greensboro', 20.0, 2.0, 'Summer', NULL, 0),
('DragpnFruit', 'Charlotte', 12.5, 3.50, 'Summer', 'Whole', 1),
('Carrot', 'Raleigh', 20.0, 1.75, 'Winter', 'Sliced', 0),
('Broccoli', 'Greensboro', 8.4, 2.80, 'Autumn', NULL, 1),
('Potato', 'Durham', 30.0, 1.20, 'Spring', 'Diced', 0),
('Strawberry', 'Wilmington', 6.7, 5.00, 'Summer', 'Halved', 1),
('Tomato', 'Asheville', 15.3, 2.10, 'Autumn', 'Whole', 0),
('Cucumber', 'Cary', 10.0, 1.90, 'Spring', NULL, 0),
('Peach', 'Fayetteville', 25.0, 3.25, 'Summer', 'Sliced', 1),
('Onion', 'Gastonia', 18.0, 1.50, 'Winter', 'Diced', 0),
('Garlic', 'Chapel Hill', 5.0, 6.75, 'Autumn', 'Minced', 1),
('Blueberry', 'High Point', 7.2, 4.50, 'Summer', NULL, 1),
('Pumpkin', 'Concord', 45.0, 2.00, 'Autumn', 'Chunked', 0),
('Zucchini', 'Jacksonville', 22.5, 2.40, 'Spring', 'Sliced', 0),
('Spinach', 'Hickory', 9.0, 3.10, 'Winter', NULL, 1),
('Beetroot', 'Rocky Mount', 14.8, 2.70, 'Autumn', 'Grated', 0),
('Corn', 'Burlington', 40.0, 1.60, 'Summer', 'Whole', 0),
('Lettuce', 'Kannapolis', 13.2, 2.30, 'Spring', NULL, 1),
('Mango', 'Wilson', 16.7, 4.80, 'Summer', 'Sliced', 1),
('Celery', 'Apex', 11.5, 1.95, 'Winter', 'Chopped', 0),
('Radish', 'Goldsboro', 6.3, 2.25, 'Spring', NULL, 0);
-- View Products Table
SELECT *FROM products;

-- Display Total Weight & Value by Season
-- This section displays the total weight and value of produce
-- For each season.
SELECT product_season,
SUM(product_weight) as total_weight,
SUM(product_weight * product_pricePerKg) AS total_USD
FROM products
GROUP BY product_season;

-- Display 5 Most Expensive Products (Per Kg)
SELECT product_name, product_pricePerKg
FROM products
ORDER BY product_pricePerKg DESC
LIMIT 5;

-- Display Tally of Organic vs. Non-Organic Products
SELECT
	CASE WHEN product_isOrganic = 1 THEN 'Organic' ELSE 'Non-Organic' END AS category,
    COUNT(*) AS count
    FROM products
    GROUP BY product_isOrganic
    
    -- Average Price Per Kg by Cut Type (Excluding Null Values)
SELECT product_cutType,
	AVG(product_pricePerKg) AS avg_price
FROM products
WHERE product_cutType IS NOT NULL
GROUP BY product_cutType;

-- Display Missing Cut Type Values

SELECT * FROM products
WHERE product_cutType IS NULL;

-- View Showing Count Of Organic Products Per Season
CREATE OR REPLACE VIEW organic_produce_count_per_season AS
SELECT
    product_season,
    COUNT(*) AS organic_product_count
FROM products
WHERE product_isOrganic = 1
GROUP BY product_season
ORDER BY product_season;
SELECT * FROM organic_produce_count_per_season;

-- View Showing Average Price Per Kg of Organic Produce Per Season
CREATE OR REPLACE VIEW organic_produce_avg_price_per_season AS
SELECT
    product_season,
    AVG(product_pricePerKg) AS avg_price_per_kg
FROM products
WHERE product_isOrganic = 1
GROUP BY product_season
ORDER BY product_season;
SELECT * FROM organic_produce_avg_price_per_season;

-- View Showing Total Weight Of Organic Produce Per Season
CREATE OR REPLACE VIEW organic_produce_total_weight_per_season AS
SELECT
    product_season,
    SUM(product_weight) AS total_weight_kg
FROM products
WHERE product_isOrganic = 1
GROUP BY product_season
ORDER BY product_season;
SELECT * FROM organic_produce_total_weight_per_season;

-- Part 2: Adding Suppliers 

-- Creating suppliers Table
CREATE TABLE suppliers (
supplier_id INT auto_increment PRIMARY KEY,
supplier_name VARCHAR(100) NOT NULL,
supplier_location VARCHAR(100),
supplier_contact VARCHAR(50)
);
-- Inserting Supplier Information
INSERT INTO suppliers (supplier_name, supplier_location, supplier_contact)
VALUES
('Future Farms Co.', 'Raliegh, NC', '919-555-0400'),
('Blue Harvest LLC','Icard, NC', '828-555-0123'),
('Morganic Valley', 'Koontzville, NC', '336-555-7809');

-- Alter products Table To Include Supplier ID
ALTER TABLE products
ADD COLUMN supplier_id INT,
ADD CONSTRAINT fk_supplier
	FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
	ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Update Each Product With Supplier Id 
UPDATE products SET supplier_id = 2 WHERE product_name = 'Apple';
UPDATE products SET supplier_id = 1 WHERE product_name = 'DragpnFruit';
UPDATE products SET supplier_id = 3 WHERE product_name = 'Carrot';
UPDATE products SET supplier_id = 2 WHERE product_name = 'Broccoli';
UPDATE products SET supplier_id = 1 WHERE product_name = 'Potato';
UPDATE products SET supplier_id = 3 WHERE product_name = 'Strawberry';
UPDATE products SET supplier_id = 2 WHERE product_name = 'Tomato';
UPDATE products SET supplier_id = 1 WHERE product_name = 'Cucumber';
UPDATE products SET supplier_id = 2 WHERE product_name = 'Peach';
UPDATE products SET supplier_id = 3 WHERE product_name = 'Onion';
UPDATE products SET supplier_id = 1 WHERE product_name = 'Garlic';
UPDATE products SET supplier_id = 2 WHERE product_name = 'Blueberry';
UPDATE products SET supplier_id = 3 WHERE product_name = 'Pumpkin';
UPDATE products SET supplier_id = 1 WHERE product_name = 'Zucchini';
UPDATE products SET supplier_id = 2 WHERE product_name = 'Spinach';
UPDATE products SET supplier_id = 3 WHERE product_name = 'Beetroot';
UPDATE products SET supplier_id = 1 WHERE product_name = 'Corn';
UPDATE products SET supplier_id = 2 WHERE product_name = 'Lettuce';
UPDATE products SET supplier_id = 3 WHERE product_name = 'Mango';
UPDATE products SET supplier_id = 1 WHERE product_name = 'Celery';
UPDATE products SET supplier_id = 2 WHERE product_name = 'Radish';

-- Part 3: Implementing Stored Prodecures To Auto-Update 
-- Prices Based On Weight
DELIMITER $$

CREATE PROCEDURE UpdatePricesByWeight(
    IN weight_threshold DECIMAL(10,2),
    IN increase_percent DECIMAL(5,2)
)
BEGIN
-- Update products with weight above threshold
    UPDATE products
    SET product_pricePerKg = product_pricePerKg * (1 + increase_percent / 100)
    WHERE product_weight > weight_threshold;
END$$

DELIMITER ;

-- Call Procedure 
-- Increase price by 4.79% for products weighting more than 15 kgs
CALL UpdatePricesByWeight(15.00, 4.79);

SELECT product_name, product_weight, product_pricePerKg FROM products;

-- Part 4: Creating Triggers To Log Changes 
-- Product Price Per Kg

-- Creating Product Price Log
CREATE TABLE product_price_log (
log_id INT AUTO_INCREMENT PRIMARY KEY,
product_id INT,
old_price DECIMAL (10,2),
new_price DECIMAL (10,2),
changed_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
changed_by VARCHAR(50) DEFAULT 'system'
);
select * FROM product_price_log;

-- Trigger Creation
DELIMITER $$

CREATE TRIGGER before_products_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN


    -- Log price change
    IF OLD.product_pricePerKg <> NEW.product_pricePerKg THEN
        INSERT INTO product_price_log (
            product_id,
            old_price,
            new_price,
            changed_at,
            changed_by
        )
        VALUES (
            OLD.id,
            OLD.product_pricePerKg,
            NEW.product_pricePerKg,
            NOW(),
            USER()
        );
    END IF;
END$$

DELIMITER ;    
    
 SELECT * FROM product_price_log ORDER BY changed_at DESC;



-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'workshop_week1' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS workshop_week1;
CREATE DATABASE workshop_week1;
-- connect via psql
\c workshop_week1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;

---
--- CREATE tables
---

CREATE TABLE products (
    id SERIAL,
    name TEXT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    supplier_id INT,
    category_id INT,
    PRIMARY KEY (id)
);


CREATE TABLE categories (
    id SERIAL,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    picture TEXT,
    PRIMARY KEY (id)
);


-- Task 1
CREATE TABLE suppliers (
    id SERIAL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);


-- Task 2
CREATE TABLE customers (
    id SERIAL,
    company_name TEXT NOT NULL,
    PRIMARY KEY (id)
);


-- Task 3
CREATE TABLE employees (
    id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    reports_to INT,     -- Bonus task 
    PRIMARY KEY (id)
);


-- Task 4
CREATE TABLE orders (
    id SERIAL,
    date DATE,
    customer_id INT NOT NULL,
    employee_id INT,
    PRIMARY KEY (id)
);


-- Task 5
CREATE TABLE orders_products (
    product_id INT,
    order_id INT,
    quantity INT NOT NULL,
    discount NUMERIC NOT NULL,
    PRIMARY KEY (product_id, order_id)
);


-- Task 6
CREATE TABLE territories (
    id SERIAL,
    description TEXT NOT NULL,
    PRIMARY KEY (id)
);


-- Task 7
CREATE TABLE employees_territories (
    employee_id INT,
    territory_id INT,
    PRIMARY KEY (employee_id, territory_id)
);


-- Task 8
CREATE TABLE offices (
    id SERIAL,
    address_line TEXT NOT NULL,
    territory_id INT UNIQUE NOT NULL,
    PRIMARY KEY (id)
);


-- Task 9
CREATE TABLE us_states (
    id SERIAL,
    name TEXT UNIQUE NOT NULL,
    abbreviation CHARACTER(2) UNIQUE NOT NULL,
    PRIMARY KEY (id)
);


---
--- Add foreign key constraints
---

-- PRODUCTS

ALTER TABLE products
ADD CONSTRAINT fk_products_categories 
FOREIGN KEY (category_id) 
REFERENCES categories;


-- Task 10: Orders

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers 
FOREIGN KEY (customer_id) 
REFERENCES customers;


ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees 
FOREIGN KEY (employee_id) 
REFERENCES employees;

-- Task 11

ALTER TABLE products
ADD CONSTRAINT fk_products_suppliers 
FOREIGN KEY (supplier_id) 
REFERENCES suppliers;


-- Task 12: Orders-Products

ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_products 
FOREIGN KEY (product_id) 
REFERENCES products;


ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_orders 
FOREIGN KEY (order_id) 
REFERENCES orders;


-- Task 13: Employees-Territories

ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_territories 
FOREIGN KEY (territory_id) 
REFERENCES territories;


ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_employees 
FOREIGN KEY (employee_id) 
REFERENCES employees;


-- Task 14: Offices

ALTER TABLE offices
ADD CONSTRAINT fk_offices_territories
FOREIGN KEY (territory_id)
REFERENCES territories;


-- Employees (Bonus)

ALTER TABLE employees
ADD CONSTRAINT fk_employees_employees 
FOREIGN KEY (reports_to) 
REFERENCES employees;
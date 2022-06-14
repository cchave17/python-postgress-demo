RESULT_SETS = {
    "TASK": {
        1: {
            1: "SELECT * FROM categories \n"
            "ORDER BY category_id;",

            2: "SELECT DISTINCT city \n"
            "FROM employees \n"
            "ORDER BY city DESC; \n",

            3: "SELECT product_id, product_name \n"
            "FROM products \n"
            "WHERE discontinued = true \n"
            "ORDER BY product_id; \n",

            4: "SELECT first_name, last_name \n"
            "FROM employees \n"
            "WHERE reports_to IS NULL \n"
            "ORDER BY employee_id; \n",

            5: "SELECT product_name \n"
            "FROM products \n"
            "WHERE units_in_stock <= reorder_level \n" 
            "AND discontinued = false \n"
            "AND units_on_order > 0"
            "ORDER BY product_id; \n"
        },
        2: {
            1: "SELECT COUNT(*) FROM orders; \n",

            2: "SELECT customer_id, COUNT(order_id) AS order_count \n"
            "FROM orders \n"
            "GROUP BY customer_id \n"
            "ORDER BY order_count DESC, customer_id; \n",

            3: "SELECT ship_address, COUNT(*) AS order_count \n"
            "FROM orders \n"
            "GROUP BY ship_address \n"
            "ORDER BY order_count DESC \n"
            "LIMIT 1; \n",

            4: "SELECT customer_id, SUM(freight) \n"
            "FROM orders \n"
            "GROUP BY customer_id \n"
            "HAVING SUM(freight) > 500 \n"
            "ORDER BY customer_id; \n",

            5: "WITH shippers_per_customer AS ( \n"
            "SELECT COUNT(DISTINCT ship_via) AS shipper_count \n"
            "FROM orders \n"
            "GROUP BY customer_id \n"
            ") SELECT AVG(shipper_count) \n" 
            "FROM shippers_per_customer; \n"
        },
        3: {
            1: "SELECT p.product_name, c.category_name \n" 
            "FROM products p \n"
            "JOIN categories c ON p.category_id = c.category_id \n" 
            "ORDER BY p.product_id; \n"
            ,

            2: "SELECT DISTINCT r.region_description, t.territory_description, e.last_name, e.first_name \n"
            "FROM employees e \n"
            "JOIN employees_territories et ON e.employee_id = et.employee_id \n"
            "JOIN territories t ON et.territory_id = t.territory_id \n"
            "JOIN regions r ON t.region_id = r.region_id \n"
            "ORDER BY r.region_description, t.territory_description, e.last_name, e.first_name; \n",

            3: "SELECT s.state_name, s.state_abbr, c.company_name \n"
            "FROM us_states s \n"
            "LEFT JOIN customers c ON s.state_abbr=c.region \n"
            "ORDER BY state_name; \n",

            4: "SELECT t.territory_description, r.region_description \n" 
            "FROM territories t \n"
            "JOIN regions r ON t.region_id = r.region_id \n" 
            "WHERE t.territory_id NOT IN ( \n"
            "SELECT et.territory_id FROM employees_territories et \n"
            ") \n"
            "ORDER BY t.territory_id; \n",

            5: "SELECT company_name, address, city, region, postal_code, country FROM customers \n"
            "UNION \n"
            "SELECT company_name, address, city, region, postal_code, country FROM suppliers \n"
            "ORDER BY company_name; \n",

            "BONUS": "SELECT c.company_name, SUM(od.quantity) AS total_quant \n" 
            "FROM order_details od \n"
            "JOIN orders o ON od.order_id = o.order_id \n"
            "JOIN customers c ON o.customer_id = c.customer_id \n"
            "GROUP BY c.customer_id \n"
            "HAVING SUM(od.quantity) >= 500 \n"
            "ORDER BY total_quant DESC; \n"
        }
    }
}

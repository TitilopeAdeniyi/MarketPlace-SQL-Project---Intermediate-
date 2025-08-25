This SQL-based project simulates a produce marketplace system, managing products, suppliers, seasonal trends, pricing, and organic certifications. It’s designed to demonstrate end-to-end SQL capabilities including database design, data manipulation, stored procedures, views, triggers, and basic reporting. The system reflects real-world business logic like bulk price updates, inventory sourcing, and data analytics — all entirely within SQL.
Project Goals
- Design a normalized SQL database for managing produce inventory
- Track product attributes like weight, price per kg, season, cut type, and organic status
- Introduce supplier relationships
- Implement dynamic pricing updates using stored procedures
- Create views for reusable analytics and reporting
- Use triggers to log sensitive updates (e.g., price changes)
- Build meaningful queries and insights to support decision-making

- Part 1: Products Table and Reporting
   Table Creation
We begin by creating the products table with appropriate fields. The product_isOrganic column helps distinguish between organic and non-organic items.
 Data Insertion
20 diverse entries are inserted, covering a range of vegetables, fruits, and herbs. Each entry includes seasonal availability, weight, price, and cut type where applicable.

Reporting Queries

Total Weight & Value by Season:
Calculates the total weight and total monetary value of products grouped by season.

Top 5 Most Expensive Products (Per Kg):
Helps identify premium or high-margin items.

Tally of Organic vs Non-Organic:
Uses a CASE statement to show how many organic vs non-organic products are in stock.

Average Price Per Kg by Cut Type:
Useful for analyzing pricing strategies by cut/preparation type.

Missing Cut Type Values:
Lists products without a defined cutType, highlighting data gaps.

Views for Analytics

Three custom views are created:

organic_produce_count_per_season:
Counts the number of organic products per season.

organic_produce_avg_price_per_season:
Shows the average price per kg of organic products by season.

organic_produce_total_weight_per_season:
Aggregates total weight of organic products per season.

- Part 2: Suppliers and Relationships
 suppliers Table

This table stores supplier metadata and creates a one-to-many relationship with products.

Foreign Key Constraint

The supplier_id is added to the products table.

ON DELETE SET NULL: If a supplier is deleted, associated products retain their data but lose the supplier link.

ON UPDATE CASCADE: Supplier updates cascade to associated products.

 Supplier Mapping

Each product is manually linked to a supplier, showcasing multi-vendor support.

Part 3: Stored Procedures
 UpdatePricesByWeight Procedure

This stored procedure dynamically updates product prices for items that exceed a specified weight.

Parameters:

weight_threshold: the weight limit

increase_percent: percentage increase in price

Use Case Example:

CALL UpdatePricesByWeight(15.00, 4.79);

This increases the price of all products weighing over 15 kg by 4.79%.

Part 4: Triggers and Audit Logging
 product_price_log Table

Logs every price change made to products, tracking:

product_id

old_price

new_price

Timestamp (changed_at)

changed_by (defaults to system or user)

⚙ before_products_update Trigger

A BEFORE UPDATE trigger watches for any changes to product_pricePerKg. If a change is detected, a record is inserted into the log table.

This adds transparency and accountability for sensitive financial changes.

And Finally!!!
Future Improvements

Here are areas for extending this project to make it even more advanced:

Feature	Description
Product Categories	Add a categories table for better normalization
Inventory Tracking	Track stock-in/out over time with logs
User Roles & Access	Simulate access for suppliers vs analysts
Data Validation Constraints	Add CHECK constraints to enforce rules
Indexing	Create indexes to improve query performance
ETL Pipeline Simulation	Create a staging table for external data import
Dashboards	Connect to Power BI/Tableau for visual reports



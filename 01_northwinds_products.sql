-- 1) What is the name of the table that holds the items Northwind sells?
SELECT * 
FROM northwind.products;
-- products

-- 2) Write a query to list the product id, product name, and unit price of every product.
SELECT ProductID, ProductName, UnitPrice 
FROM northwind.products;

-- 3) Write a query to list the product id, product name, and unit price of every product. 
-- Except this time, order then in ascending order by price
SELECT ProductID, ProductName, UnitPrice 
FROM northwind.products 
ORDER BY UnitPrice;

-- 4) What are the products that we carry where the unit price is $7.50 or less?
SELECT ProductName, UnitPrice 
FROM northwind.products 
WHERE UnitPrice <= 7.5;

-- 5) What are the products that we carry where we have at least 100 units on hand? 
-- Order them in descending order by price
SELECT ProductName, ProductID, UnitPrice 
FROM northwind.products 
WHERE UnitsInStock > 100 
ORDER BY UnitPrice DESC;

-- 6) What are the products that we carry where we have at least 100 units on hand? 
-- Order them in descending order by price. If two or more have the same price, 
-- list those in ascending order by product name.
SELECT ProductName, ProductID, UnitPrice
FROM northwind.products
WHERE UnitsInStock > 100
ORDER BY UnitPrice DESC, ProductName ASC;

-- 7) What are the products that we carry where we have no units on hand, but 1
-- or more units of them on backorder? Order them by product name.
SELECT ProductName, UnitsInStock, UnitsOnOrder
FROM northwind.products
WHERE UnitsInStock = 0 AND UnitsOnOrder >= 1
ORDER BY ProductName;

-- 8) What is the name of the table that holds the types (categories) of the items
-- Northwind sells?
-- northwind.categories

-- 9) Write a query that lists all of the columns and all the rows of the categories
-- table? What is the category id of seafood?
SELECT *
FROM northwind.categories;
-- Seafood is ID 8

-- 10)  Examine the Products table. How does it identify the type (category) of
-- each item sold? Write a query to list all of the seafood items we carry.
-- The Products tables has a CategoryID column that corresponds with the ID value given in the Categories table.
-- So in this instance, anything in CategoryID 8 is Seafood.
SELECT *
FROM northwind.products
WHERE CategoryID = 8;

-- 11) What are the first and last names of all of the Northwind employees?
SELECT FirstName, LastName
FROM northwind.employees;

-- 12) What employees have "manager" in their titles?
SELECT *
FROM northwind.employees
WHERE Title = 'Manager';
-- None of them have manager in their titles

-- 13)  List the distinct job titles in employees.
SELECT DISTINCT Title
FROM northwind.employees;
-- Sales Rep | VP, Sales | Sales Manager | Inside Sales Coordinator

-- 14)   What employees have a salary that is between $2000 and $2500
SELECT FirstName, LastName, Title, Salary
FROM northwind.employees
WHERE Salary > 2000 AND Salary < 2500;
-- Andrew Fuller, Michael Suyama, Laura Callahan, Anne Dodsworth

-- 15) List all the information about all of Northwind's suppliers.
SELECT *
FROM northwind.suppliers;

-- 16) Examine the Products table. How do you know what supplier supplies each product? 
-- Write a query to list all the items that "Tokyo Traders" supplies to Northwind.
-- CompanyName = Tokyo Traders | SupplierID = 4
-- You can identify who the suppliers are based on the SupplierID Number. Since Tokyo Traders' SupplierID = 4
-- Any product listed in the Products tables by SupplierID 4 will come from them.
SELECT *
FROM northwind.products
WHERE SUpplierID = 4;
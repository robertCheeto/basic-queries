USE northwind;

-- 1) Add a new supplier.
INSERT INTO suppliers(SupplierID, CompanyName)
VALUES (30, "Mann Co");


-- 2) Add a ne product provided by that supplier.
INSERT INTO products(ProductID, ProductName, SupplierID, UnitPrice)
VALUES (78, "Australium", 30, 200);


-- 3) List all products and their suppliers.
SELECT
	P.ProductID, 
    P.ProductName,
    P.UnitPrice,
    S.CompanyName
FROM 
	products AS P
JOIN suppliers AS S 
	ON (S.SupplierID = P.SupplierID)
ORDER BY 
	P.ProductID DESC;
    

-- 4) Raise the price of your new product by 15%.
UPDATE products
SET UnitPrice = UnitPrice * (1 + 0.15)
WHERE ProductID = 78;


-- 5) List the products and prices of all products from that supplier.
SELECT
	P.ProductID, 
    P.ProductName,
    P.UnitPrice,
    S.CompanyName
FROM 
	products AS P
JOIN suppliers AS S 
	ON (S.SupplierID = P.SupplierID)
WHERE S.SupplierID = 30;


-- 6) Delete the new product.
DELETE FROM products
WHERE ProductID = 78;


-- 7) Delete the new supplier.
DELETE FROM suppliers
WHERE SupplierID = 30;


-- 8) List all products.
SELECT
	*
FROM
	products;


-- 9) List all suppliers.
SELECT
	*
FROM
	suppliers;
USE Factory;

-- Basic
SELECT * FROM Client;

SELECT * FROM Product;

SELECT * FROM RawMaterial;

SELECT * FROM ShippingCompany;

SELECT * FROM Package;

SELECT * FROM Request;

SELECT * FROM Requirement;

SELECT * FROM RequestPackage;

-- Product requirements
SELECT p.name AS PName, m.name AS MName, r.quantity AS Quantity 
	FROM Requirement r 
	INNER JOIN Product p		ON p.code = r.codeProduct 
	INNER JOIN RawMaterial m	ON m.code = r.codeRMaterial;


-- Count number of raw materials required to a product
SELECT p.name AS PName, COUNT(m.name) AS MName
	FROM Requirement r 
	INNER JOIN Product p		ON p.code = r.codeProduct 
	INNER JOIN RawMaterial m	ON m.code = r.codeRMaterial
	GROUP BY p.name;

-- Request informations
SELECT r.*, s.name AS ShippingCompany, c.name AS Client, p.name AS Product  FROM Request r
	INNER JOIN Product p		ON p.code = r.codeProduct
	INNER JOIN Client c			ON c.cnpj = r.cnpjClient
	INNER JOIN ShippingCompany s ON s.cnpj = r.cnpjSCompany;


-- About Shipping companies that are cheap
SELECT r.*, s.name AS ShippingCompany, c.name AS Client, p.name AS Product  FROM Request r
	INNER JOIN Product p		ON p.code = r.codeProduct
	INNER JOIN Client c			ON c.cnpj = r.cnpjClient
	INNER JOIN ShippingCompany s ON s.cnpj = r.cnpjSCompany
	WHERE r.cnpjSCompany IN (
		SELECT cnpj FROM ShippingCompany WHERE price < 2.5
	);

-- Revenue of a certain client had
SELECT SUM(p.price * r.quantity) AS Revenue, c.name AS Client  FROM Request r
	INNER JOIN Product p		ON p.code = r.codeProduct
	INNER JOIN Client c			ON c.cnpj = r.cnpjClient
	INNER JOIN ShippingCompany s ON s.cnpj = r.cnpjSCompany
	WHERE c.name LIKE '%Goo%'
	GROUP BY c.name;
    
-- Clients that have request a product in the same week
SELECT WEEK(r.startTime) AS Week, c.name AS Client  FROM Request r
	INNER JOIN Product p		ON p.code = r.codeProduct
	INNER JOIN Client c			ON c.cnpj = r.cnpjClient
	INNER JOIN ShippingCompany s ON s.cnpj = r.cnpjSCompany
	GROUP BY WEEK(r.startTime), c.name;


-- Request that took more than one week
SELECT SUM(p.price * r.quantity) AS Revenue, c.name AS Client  FROM Request r
	INNER JOIN Product p		ON p.code = r.codeProduct
	INNER JOIN Client c			ON c.cnpj = r.cnpjClient
	INNER JOIN ShippingCompany s ON s.cnpj = r.cnpjSCompany
	WHERE DATEDIFF(r.endTime, r.startTime) > 7
	GROUP BY c.name;

-- Number of packages a client use
SELECT c.name AS Name, SUM(rp.quantity) FROM RequestPackage rp
	INNER JOIN Request r		ON rp.codeRequest = r.code
	INNER JOIN Package p		ON rp.codePackage = p.code
	INNER JOIN Client c			ON r.cnpjClient = c.cnpj
	WHERE c.name LIKE '%Goo%'
	GROUP BY r.cnpjClient;

-- Number of packages each client used
SELECT c.name AS Name, SUM(rp.quantity) FROM RequestPackage rp
	INNER JOIN Request r		ON rp.codeRequest = r.code
	INNER JOIN Package p		ON rp.codePackage = p.code
	INNER JOIN Client c			ON r.cnpjClient = c.cnpj
	GROUP BY r.cnpjClient;

USE bookstore;

-- 1
SELECT title, price FROM books ORDER BY price DESC;

-- 2 
SELECT title, publication_year FROM books 
WHERE publication_year > 2000;

-- 3
SELECT * FROM customers 
WHERE country = "USA";

-- 4
SELECT DISTINCT (country) FROM customers;

-- 5
SELECT title, price FROM books ORDER BY price ASC 
LIMIT 5;

-- 6
SELECT * FROM books
WHERE title LIKE "%Foundation%";

-- 7 
SELECT * FROM books 
WHERE stock_quantity = 0;

-- 8
SELECT COUNT(*) FROM books; 

-- 9 
SELECT AVG(price) FROM books;

-- 10
SELECT MIN(price), MAX(price) FROM books;

-- 11
SELECT g.`Name`, COUNT(b.genre_id) FROM books b
JOIN genres g on b.genre_id = g.genre_id 
GROUP BY g.`Name`;

-- 12 
SELECT g.`Name`, SUM(b.stock_quantity) FROM books b
JOIN genres g on b.genre_id = g.genre_id 
GROUP BY g.`Name`;

-- 13 
SELECT g.`Name` FROM books b
JOIN genres g on b.genre_id = g.genre_id 
GROUP BY g.`Name`
HAVING COUNT(b.author_id) > 3;

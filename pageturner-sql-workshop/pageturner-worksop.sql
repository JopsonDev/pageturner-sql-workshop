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

-- 14
SELECT `status`, COUNT(*) FROM orders 
GROUP BY `status`;

-- 15
SELECT b.title, a.first_name, a.last_name FROM books b 
JOIN authors a ON b.author_id = a.author_id 
GROUP BY b.title, a.first_name, a.last_name;

-- 16 
SELECT b.title, g.`name` FROM books b 
JOIN genres g on b.genre_id = g.genre_id 
GROUP BY b.title, g.`name`;

-- 17
SELECT o.order_id, o.order_date, c.first_name, c.last_name FROM orders o
JOIN customers c ON o.customer_id = c.customer_id ORDER BY o.order_id;

-- 18 
SELECT b.title, oi.quantity, oi.unit_price FROM books b
JOIN order_items oi ON b.book_id = oi.book_id 
ORDER BY oi.order_id;

-- 19
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS total_purchases FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 20
SELECT a.first_name, a.last_name, COUNT(b.book_id) AS total_books FROM books b
RIGHT JOIN authors a ON b.author_id = a.author_id
GROUP BY a.author_id, a.first_name, a.last_name;

-- 21
SELECT b.title, COUNT(*) AS total_reviews FROM books b
JOIN reviews r ON b.book_id = r.book_id
GROUP BY b.book_id HAVING total_reviews >= 1;

-- 22
SELECT * FROM books
WHERE price > (SELECT AVG(price) FROM books);

-- 23
SELECT b.* FROM books b
LEFT JOIN order_items oi ON b.book_id = oi.book_id
WHERE oi.book_id IS NULL;

-- 24
SELECT c.* FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- 25
SELECT b.title, COUNT(*) AS total_reviews
FROM books b
JOIN reviews r ON b.book_id = r.book_id
GROUP BY b.book_id, b.title
HAVING COUNT(*) = (SELECT MAX(review_count) FROM (SELECT COUNT(*) AS review_count FROM reviews
GROUP BY book_id) AS mr);

-- 26
SELECT b.title, SUM(oi.quantity) total_sold
FROM books b
JOIN order_items oi ON b.book_id = oi.book_id
GROUP BY b.book_id, b.title
HAVING SUM(oi.quantity) = (SELECT MAX(book_total) FROM (SELECT SUM(quantity) AS book_total FROM order_items
GROUP BY book_id) AS ms);

-- 27
SELECT g.name, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM genres g 
JOIN books b ON g.genre_id = b.genre_id
JOIN order_items oi ON b.book_id = oi.book_id
GROUP BY g.genre_id, g.name
ORDER BY total_revenue DESC;

-- 28
SELECT c.first_name, c.last_name, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 29
SELECT a.first_name, a.last_name, AVG(r.rating) AS ar
FROM authors a
JOIN books b ON a.author_id = b.author_id
JOIN reviews r ON r.book_id = b.book_id
GROUP BY a.author_id, a.first_name, a.last_name
HAVING AVG(r.rating) = (SELECT MAX(review_rating) FROM (SELECT AVG(r.rating) AS review_rating FROM reviews
GROUP BY book_id) AS mr)
ORDER BY ar DESC LIMIT 1;

-- 30
SELECT g.`name`, b.title, b.price
FROM genres g
JOIN books b ON g.genre_id = b.genre_id
WHERE b.price = (SELECT MAX(b2.price) FROM books b2
WHERE b2.genre_id = b.genre_id);
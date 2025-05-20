-- Books Table
CREATE TABLE books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(30),
Genre VARCHAR(20),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT
);

--Customers Table
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

--Orders Table
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


--Import data from files by (direct method) or using (below command). 
 
COPY Orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'C:\Users\Dell\Downloads\ST - SQL ALL PRACTICE FILES\All Excel Practice Files\Orders.csv'
CSV HEADER;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM books
WHERE genre='Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE published_year>1950;

-- 3) List all customers from the Canada:
SELECT * FROM customers
WHERE country='Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-1' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS total_stocks
FROM books;

-- 6) Find the details of the most expensive book:
SELECT * FROM books
ORDER BY price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders
WHERE quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM orders;
WHERE total_amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre
FROM books;

-- 10) Find the book with the lowest stock:
SELECT * FROM books
ORDER BY stock
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- 12) Retrieve the total number of books sold for each genre:
SELECT b.genre, SUM(o.quantity) AS total_books_sold
FROM books b
JOIN 
orders o
ON b.book_id= o.book_id
GROUP BY b.genre;

-- 13) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS avg_price
FROM books
WHERE genre='Fantasy';

-- 14) List customers who have placed at least 2 orders:
SELECT c.name,o.customer_id,COUNT(o.order_id) AS order_placed
FROM orders o
JOIN
customers c
ON c.customer_id= o.customer_id
GROUP BY c.name,o.customer_id
HAVING COUNT(o.order_id)>=2;

-- 15) Find the most frequently ordered book:
SELECT b.title,o.book_id, COUNT(o.order_id) AS frequently_order_books
FROM orders o
JOIN books b
ON b.book_id= o.book_id
GROUP BY b.title,o.book_id
ORDER BY frequently_order_books DESC
LIMIT 2;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 17) Retrieve the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) AS books_sold
FROM books b
JOIN orders o
ON b.book_id= o.book_id
GROUP BY b.author;

-- 18) List the cities where customers who spent over $30 are located:
SELECT DISTINCT(c.city), o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id= o.customer_id
WHERE o.total_amount>30;

-- 19) Find the customer who spent the most on orders:
SELECT c.name, SUM(o.total_amount) AS most_spent
FROM customers c
JOIN orders o
ON c.customer_id= o.customer_id
GROUP BY c.name
ORDER BY most_spent DESC
LIMIT 1;

-- 20) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) AS order_placed,
        b.stock - COALESCE(SUM(quantity),0) AS remaining_stock
FROM books b
LEFT JOIN
orders o 
ON b.book_id= o.book_id
GROUP BY b.book_id;











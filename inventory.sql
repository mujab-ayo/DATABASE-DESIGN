CREATE TABLE users (
    id uuid NOT NULL,
    name VARCHAR(225) NOT NULL,
    email VARCHAR(225) NOT NULL UNIQUE,
    role ENUM('admin', 'visitor') DEFAULT 'visitor',
    password VARCHAR(225) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
)


CREATE TABLE items (
    id uuid NOT NULL,
    name VARCHAR(225) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    size ENUM('small', 'medium', 'large'),
    categoryID uuid NOT NULL,
    isAvailable BOOLEAN DEFAULT TRUE,
    quantityAvailable INT,
    description TEXT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (categoryID) REFERENCES category(id)
)


CREATE TABLE categories (
    id uuid NOT NULL,
    name VARCHAR(225) NOT NULL,
    description TEXT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
)


CREATE TABLE orders (
    id uuid NOT NULL,
    userID uuid NOT NULL,
    status ENUM('pending', 'cancel', 'success') DEFAULT 'pending',
    orderDescription TEXT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (userID) REFERENCES users(id)
)


CREATE TABLE orderItems (
    id uuid NOT NULL,
    itemID uuid NOT NULL,
    orderID uuid NOT NULL,
    unitQuantity INT NOT NULL,
    totalAmount DECIMAL(8,2) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (itemID) REFERENCES items(id),
    FOREIGN KEY (orderID) REFERENCES orders(id)
)


INSERT INTO users (id, name, email, role, password)
VALUES 
(1, 'Admin User', 'abdul.admin@mail.com', 'admin', '123455'),
(2, 'Normal User', 'furqan.user@mail.com', 'visitor', '123455');


INSERT INTO items (id, name, price, size, categoryID, isAvailable, quantityAvailable, description)
VALUES 
(1, 'Laptop', 1500.00, 'medium', 1, TRUE, 10, 'High performance laptop'),
(2, 'T-Shirt', 25.00, 'large', 2, TRUE, 50, 'Cotton t-shirt');


INSERT INTO categories (id, name, description)
VALUES 
(1, 'Electronics', 'Electronic items'),
(2, 'Clothing', 'Wearable items');


INSERT INTO orders (id, userID, status, orderDescription)
VALUES 
(1, 2, 'pending', 'First order');


INSERT INTO orderItems (id, itemID, orderID, unitQuantity, totalAmount)
VALUES 
(1, 1, 1, 1, 1500.00),
(2, 2, 1, 2, 50.00);


SELECT * from categories;

SELECT orders.id, users.name, users.email, orders.status
FROM orders
JOIN users ON orders.userID = users.id;

UPDATE orders
JOIN users ON orders.userID = users.id
SET orders.status = 'approved'
WHERE users.email = 'furqan.user@mail.com';

UPDATE items
JOIN categories ON items.categoryID = categories.id
SET items.price = items.price + 100
WHERE categories.name = 'Electronics';


DELETE orders
FROM orders
JOIN users ON orders.userID = users.id
WHERE users.email = 'user@mail.com';


DELETE items
FROM items
JOIN categories ON items.categoryID = categories.id
WHERE categories.name = 'Electronics';

SELECT orders.id, users.name, orders.status
FROM orders
JOIN users ON orders.userID = users.id;

SELECT items.name, items.price, categories.name AS category
FROM items
JOIN categories ON items.categoryID = categories.id;
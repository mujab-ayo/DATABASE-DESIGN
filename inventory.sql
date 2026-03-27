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
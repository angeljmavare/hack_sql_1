--✔ Database Ecommerce

CREATE TABLE countries(
 id_country serial primary key,
 name_country varchar(50) NOT null
);


CREATE TABLE roles(
  id_role serial primary key,
  name_role varchar(50) not null
); 

CREATE TABLE taxes(
 id_tax serial primary key,
 percentage_taxes float NOT null
);

CREATE TABLE offers(
 id_offer serial primary key,
 status_offer varchar(50) NOT null
);

CREATE TABLE discounts(
 id_discount serial primary key,
 status_discount varchar(50) NOT null,
 percentage_discount float NOT null
);

CREATE TABLE payments(
 id_payment serial primary key,
 type_payment varchar(50) NOT null
);

CREATE TABLE customers(
 id_customer serial primary key,
 email varchar(100) unique,
 id_country integer NOT null,
 id_role integer NOT null,
 name_customer varchar(100) NOT null,
 age integer NOT null,
 password varchar(50) NOT null,
 physical_address varchar(100) NOT null,
 FOREIGN KEY (id_country) REFERENCES countries (id_country),
 FOREIGN KEY (id_role) REFERENCES roles (id_role)
);

CREATE TABLE invoice_status(
 id_invoice_status serial primary key,
 status_invoices varchar(50) NOT null
);

CREATE TABLE products(
 id_product serial primary key,
 id_discount integer NOT null,
 id_offer integer NOT null,
 id_tax integer NOT null,
 name_product varchar(50) NOT null,
 details_product varchar(100) NOT null,
 minimun_stock integer NOT null,
 maximun_stock integer NOT null,
 current_stock integer NOT null,
 price_product float NOT null,
 price_with_tax float NOT null,
 FOREIGN KEY (id_discount) REFERENCES discounts (id_discount),
 FOREIGN KEY (id_offer) REFERENCES offers (id_offer),
 FOREIGN KEY (id_tax) REFERENCES taxes (id_tax)
);

CREATE TABLE product_customers(
 id_customer integer NOT null,
 id_product integer NOT null,
 FOREIGN KEY (id_customer) REFERENCES customers (id_customer),
 FOREIGN KEY (id_product) REFERENCES products (id_product),
 PRIMARY KEY (id_customer, id_product)
);

CREATE TABLE invoices(
 id_invoice serial primary key,
 id_customer integer NOT null,
 id_payment integer NOT null,
 id_invoice_status integer NOT null,
 date date NOT null,
 total_to_pay float NOT null,
 FOREIGN KEY (id_customer) REFERENCES customers (id_customer),
 FOREIGN KEY (id_payment) REFERENCES payments (id_payment),
 FOREIGN KEY (id_invoice_status) REFERENCES invoice_status (id_invoice_status)
);

CREATE TABLE orders(
 id_order serial primary key,
 id_invoice integer NOT null, 
 id_product integer NOT null,
 detail_order varchar(100) NOT null,
 amount integer NOT null,
 price_order float NOT null,
 FOREIGN KEY (id_invoice) REFERENCES invoices (id_invoice),
 FOREIGN KEY (id_product) REFERENCES products (id_product)
);

--✔ Insert (3 record in all tables y create 3 invoices)
INSERT INTO countries (name_country) VALUES ('Venezuela'),('Argentina'),('Brasil');
SELECT * FROM countries;

INSERT INTO roles (name_role) VALUES ('Masculino'),('Femenino'),('Otro');
SELECT * FROM roles;

INSERT INTO taxes (percentage_taxes) VALUES (0.05),(0.10),(0.15);
SELECT * FROM taxes;

INSERT INTO offers (status_offer) VALUES ('Activa'),('Expirada'),('Suspendido');
SELECT * FROM offers;

INSERT INTO discounts (status_discount, percentage_discount) VALUES ('Activa', 0.03),('Expirada', 0.0),('Suspendido', 0.0);
SELECT * FROM discounts;

INSERT INTO payments (type_payment) VALUES ('Efectivo'),('Tarjeta'),('Online');
SELECT * FROM payments;

INSERT INTO customers (email,id_country,id_role,name_customer,age,password,physical_address)
VALUES
('prueba1@prueba.com',1,1,'Angel J Mavare',27,'clave123','Falcon'),
('prueba2@prueba.com',2,2,'Maria Hernandez',20,'Milei2025','Buenos Aires'),
('prueba3@prueba.com',3,1,'Jesus Mavare',25,'RioJaneiro25','Brasilia');
SELECT * FROM customers;

INSERT INTO invoice_status (status_invoices) VALUES ('Pagada'),('Pendiente'),('Vencida');
SELECT * FROM invoice_status;

INSERT INTO products (id_discount,id_offer,id_tax,name_product,details_product,minimum_stock,maximum_stock,current_stock,price_product,price_with_tax) 
VALUES 
(1,1,1,'iPhone 16','Telefono',0,10,6,1250.00,1312.50),
(2,2,2,'Televisor','43 pulgadas',0,15,11,180.50,198.55),
(3,3,3,'Laptop Acer','Nitro 5',0,20,13,750.50,863.075);
SELECT * FROM products;

INSERT INTO invoices (id_customer,id_payment,id_invoice_status,date,total_to_pay) VALUES (1,1,1,'2025-03-27',1273.125),
(2,2,2,'2025-03-26',595.75),
(3,3,3,'2025-02-15',1726.15);
SELECT * FROM invoices;

INSERT INTO orders (id_invoice,id_product,detail_order,amount,price_order) 
VALUES 
(1,1,'Compra de Iphone 16',1,1273.125),
(2,2,'Compra de TV 43 Pulgadas',3,595.75),
(3,3,'Compra de Laptop Acer Nitro 5',2,1726.15);
SELECT * FROM orders;

--✔ Delete (delete last first user)
--Para borrar el customer debo eliminar en cascada, las orders e invoices.
DELETE FROM orders
WHERE id_invoice IN (
    SELECT id_invoice
    FROM invoices
    WHERE id_customer IN (
        (SELECT MIN(id_customer) FROM customers),
        (SELECT MAX(id_customer) FROM customers)
    )
);

DELETE FROM invoices
WHERE id_customer IN (
    (SELECT MIN(id_customer) FROM customers),
    (SELECT MAX(id_customer) FROM customers)
);

DELETE FROM customers
WHERE id_customer IN (
    (SELECT MIN(id_customer) FROM customers),
    (SELECT MAX(id_customer) FROM customers)
);

--✔ Update (update last user / update all taxes / update all prices)
--Actualizo contraseña del ultimo usuario
UPDATE customers SET password = 'Arg2025$$' WHERE id_customer = (SELECT MAX(id_customer) FROM customers);
SELECT * FROM customers;

--Actualizo todas las tax
UPDATE taxes SET percentage_taxes = 0.03 WHERE id_tax = 1;
UPDATE taxes SET percentage_taxes = 0.08 WHERE id_tax = 2;
UPDATE taxes SET percentage_taxes = 0.10 WHERE id_tax = 3;
SELECT * FROM taxes;

--Actualizo precio y precio con las tax nuevas
UPDATE products SET price_product = 1150.0, price_with_tax = 1150.0 WHERE id_product = 1;
UPDATE products SET price_product = 150.60, price_with_tax = 162.648 WHERE id_product = 2;
UPDATE products SET price_product = 680.50, price_with_tax = 748.55 WHERE id_product = 3;
SELECT * FROM products;
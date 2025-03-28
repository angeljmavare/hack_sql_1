--✔ Database Register

create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

create table users(
 id_users serial primary key,
 id_country integer not null,
 email varchar(100) not null,
 name varchar (50) not null,
 foreign key (id_country) references countries (id_country)   
);


--✔ CREATE:
INSERT INTO countries (name) VALUES ('argentina'),('colombia'),('chile');
SELECT * FROM countries;

INSERT INTO users (id_country, email, name) VALUES (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
SELECT * FROM users;

--✔ DELETE:
DELETE FROM users WHERE email = 'bar@bar.com';
SELECT * FROM users;

--✔ UPDATE:
UPDATE users SET email = 'foo@foo.foo', name = 'fooz' WHERE id_users = 1;
SELECT * FROM users;

--✔ SELECT:
SELECT * FROM users INNER JOIN countries ON users.id_country = countries.id_country;

SELECT u.id_users AS id, u.email, u.name AS fullname, c.name FROM users u INNER JOIN countries c ON u.id_country = c.id_country;
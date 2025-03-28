--✔ Database Contact

create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

create table priorities(
  id_priority serial primary key,
  type_name varchar(50) not null
); 

CREATE TABLE contact_request(
  id_email serial primary key,
  id_country integer NOT null,
  id_priority integer NOT null,
  name varchar(50) NOT null,
  detail varchar(100) NOT null,
  physical_address varchar(100) NOT null,
  FOREIGN KEY (id_country) REFERENCES countries (id_country),
  FOREIGN KEY (id_priority) REFERENCES priorities (id_priority)
);


--✔ INSERT (5 en countries, 3 en priorities y 3 en contact_request):

INSERT INTO countries (name) VALUES ('Venezuela'),('Argentina'),('Brasil'),('Alemania'),('Suiza');
SELECT * FROM countries;


INSERT INTO priorities (type_name) VALUES ('Alta'),('Media'),('Baja');
SELECT * FROM priorities;

INSERT INTO contact_request (id_country,id_priority,name,detail,physical_address) VALUES 
(1,1,'Angel J Mavare','Dolar en 100bs','Estado Falcon'),
(2,2,'Jose Perez','Argentina ganara la copa mundial','Buenos Aires'),
(3,3,'Ronaldo','Brasil no es la misma en futbol','Brasilia');
SELECT * FROM contact_request;

--✔ SELECT (INNER JOIN):

SELECT 
    c.name AS Pais, 
    p.type_name AS Prioridad, 
    cr.name AS Nombre, 
    cr.detail AS Detalle, 
    cr.physical_address AS Direccion
FROM 
    contact_request cr
INNER JOIN 
    countries c ON cr.id_country = c.id_country
INNER JOIN 
    priorities p ON cr.id_priority = p.id_priority;


--✔ DELETE (Borrar ultimo registro):

DELETE FROM contact_request WHERE id_email = (SELECT MAX(id_email) FROM contact_request);
SELECT * FROM contact_request;

--✔ UPDATE (Actualizar el primer registro):

UPDATE contact_request SET detail = 'Venezuela debe ganar contra Bolivia' WHERE id_email = (SELECT MIN(id_email) FROM contact_request);
SELECT * FROM contact_request;
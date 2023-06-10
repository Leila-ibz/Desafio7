-- Active: 1686189676622@@127.0.0.1@3306@desafio7
CREATE TABLE usuario (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(30),
apellido VARCHAR(30),
telefono BIGINT(10),
username VARCHAR(20),
email VARCHAR(30),
contrasenia VARCHAR(20),
estado ENUM('activo', 'inactivo'),
fecha_creacion DATE,
avatar BLOB,
es_publico BOOLEAN,
es_colaborador BOOLEAN,
es_admin BOOLEAN
);


INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Leila', 'Ibañez', 3704682165, 'Leilaibz', 'leilaibanez@dominio.com', '123456', 'activo', '2023-06-09', DEFAULT, FALSE, FALSE, TRUE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Adrian', 'Senturion', 1234567890, 'adrians', 'adrian@dominio.com', '440066', 'activo', '2023-06-09', DEFAULT, FALSE, TRUE, FALSE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Eliseo', 'Montenegro', 2345678901, 'eliseom', 'eliseo@dominio.com', '669911', 'activo', '2023-06-09', DEFAULT, FALSE, TRUE, FALSE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Juan', 'Perez', 3456789012, 'juanp', 'juan@dominio.com', '678744', 'activo', '2023-06-09', DEFAULT, FALSE, TRUE, FALSE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Ana', 'Gomez', 4567890123, 'anagz', 'ana@dominio.com', '786756', 'activo', '2023-06-09', DEFAULT, FALSE, TRUE, FALSE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Emmanuel', 'Luna', 5678901234, 'emmalu', 'emmanuel@dominio.com', '768765', 'activo', '2023-06-09', DEFAULT, TRUE, FALSE, FALSE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Franco', 'Santa Cruz', 6789012345, 'francosz', 'franco@dominio.com', '009897', 'activo', '2023-06-09', DEFAULT, TRUE, FALSE, FALSE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Laura', 'Lopez', 7890123456, 'lauralopz', 'laura@dominio.com', '122143', 'activo', '2023-06-09', DEFAULT, TRUE, FALSE, FALSE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('Diego', 'Vargas', 7890123456, 'Diegosv', 'diegovs@dominio.com', '987576', 'activo', '2023-06-09', DEFAULT, TRUE, FALSE, FALSE);

INSERT INTO usuario (nombre, apellido, telefono, username, email, contrasenia, estado, fecha_creacion, avatar, es_publico, es_colaborador, es_admin)
VALUES
    ('julian', 'suarez', 7865456789, 'juarez', 'juarezjuli@dominio.com', '097854', 'activo', '2023-06-09', DEFAULT, TRUE, FALSE, FALSE);

UPDATE usuario
SET es_colaborador = FALSE, es_admin = TRUE
WHERE id = 2;

CREATE TABLE articulo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    titulo VARCHAR(255),
    resumen VARCHAR(255),
    contenido TEXT,
    fecha_publicacion DATE,
    estado BOOLEAN,
    imagen VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id)
);


INSERT INTO articulo (titulo, resumen, contenido, fecha_publicacion, estado, imagen, id_usuario)
VALUES
  ('Artículo 1', 'Resumen del artículo 1', 'Contenido del artículo 1', '2023-06-09', TRUE, 'imagen1.jpg', 1),
  ('Artículo 2', 'Resumen del artículo 2', 'Contenido del artículo 2', '2023-06-09', TRUE, 'imagen2.jpg', 2),
  ('Artículo 3', 'Resumen del artículo 3', 'Contenido del artículo 3', '2023-06-09', TRUE, 'imagen3.jpg', 3),
  ('Artículo 4', 'Resumen del artículo 4', 'Contenido del artículo 4', '2023-06-09', FALSE, 'imagen4.jpg', 4);

DELETE a
FROM articulo AS a
JOIN (
  SELECT id FROM articulo WHERE estado = FALSE
) AS subquery
ON a.id = subquery.id;


CREATE TABLE comentario (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_articulo INT,
  id_usuario INT,
  contenido TEXT,
  fecha_hora DATETIME,
  estado BOOLEAN,
  FOREIGN KEY (id_articulo) REFERENCES articulo (id),
  FOREIGN KEY (id_usuario) REFERENCES usuario (id)
);

-- Agregar 3 comentarios al primer artículo
INSERT INTO comentario (id_articulo, id_usuario, contenido, fecha_hora, estado)
VALUES
  (1, 1, 'Primer comentario del artículo 1', NOW(), TRUE),
  (1, 2, 'Segundo comentario del artículo 1', NOW(), TRUE),
  (1, 3, 'Tercer comentario del artículo 1', NOW(), TRUE);

-- Agregar 2 comentarios al segundo artículo
INSERT INTO comentario (id_articulo, id_usuario, contenido, fecha_hora, estado)
VALUES
  (2, 1, 'Primer comentario del artículo 2', NOW(), TRUE),
  (2, 2, 'Segundo comentario del artículo 2', NOW(), TRUE);


SELECT a.titulo, a.fecha_publicacion, u.nombre, MAX(c.fecha_hora) AS ultima_fecha_hora
FROM articulo a
JOIN comentario c ON a.id = c.id_articulo
JOIN usuario u ON u.id = c.id_usuario
GROUP BY a.id, a.titulo, a.fecha_publicacion, u.nombre



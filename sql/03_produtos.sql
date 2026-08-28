CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150),
    id_categoria INT,
    FOREIGN KEY  (id_categoria) REFERENCES categorias(id)
);

INSERT INTO produtos (nome, id_categoria)
VALUES
    ('SSD Kingston 1TB', 1),
    ('Mouse Logitech MX Master 3S',2),
    ('Teclado Redragon Kumara', 2),
    ('Monitor LG 24"', 3);

SELECT * FROM produtos;
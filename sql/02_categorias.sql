CREATE TABLE categorias (
    id INT PRIMARY KEY,
    nome VARCHAR (100)
);

INSERT INTO categorias (id, nome)
VALUES
    (1,'Armazenamento'),
    (2, 'Periféricos'),
    (3, 'Monitores');

SELECT * FROM categorias;
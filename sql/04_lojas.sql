CREATE TABLE lojas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

INSERT INTO lojas (nome)
VALUES
    ('Amazon'),
    ('Mercado Livre'),
    ('KaBum!'),
    ('Pichau');

SELECT * FROM lojas;
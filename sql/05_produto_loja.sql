CREATE TABLE produto_loja (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT,
    id_loja INT,

    FOREIGN KEY (id_produto) REFERENCES produtos(id),
    FOREIGN KEY (id_loja) REFERENCES lojas(id)
);
INSERT INTO produto_loja (id_produto, id_loja)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2),
    (2,3),
    (3,1),
    (3,2),
    (3,3),
    (4,1),
    (4,2),
    (4,3),
    (5,1);

SELECT
    produtos.nome AS Produtos,
    lojas.nome AS Lojas
FROM produto_loja
JOIN produtos
    ON produto_loja.id_produto = produtos.id
JOIN lojas
    ON produto_loja.id_loja = lojas.id;
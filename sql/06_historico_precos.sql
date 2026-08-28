CREATE TABLE historico_precos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_produto_loja INT,
    preco DECIMAL(10,2),
    data_coleta DATETIME,

    FOREIGN KEY (id_produto_loja) REFERENCES produto_loja (id)
);

INSERT INTO historico_precos (id_produto_loja, preco, data_coleta)
VALUES (1,329.90,NOW());

SELECT * FROM historico_precos;
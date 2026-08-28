SELECT
    produtos.nome AS Produtos,
    lojas.nome AS Loja,
    historico_precos.preco,
    historico_precos.data_coleta
FROM historico_precos
JOIN produto_loja
    ON historico_precos.id_produto_loja = produto_loja.id
JOIN produtos
    ON produto_loja.id_produto = produtos.id
JOIN lojas
    ON produto_loja.id_loja = lojas.id
ORDER BY historico_precos.data_coleta;
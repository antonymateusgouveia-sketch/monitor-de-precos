SELECT
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco,
    AVG(preco) AS preco_medio,
    COUNT(preco) AS total_coletas
FROM historico_precos;

SELECT
    produtos.nome AS produto,
    lojas.nome AS loja,
    MIN(historico_precos.preco) AS Menor_preco,
    MAX(historico_precos.preco) AS Maior_preco,
    AVG(historico_precos.preco) AS Preco_medio,
    COUNT(*) AS Total_coletas
FROM historico_precos
JOIN produto_loja
    ON historico_precos.id_produto_loja = produto_loja.id
JOIN produtos
    ON produto_loja.id_produto = produtos.id
JOIN lojas
    ON produto_loja.id_loja = lojas.id
GROUP BY produtos.nome, lojas.nome;

SELECT
    id_produto_loja,
    preco AS preco_atual,
    LAG(preco) OVER (
        PARTITION BY id_produto_loja
        ORDER BY historico_precos.data_coleta
        ) AS preco_anterior,
        data_coleta
FROM historico_precos;

SELECT
    id_produto_loja,
    preco AS preco_atual,
    LAG(preco) OVER (
        PARTITION BY id_produto_loja
        ORDER BY data_coleta
    ) AS preco_anterior,
    preco - LAG(preco) OVER (
        PARTITION BY id_produto_loja
        ORDER BY data_coleta
    ) AS diferenca_preco,
    data_coleta
FROM historico_precos;

SELECT
    id_produto_loja,
    preco AS preco_atual,

    LAG(preco) OVER (
        PARTITION BY id_produto_loja
        ORDER BY data_coleta
    ) AS preco_anterior,

    preco - LAG(preco) OVER (
        PARTITION BY id_produto_loja
        ORDER BY data_coleta
    ) AS diferenca_preco,

    ROUND(
            (
                preco - LAG(preco) OVER (
                    PARTITION BY id_produto_loja
                    ORDER BY data_coleta
                    )
                )
                /
                LAG(preco) OVER (
                    PARTITION BY id_produto_loja
                    ORDER BY data_coleta
                ) *100,
                2
            ) AS variacao_percentual,

            data_coleta

FROM historico_precos;

SELECT
    produtos.nome AS Produto,
    lojas.nome AS Lojas,
    historico_precos.preco AS preco_atual,

    LAG(historico_precos.preco) OVER (
        PARTITION BY historico_precos.id_produto_loja
        ORDER BY historico_precos.data_coleta
    ) AS preco_anterior,

    historico_precos.preco - LAG(historico_precos.preco) OVER (
        PARTITION BY historico_precos.id_produto_loja
        ORDER BY historico_precos.data_coleta
    ) AS diferenca_preco,

    ROUND(
            (
                historico_precos.preco - LAG(historico_precos.preco) OVER (
                    PARTITION BY historico_precos.id_produto_loja
                    ORDER BY historico_precos.data_coleta
                    )
                )
                /
                LAG(historico_precos.preco) OVER (
                PARTITION BY historico_precos.id_produto_loja
                ORDER BY historico_precos.data_coleta

            ) * 100,
            2
        ) AS variacao_percentual,

        historico_precos.data_coleta

FROM historico_precos
JOIN produto_loja
    ON historico_precos.id_produto_loja = produto_loja.id
JOIN produtos
    ON produto_loja.id_produto = produtos.id
JOIN lojas
    ON produto_loja.id_loja = lojas.id

ORDER BY   historico_precos.data_coleta;

SELECT
    produtos.nome AS produto,
    lojas.nome AS loja,
    historico_precos.preco AS preco_atual,

    LAG(historico_precos.preco) OVER (
        PARTITION BY historico_precos.id_produto_loja
        ORDER BY historico_precos.data_coleta
    ) AS preco_anterior,

    historico_precos.preco - LAG(historico_precos.preco) OVER (
        PARTITION BY historico_precos.id_produto_loja
        ORDER BY historico_precos.data_coleta
    ) AS diferenca_preco,

    ROUND(
        (
            historico_precos.preco - LAG(historico_precos.preco) OVER (
                PARTITION BY historico_precos.id_produto_loja
                ORDER BY historico_precos.data_coleta
            )
        )
        /
        LAG(historico_precos.preco) OVER (
            PARTITION BY historico_precos.id_produto_loja
            ORDER BY historico_precos.data_coleta
        ) * 100,
        2
    ) AS variacao_percentual,

    CASE
        WHEN historico_precos.preco > LAG(historico_precos.preco) OVER (
            PARTITION BY historico_precos.id_produto_loja
            ORDER BY historico_precos.data_coleta
        ) THEN 'AUMENTOU'

        WHEN historico_precos.preco < LAG(historico_precos.preco) OVER (
            PARTITION BY historico_precos.id_produto_loja
            ORDER BY historico_precos.data_coleta
        ) THEN 'DIMINUIU'

        WHEN historico_precos.preco = LAG(historico_precos.preco) OVER (
            PARTITION BY historico_precos.id_produto_loja
            ORDER BY historico_precos.data_coleta
        ) THEN 'MANTEVE'

        ELSE 'SEM HISTORICO'
    END AS status_preco,

    historico_precos.data_coleta

FROM historico_precos
JOIN produto_loja
    ON historico_precos.id_produto_loja = produto_loja.id
JOIN produtos
    ON produto_loja.id_produto = produtos.id
JOIN lojas
    ON produto_loja.id_loja = lojas.id

ORDER BY historico_precos.data_coleta;
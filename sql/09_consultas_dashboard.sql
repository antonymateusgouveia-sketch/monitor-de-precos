SELECT COUNT(DISTINCT id_produto) AS produtos_monitorados
FROM produto_loja;

SELECT ROUND(AVG(preco), 2) AS preco_medio_geral
FROM historico_precos;

SELECT
    id_produto_loja,
    preco,
    data_coleta,

    ROW_NUMBER() OVER (
        PARTITION BY id_produto_loja
        ORDER BY data_coleta DESC
    ) AS ordem
FROM historico_precos;

WITH comparacao AS (
    SELECT
        id_produto_loja,
        preco AS preco_atual,

        LAG(preco) OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta
        ) AS preco_anterior,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT *
FROM comparacao
WHERE ordem = 1;

WITH comparacao AS (
    SELECT
        id_produto_loja,
        preco AS preco_atual,

        LAG(preco) OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta
        ) AS preco_anterior,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT COUNT(*) AS produtos_mais_baratos
FROM comparacao
WHERE ordem = 1
    AND preco_atual < preco_anterior;

WITH comparacao AS (
    SELECT
        id_produto_loja,
        preco AS preco_atual,

        LAG(preco) OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta
        ) AS preco_anterior,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT COUNT(*) AS produtos_mais_baratos
FROM comparacao
WHERE ordem = 1
    AND preco_atual > preco_anterior;

WITH comparacao AS (
    SELECT
        id_produto_loja,
        preco AS preco_atual,

        LAG(preco) OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta
        ) AS preco_anterior,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT COUNT(*) AS produtos_mais_baratos
FROM comparacao
WHERE ordem = 1
    AND preco_atual = preco_anterior;

WITH comparacao AS (
    SELECT
        id_produto_loja,
        preco AS preco_atual,

         LAG(preco) OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta
        ) AS preco_anterior,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT
    produtos.nome AS Produto,
    lojas.nome AS Loja,
    comparacao.preco_atual,
    comparacao.preco_anterior,
    comparacao.preco_atual - comparacao.preco_anterior AS Queda
FROM comparacao
JOIN produto_loja
    ON comparacao.id_produto_loja = produto_loja.id
JOIN produtos
    ON produto_loja.id_loja = produtos.id
JOIN lojas
    ON produto_loja.id_loja = lojas.id
WHERE comparacao.ordem = 1
    AND comparacao.preco_atual < comparacao.preco_anterior
ORDER BY Queda ASC
LIMIT 1;

WITH comparacao AS (
    SELECT
        id_produto_loja,
        preco AS preco_atual,

        LAG(preco) OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta
        ) AS preco_anterior,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT
    produtos.nome AS Produto,
    lojas.nome AS Loja,
    comparacao.preco_atual,
    comparacao.preco_anterior,
    comparacao.preco_atual - comparacao.preco_anterior AS  Aumento
FROM comparacao
JOIN produto_loja
    ON comparacao.id_produto_loja = produto_loja.id
JOIN produtos
    ON produto_loja.id_produto = produtos.id
JOIN lojas
    ON produto_loja.id_loja = lojas.id
WHERE comparacao.ordem = 1
    AND comparacao.preco_atual > comparacao.preco_anterior
ORDER BY Aumento DESC
LIMIT 1;

WITH precos_atuais AS (
    SELECT
        id_produto_loja,
        preco,
        data_coleta,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT
    produtos.nome AS produto,
    lojas.nome AS loja,
    precos_atuais.preco AS preco_atual,
    precos_atuais.data_coleta
FROM precos_atuais
JOIN produto_loja
    ON precos_atuais.id_produto_loja = produto_loja.id
JOIN produtos
    ON produto_loja.id_produto = produtos.id
JOIN lojas
    ON produto_loja.id_loja = lojas.id
WHERE precos_atuais.ordem = 1;

WITH precos_atuais AS (
    SELECT
        id_produto_loja,
        preco,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT
    MIN(preco) AS menor_preco_atual
FROM precos_atuais
WHERE ordem = 1;

WITH precos_atuais AS (
    SELECT
        id_produto_loja,
        preco,

        ROW_NUMBER() OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta DESC
        ) AS ordem

    FROM historico_precos
)

SELECT
    MAX(preco) AS maior_preco_atual
FROM precos_atuais
WHERE ordem = 1;
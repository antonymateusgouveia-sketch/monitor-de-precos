from etapa05_funcoes_banco import conectar_banco
from etapa14_coletar_preco_link import coletar_preco_amazon
from etapa09_salvar_coleta import salvar_coleta


conexao = conectar_banco()
cursor = conexao.cursor()

sql = """
SELECT
    produto_loja.id,
    produto_loja.url_produto,
    lojas.nome
FROM produto_loja
JOIN lojas
    ON produto_loja.id_loja = lojas.id
WHERE produto_loja.url_produto IS NOT NULL
  AND produto_loja.ativo = TRUE;
"""

cursor.execute(sql)

produtos_monitorados = cursor.fetchall()

cursor.close()
conexao.close()


for produto in produtos_monitorados:
    id_produto_loja = produto[0]
    url = produto[1]
    loja = produto[2]

    try:
        print("Loja:", loja)

        if loja == "Amazon":
            dados = coletar_preco_amazon(url)
        else:
            print("Loja ainda não suportada:", loja)
            continue

        print("Produto:", dados["nome"])
        print("Preço:", dados["preco"])

        salvar_coleta(id_produto_loja, dados["preco"])

        print("Coleta salva!")

    except Exception as erro:
        print("Erro ao coletar produto:", id_produto_loja)
        print("Motivo:", erro)

    print("--------------------")
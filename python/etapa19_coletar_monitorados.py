from etapa05_funcoes_banco import conectar_banco
from etapa14_coletar_preco_link import coletar_preco_amazon
from etapa09_salvar_coleta import salvar_coleta


conexao = conectar_banco()
cursor = conexao.cursor()

sql = """
SELECT
    id,
    url_produto
FROM produto_loja
WHERE url_produto IS NOT NULL;
"""

cursor.execute(sql)

produtos_monitorados = cursor.fetchall()

cursor.close()
conexao.close()


for produto in produtos_monitorados:
    id_produto_loja = produto[0]
    url = produto[1]

    dados = coletar_preco_amazon(url)

    print("Produto:", dados["nome"])
    print("Preço:", dados["preco"])

    salvar_coleta(id_produto_loja, dados["preco"])

    print("Coleta salva!")
    print("--------------------")
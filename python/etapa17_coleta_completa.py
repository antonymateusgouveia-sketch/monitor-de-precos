from etapa05_funcoes_banco import conectar_banco
from etapa14_coletar_preco_link import coletar_preco_amazon
from etapa09_salvar_coleta import salvar_coleta


id_produto_loja = 2

conexao = conectar_banco()
cursor = conexao.cursor()

sql = """
SELECT url_produto
FROM produto_loja
WHERE id = %s;
"""

cursor.execute(sql, (id_produto_loja,))

resultado = cursor.fetchone()

cursor.close()
conexao.close()

url = resultado[0]

produto = coletar_preco_amazon(url)

print("Produto:", produto["nome"])
print("Preço coletado:", produto["preco"])

salvar_coleta(id_produto_loja, produto["preco"])

print("Preço salvo no histórico!")
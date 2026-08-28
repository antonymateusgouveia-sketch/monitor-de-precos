from etapa05_funcoes_banco import conectar_banco
from etapa14_coletar_preco_link import coletar_preco_amazon


conexao = conectar_banco()
cursor = conexao.cursor()

sql = """
SELECT url_produto
FROM produto_loja
WHERE id = %s;
"""

valores = (2,)

cursor.execute(sql, valores)

resultado = cursor.fetchone()
url = resultado[0]

produto = coletar_preco_amazon(url)

print("Produto:", produto["nome"])
print("Preço:", produto["preco"])

from etapa14_coletar_preco_link import coletar_preco_amazon

print(url)

cursor.close()
conexao.close()
from etapa05_funcoes_banco import conectar_banco


conexao = conectar_banco()
cursor = conexao.cursor()

sql = """
SELECT
    id,
    id_produto,
    id_loja,
    url_produto
FROM produto_loja
WHERE url_produto IS NOT NULL;
"""

cursor.execute(sql)

produtos_monitorados = cursor.fetchall()

for produto in produtos_monitorados:
    print(produto)

cursor.close()
conexao.close()
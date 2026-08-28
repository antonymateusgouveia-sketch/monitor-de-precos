import mysql.connector

conexao = mysql.connector.connect(
    host="localhost",
    port=3307,
    user="root",
    password="@Preco123py",
    database="monitor_precos"
)

cursor = conexao.cursor()

sql = """
INSERT INTO historico_precos (id_produto_loja, preco, data_coleta)
VALUES (%s, %s, NOW());
"""

valores = (1, 319.90)

cursor.execute(sql, valores)

conexao.commit()

print("Coleta inserida com sucesso!")

cursor.close()
conexao.close()
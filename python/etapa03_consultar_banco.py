import mysql.connector

conexao = mysql.connector.connect(
    host="localhost",
    port=3307,
    user="root",
    password="@Preco123py",
    database="monitor_precos"
)

cursor = conexao.cursor()

cursor.execute("""
SELECT 
    produtos.nome AS Produto,
    categorias.nome AS Categoria
FROM produtos
JOIN categorias
    ON produtos.id_categoria = categorias.id;
""")

produtos = cursor.fetchall()

for produto in produtos:
    print(produto)

cursor.close()
conexao.close()
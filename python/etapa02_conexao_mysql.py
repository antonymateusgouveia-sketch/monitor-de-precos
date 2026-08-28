import mysql.connector

conexao = mysql.connector.connect(
    host="localhost",
    port=3307,
    user="root",
    password="@Preco123py",
    database="monitor_precos"
)

print("Conexão com MySQL realizado com sucesso")

conexao.close()
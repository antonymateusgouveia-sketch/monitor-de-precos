import os
import mysql.connector
from dotenv import load_dotenv


def conectar_banco():
    conexao = mysql.connector.connect(
        host=os.getenv("MYSQL_HOST"),
        port=int(os.getenv("MYSQL_PORT")),
        user=os.getenv("MYSQL_USER"),
        password=os.getenv("@Preco123py"),
        database=os.getenv("MYSQL_DATABASE")
    )

    return conexao

if __name__ == "__main__":
    conexao = conectar_banco()

    print("Conectado com Banco")

    conexao.close()
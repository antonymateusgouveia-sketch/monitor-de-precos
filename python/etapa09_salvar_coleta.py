from etapa05_funcoes_banco import conectar_banco


def salvar_coleta(id_produto_loja, preco):
    conexao = conectar_banco()
    cursor = conexao.cursor()

    sql = """
    INSERT INTO historico_precos (id_produto_loja, preco, data_coleta)
    VALUES (%s, %s, NOW());
    """

    valores = (id_produto_loja, preco)

    cursor.execute(sql, valores)
    conexao.commit()

    cursor.close()
    conexao.close()
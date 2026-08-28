from etapa05_funcoes_banco import conectar_banco

conexao = conectar_banco()

print("Função importada e conexão funcionando!")

conexao.close()

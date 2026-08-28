from etapa11_funcoes_coleta import coletar_produto

url = "https://dummyjson.com/products/1"

produto = coletar_produto(url)

print("Produto coletado:", produto["nome"])
print("Preço coletado:", produto["preco"])

print("Dados prontos para serem enviados ao MySQL.")
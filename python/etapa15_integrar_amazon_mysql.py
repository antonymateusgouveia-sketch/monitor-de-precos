from etapa14_coletar_preco_link import coletar_preco_amazon
from etapa09_salvar_coleta import salvar_coleta


url = "https://www.amazon.com.br/Mouse-sem-Logitech-Master-Bluetooth/dp/B0FNV6GP6K/"

id_produto_loja = 2

produto = coletar_preco_amazon(url)

print("Produto:", produto["nome"])
print("Preço coletado:", produto["preco"])

salvar_coleta(id_produto_loja, produto["preco"])

print("Preço salvo no MySQL com sucesso!")
import requests

url = "https://dummyjson.com/products/1"

resposta = requests.get(url)

dados = resposta.json()

nome = dados["title"]
preco = dados["price"]

print("Produto: ", nome)
print("Preço: ",preco)



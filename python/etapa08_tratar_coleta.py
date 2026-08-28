import requests

url = "https://dummyjson.com/products/1"

resposta = requests.get(url)

dados = resposta.json()

produto = {
    "nome": dados["title"],
    "preco": dados["price"]
}

print(produto)
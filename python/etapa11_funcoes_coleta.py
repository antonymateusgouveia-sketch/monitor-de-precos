import requests


def coletar_produto(url):
    resposta = requests.get(url)

    dados = resposta.json()

    produto = {
        "nome": dados["title"],
        "preco": dados["price"]
    }

    return produto
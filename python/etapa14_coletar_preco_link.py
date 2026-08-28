import requests
from bs4 import BeautifulSoup


def coletar_preco_amazon(url):
    resposta = requests.get(url, timeout=10)

    resposta.raise_for_status()

    soup = BeautifulSoup(resposta.text, "html.parser")

    titulo = soup.select_one("#productTitle")
    preco_elemento = soup.select_one(".a-price .a-offscreen")

    if titulo is None:
        raise ValueError("Título do produto não encontrado.")

    if preco_elemento is None:
        raise ValueError("Preço do produto não encontrado.")

    nome_produto = titulo.get_text(strip=True)
    preco_texto = preco_elemento.get_text(strip=True)

    preco_limpo = (
        preco_texto
        .replace("R$", "")
        .replace(".", "")
        .replace(",", ".")
        .strip()
    )

    preco = float(preco_limpo)

    return {
        "nome": nome_produto,
        "preco": preco
    }
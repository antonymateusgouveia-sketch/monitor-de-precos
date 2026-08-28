import requests

url = "https://www.kabum.com.br/produto/885085/ssd-kingston-nv3-1tb-m-2-2230-nvme-pcie-4-0-leitura-6-000-mb-s-gravacao-5-000-mb-s-snv3sm3-1t0"

resposta = requests.get(url, timeout=10)

print("Status:", resposta.status_code)
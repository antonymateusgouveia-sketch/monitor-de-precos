# Monitor de Preços

Projeto de monitoramento e análise de preços desenvolvido com Python, MySQL e Excel.

O sistema coleta preços de produtos monitorados, armazena o histórico no banco de dados e permite analisar a evolução dos preços ao longo do tempo.

## Como funciona

O fluxo atual do projeto funciona da seguinte forma:

1. Os produtos e suas URLs são cadastrados no MySQL.
2. O Python consulta quais produtos estão ativos para monitoramento.
3. O script acessa a página do produto na Amazon.
4. O preço encontrado é tratado e convertido para formato numérico.
5. A nova coleta é salva no MySQL com data e hora.
6. O Agendador de Tarefas do Windows executa esse processo automaticamente a cada 2 dias.

## Tecnologias utilizadas

- **Python** — coleta, tratamento e automação dos preços.
- **MySQL** — armazenamento dos produtos, lojas e histórico de preços.
- **SQL** — consultas, métricas e análises dos dados.
- **Excel** — análise e criação de dashboards.
- **BeautifulSoup** — leitura das informações das páginas dos produtos.
- **Requests** — requisições HTTP para coleta dos dados.
- **Windows Task Scheduler** — execução automática da coleta.

## Estrutura do projeto

```text
monitor-de-precos/
├── python/
│   ├── etapa05_funcoes_banco.py
│   ├── etapa09_salvar_coleta.py
│   ├── etapa14_coletar_preco_link.py
│   └── etapa20_tratar_erros_coleta.py
│
├── sql/
│   ├── 01_criar_banco.sql
│   ├── 02_categorias.sql
│   ├── 03_produtos.sql
│   ├── 04_lojas.sql
│   ├── 05_produto_loja.sql
│   ├── 06_historico_precos.sql
│   ├── 07_consultas_analise.sql
│   ├── 08_metricas_precos.sql
│   └── 09_consultas_dashboard.sql
│
├── executar_coleta.bat
├── .gitignore
└── README.md
```


## Modelo do banco de dados

O banco de dados foi estruturado para separar produtos, categorias, lojas e o histórico de preços.

### Tabelas principais

- **categorias** — armazena as categorias dos produtos.
- **produtos** — armazena os produtos monitorados.
- **lojas** — armazena as lojas disponíveis.
- **produto_loja** — relaciona um produto a uma loja e guarda a URL usada no monitoramento.
- **historico_precos** — armazena cada preço coletado junto com a data e hora da coleta.

### Relacionamentos

```text
categorias
    │
    └── produtos
            │
            └── produto_loja ─── lojas
                    │
                    └── historico_precos
                    
```

## Métricas e análises

O projeto utiliza consultas SQL para gerar métricas importantes sobre a variação dos preços.

Entre as principais análises estão:

- Preço atual
- Preço anterior
- Diferença entre o preço atual e o anterior
- Variação percentual
- Menor preço histórico
- Maior preço histórico
- Preço médio
- Quantidade de coletas
- Produtos que aumentaram de preço
- Produtos que diminuíram de preço
- Produtos que mantiveram o mesmo preço
- Maior aumento registrado
- Maior queda registrada

### Exemplo de variação percentual

A variação entre o preço atual e o preço anterior é calculada utilizando funções de janela do MySQL, como `LAG()`.

```sql
ROUND(
    (
        preco - LAG(preco) OVER (
            PARTITION BY id_produto_loja
            ORDER BY data_coleta
        )
    )
    /
    LAG(preco) OVER (
        PARTITION BY id_produto_loja
        ORDER BY data_coleta
    ) * 100,
    2
) AS variacao_percentual

## Automação da coleta

A coleta de preços é executada automaticamente pelo Agendador de Tarefas do Windows.

Atualmente, o processo é executado a cada 2 dias.

O fluxo de automação funciona assim:

Agendador de Tarefas
        ↓
executar_coleta.bat
        ↓
Python
        ↓
Consulta produtos ativos no MySQL
        ↓
Coleta preços na Amazon
        ↓
Salva novas coletas no histórico

```

## Segurança e variáveis de ambiente

As credenciais de acesso ao MySQL não ficam armazenadas diretamente no código Python.

O projeto utiliza um arquivo `.env` para guardar informações como:

```text
MYSQL_HOST
MYSQL_PORT
MYSQL_USER
MYSQL_PASSWORD
MYSQL_DATABASE

```

## Status do projeto

O projeto já possui:

- Coleta de preços da Amazon
- Armazenamento do histórico no MySQL
- Monitoramento de múltiplos produtos
- Controle de produtos ativos e inativos
- Tratamento de erros durante a coleta
- Execução automática a cada 2 dias
- Consultas SQL para análise de preços
- Proteção das credenciais utilizando `.env`

## Próximos passos

- Integrar novas lojas ao monitoramento
- Implementar integração com Mercado Livre
- Conectar o MySQL ao Excel
- Criar análises com Power Query
- Desenvolver dashboard de preços no Excel
- Utilizar o histórico coletado para análises de tendência

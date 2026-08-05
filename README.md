# SQL_An-lise_Vendas
Projeto de análise de vendas em SQL Server utilizando Views, CTEs, Window Functions e consultas analíticas.
# Projeto SQL - Análise de Vendas

##  Sobre o projeto

Este projeto foi desenvolvido com o objetivo de praticar consultas SQL aplicadas à análise de dados de vendas, simulando situações comuns encontradas no dia a dia de um Analista de Dados.

Foi utilizada uma base de vendas modelada em esquema estrela (Fato e Dimensões), onde uma View foi criada para centralizar os relacionamentos entre as tabelas e facilitar a construção das análises.

---

##  Objetivos

Responder perguntas de negócio utilizando SQL, tais como:

- Quais clientes geram maior receita?
- Qual é o ticket médio das vendas?
- Quais produtos são mais vendidos?
- Como as vendas evoluem ao longo dos meses?
- Quais clientes possuem maior faturamento?
- Quais clientes podem ser classificados como VIP?
- Qual loja gera mais receita?
- Qual país gera maior faturamento?
- Qual produto possui maior índice de devolução?

---

##  Tecnologias utilizadas

- SQL Server
- T-SQL

---

##  Conceitos aplicados

Durante o desenvolvimento do projeto foram utilizados os seguintes recursos:

- Views
- INNER JOIN
- Common Table Expressions (CTE)
- GROUP BY
- Funções de agregação (SUM e AVG)
- CASE
- Window Functions
  - RANK()
  - LAG()
- CAST
- ORDER BY

---

##  Modelagem utilizada

O projeto utiliza uma tabela fato contendo as vendas e tabelas dimensão para informações complementares.

### Tabelas

**Fato**

- FVendas
- FDevoluções

**Dimensões**

- DCadastro Clientes
- DCadastro Produtos
- DCadastro Lojas
- DCadastro Localidades

Foi criada a View **vw_Fato**, responsável por consolidar os relacionamentos entre as tabelas, simplificando a elaboração das consultas analíticas.

---

##  Indicadores desenvolvidos

- Top 10 clientes por receita
- Ticket médio
- Produtos mais vendidos
- Crescimento mensal das vendas
- Ranking de clientes
- Classificação de clientes (Ouro, Prata e Bronze)
- Receita por loja
- Receita por país
- Índice de devolução por produto

---

##  Estrutura do repositório

```
sql-analise-vendas
│
├── Projeto SQL - Análise de Vendas.sql
├── README.md
└── imagens
```

---

## Autora

**Ana Quirino**

Projeto desenvolvido para fins de estudo e composição de portfólio na área de Análise de Dados.

/*==================================================
    PROJETO SQL - ANÁLISE DE VENDAS
==================================================*/
ALTER VIEW vw_Fato AS
SELECT
u.País,
V.ID_Loja,
v.ID_Cliente,
v.SKU,
v.ID_Venda,
v.ordem_de_compra,
v.Data_da_Venda,
c.Nome_Completo,  
u.ID_Localidade,  
l.Nome_da_Loja,  
p.Produto,  
p.Preço_Unitario,  
v.Qtd_Vendida,  
v.Qtd_Vendida * p.Preço_Unitario AS Receita 
FROM FVendas AS v  
INNER JOIN [DCadastro Clientes] AS c  
    ON v.ID_Cliente = c.ID_Cliente  
INNER JOIN DCadastro_Produtos AS p  
    ON v.SKU = p.SKU  
INNER JOIN [DCadastro Lojas] AS l  
    ON v.ID_Loja = l.ID_Loja  
INNER JOIN[DCadastro Localidades] AS u  
ON l.id_Localidade = u.ID_Localidade;


/*==================================================
    Quais clientes compram mais?
==================================================*/

SELECT TOP 10
Nome_Completo,
SUM(Receita) AS Receita_Total
FROM vw_Fato
GROUP BY Nome_Completo
ORDER BY Receita_Total DESC;

/*==================================================
    Qual o Ticket Médio?
==================================================*/

SELECT
AVG(Valor_Venda) AS Ticket_Medio
FROM(
SELECT
ID_Venda,
SUM(Receita) AS Valor_Venda
FROM vw_Fato
GROUP BY ID_Venda
) AS Vendas;

/*==================================================
    Qual produto mais vendido?
==================================================*/

SELECT TOP 10
Produto,
SUM(Qtd_Vendida) AS Total_Vendido
FROM vw_Fato
GROUP BY Produto
ORDER BY Total_Vendido DESC;

/*==================================================
    Qual o crescimento mensal?
==================================================*/

WITH ReceitaMensal AS
(
SELECT
YEAR(Data_da_Venda) AS Ano,
MONTH(Data_da_Venda) AS Mes,
SUM(Receita) AS Receita
FROM vw_Fato
GROUP BY
YEAR(Data_da_Venda),
MONTH(Data_da_Venda)
)
SELECT
Ano,
Mes,
Receita,
LAG(Receita) OVER (ORDER BY Ano, Mes) AS Mes_Anterior,
Receita - LAG(Receita) OVER (ORDER BY Ano, Mes) AS Variacao
FROM ReceitaMensal
ORDER BY Ano, Mes;

/*==================================================
    Ranking de clientes
==================================================*/

WITH ReceitaCliente AS
(
SELECT
Nome_Completo,
SUM(RECEITA) AS Receita
FROM vw_Fato
GROUP BY Nome_Completo
)
SELECT
Nome_Completo,
Receita,
RANK() OVER (ORDER BY Receita DESC) AS Ranking
FROM ReceitaCliente;


/*==================================================
    Clientes VIP
==================================================*/
WITH ReceitaCliente AS
(
SELECT
Nome_Completo,
SUM(RECEITA) AS Receita
FROM vw_Fato
GROUP BY Nome_Completo
)
SELECT
Nome_Completo,
Receita,
CASE
WHEN Receita >= 10000 THEN 'Cliente Ouro'
WHEN Receita >= 5000 THEN 'Cliente Prata'
ELSE 'Bronze'
END AS Categoria
FROM ReceitaCliente
ORDER BY Receita DESC;

/*==================================================
    Qual loja gera mais receita?
==================================================*/

SELECT TOP 10
Nome_da_Loja,
SUM(Qtd_Vendida) AS Quantidade_Vendida,
SUM(Receita) AS Receita_Total
FROM vw_Fato
GROUP BY Nome_da_Loja
ORDER BY Receita_Total DESC;

/*==================================================
    Qual país gera mais receita?
==================================================*/

SELECT
País,
SUM(Receita) AS Receita_Total
FROM vw_Fato
GROUP BY País
ORDER BY Receita_Total DESC;

/*==================================================
    Produto com maior índice de devolução
==================================================*/

WITH Vendas AS
(
SELECT
SKU,
SUM(Qtd_Vendida) AS Total_Vendido
FROM FVendas
GROUP BY SKU
),
Devolucoes AS
(
SELECT
SKU,
SUM(Qtd_Devolvida) AS Total_Devolvido
FROM FDevoluções
GROUP BY SKU
)
SELECT TOP 1
P.Produto,
D.Total_Devolvido,
V.Total_Vendido,
CAST(
CAST (D.Total_Devolvido * 100.0 / V.Total_Vendido  AS DECIMAL(5,2)) AS VARCHAR(100)) + '%' AS Percentual
FROM Devolucoes AS D
INNER JOIN Vendas AS V
ON D.SKU = V.SKU
INNER JOIN DCadastro_Produtos AS P
ON D.SKU = P.SKU
ORDER BY
D.Total_Devolvido * 100.0 / V.Total_Vendido DESC;
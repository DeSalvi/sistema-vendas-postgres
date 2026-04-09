-- Resumo da Venda
CREATE VIEW VIEW_DETALHE_VENDAS AS
SELECT v.id AS venda_id, v.data, c.nome AS cliente, v.total
FROM venda v
JOIN cliente c ON v.id_cliente = c.id;

-- Ranking de Produtos Mais Vendidos
CREATE VIEW VIEW_PRODUTOS_MAIS_VENDIDOS AS
SELECT p.nome, SUM(vp.quantidade) AS total_vendido
FROM venda_produto vp
JOIN produto p ON vp.id_produto = p.id
GROUP BY p.nome
ORDER BY total_vendido DESC;

-- Faturamento Diário
CREATE VIEW VIEW_FATURAMENTO_DIARIO AS
SELECT data, SUM(total) AS faturamento_total
FROM venda
GROUP BY data
ORDER BY data DESC;

-- Clientes que Mais Gastam
CREATE VIEW VIEW_RANKING_CLIENTES AS
SELECT c.nome, SUM(v.total) AS total_gasto
FROM venda v
JOIN cliente c ON v.id_cliente = c.id
GROUP BY c.nome
ORDER BY total_gasto DESC;

-- Alerta de Estoque Crítico 
CREATE VIEW VIEW_ESTOQUE_CRITICO AS
SELECT nome, estoque_atual
FROM produto
WHERE estoque_atual < 5;
-- Inserção de Usuários
INSERT INTO usuario (nome, senha, email, cargo) VALUES 
('Alice Oliveira', 'hash_senha_123', 'alice.vendas@empresa.com', 'VENDEDOR'),
('Bruno Souza', 'hash_senha_456', 'bruno.gerente@empresa.com', 'GERENTE'),
('Carlos Lima', 'hash_senha_789', 'carlos.vendas@empresa.com', 'VENDEDOR');
('Mariana Costa', 'hash_senha_001', 'mariana.cliente@empresa.com', 'CLIENTE'),
('João Pereira', 'hash_senha_002', 'joao.cliente@empresa.com', 'CLIENTE'),
('Fernanda Alves', 'hash_senha_003', 'fernanda.cliente@empresa.com', 'CLIENTE'),
('Ricardo Mendes', 'hash_senha_004', 'ricardo.cliente@empresa.com', 'CLIENTE');

-- Inserção de Produtos
INSERT INTO produto (nome, descricao, valor) VALUES 
('Smartphone X', 'Celular de última geração', 2500.00),
('Fone de Ouvido Bluetooth', 'Cancelamento de ruído ativo', 450.00),
('Monitor 24 Polegadas', 'Painel IPS Full HD', 900.00),
('Cabo HDMI 2.0', '4K 60Hz - 2 metros', 35.00);

-- Inserção de Estoque
INSERT INTO estoque (id_produto, quantidade) VALUES 
(1, 50),
(2, 100),
(3, 30),
(4, 200);

-- Inserção de Lotes
INSERT INTO lote (id_produto, quantidade, validade) VALUES 
(1, 25, '2027-12-31'),
(1, 25, '2028-06-30'),
(2, 100, '2029-01-01'),
(4, 200, '2030-10-15');

-- Inserção de Vendas
-- O total será atualizado pela sua trigger de soma
INSERT INTO venda (id_vendedor, data) VALUES 
(1, '2026-04-01 10:30:00'),
(3, '2026-04-02 14:20:00'),
(1, CURRENT_TIMESTAMP);

-- Inserção de Itens das Vendas
INSERT INTO venda_produto (id_venda, id_produto, quantidade, valor) VALUES 
(1, 1, 1, 2500.00), -- Venda 1: 1 Smartphone
(1, 4, 2, 35.00),   -- Venda 1: 2 Cabos HDMI
(2, 3, 2, 900.00),  -- Venda 2: 2 Monitores
(3, 2, 3, 450.00);  -- Venda 3: 3 Fones de Ouvido

-- Inserção de Logs de Alteração
INSERT INTO log_produto (id_produto, operacao, valor_antigo, valor_novo) VALUES 
(1, 'UPDATE', 2300.00, 2500.00),
(2, 'UPDATE', 400.00, 450.00);


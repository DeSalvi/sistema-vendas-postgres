-- Tabela de Usuários

CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    senha VARCHAR(255),
    email VARCHAR(155) UNIQUE,
    ativo BOOLEAN DEFAULT TRUE,
    cargo VARCHAR(50),
   
    CONSTRAINT cargo_valido
    CHECK (cargo IN ('CLIENTE', 'VENDEDOR', 'GERENTE')),

    CONSTRAINT email_formato_invalido
    CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Tabela de Produtos

CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(255),
    valor NUMERIC(10,2),

    CONSTRAINT valor_negativo CHECK (valor >= 0)
);

-- Tabela de vendas

CREATE TABLE venda (
    id SERIAL PRIMARY KEY,
    id_vendedor INTEGER,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(10,2) DEFAULT 0,

    FOREIGN KEY (id_vendedor) REFERENCES usuario(id)
);

-- Tabela relacional de vendas e produtos

CREATE TABLE venda_produto (
    id SERIAL PRIMARY KEY,
    quantidade INTEGER,
    id_produto INTEGER,
    id_venda INTEGER,
    valor NUMERIC(10,2),

    CONSTRAINT quantidade_positiva CHECK (quantidade > 0),

    FOREIGN KEY (id_produto) REFERENCES produto(id),
    FOREIGN KEY (id_venda) REFERENCES venda(id)
);

-- Tabela de estoque

CREATE TABLE estoque (
    id_produto INTEGER PRIMARY KEY,
    quantidade INTEGER,

    FOREIGN KEY (id_produto) REFERENCES produto(id)
);

-- Tabela de lote

CREATE TABLE lote (
    id SERIAL PRIMARY KEY,
    id_produto INTEGER,
    quantidade INTEGER,
    validade DATE,

    FOREIGN KEY (id_produto) REFERENCES produto(id)
);

-- Tabela de log

CREATE TABLE log_produto (
    id SERIAL PRIMARY KEY,
    id_produto INTEGER,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_antigo NUMERIC(10,2),
    valor_novo NUMERIC(10,2)
);

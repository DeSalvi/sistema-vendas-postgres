-- Função para Atualizar o total da venda

CREATE OR REPLACE FUNCTION ATUALIZAR_TOTAL_VENDA()
RETURNS TRIGGER AS $$
BEGIN

    IF (TG_OP = 'DELETE') THEN
        UPDATE venda
        SET total = (SELECT COALESCE(SUM(quantidade * valor), 0) FROM venda_produto WHERE id_venda = OLD.id_venda)
        WHERE id = OLD.id_venda;
    ELSE
        UPDATE venda
        SET total = (SELECT COALESCE(SUM(quantidade * valor), 0) FROM venda_produto WHERE id_venda = NEW.id_venda)
        WHERE id = NEW.id_venda;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Trigger para Atualizar o total da venda

CREATE TRIGGER TRIGGER_ATUALIZAR_TOTAL
AFTER INSERT OR UPDATE OR DELETE ON venda_produto
FOR EACH ROW
EXECUTE FUNCTION ATUALIZAR_TOTAL_VENDA();

-- Função para baixar estoque

CREATE OR REPLACE FUNCTION BAIXA_ESTOQUE()
RETURNS TRIGGER AS $$
BEGIN

-- Validação de estoque
IF (SELECT quantidade FROM estoque WHERE id_produto = NEW.id_produto) < NEW.quantidade THEN
    RAISE EXCEPTION 'Estoque insuficiente';
END IF;

UPDATE estoque
SET quantidade = quantidade - NEW.quantidade
WHERE id_produto = NEW.id_produto;

RETURN NEW;

END;
$$ LANGUAGE plpgsql;

-- Trigger para baixar estoque

CREATE TRIGGER TRIGGER_BAIXA_ESTOQUE
AFTER INSERT ON venda_produto
FOR EACH ROW
EXECUTE FUNCTION BAIXA_ESTOQUE();

-- Função para registrar log de alteração do produto

CREATE OR REPLACE FUNCTION LOG_ALTERACAO_PRODUTO()
RETURNS TRIGGER AS $$
BEGIN

IF TG_OP = 'INSERT' THEN
    INSERT INTO log_produto (id_produto, operacao, valor_novo)
    VALUES (NEW.id, 'INSERT', NEW.valor);

ELSE IF TG_OP = 'UPDATE' THEN
    INSERT INTO log_produto (id_produto, operacao, valor_antigo, valor_novo)
    VALUES (OLD.id, 'UPDATE', OLD.valor, NEW.valor);

ELSE IF TG_OP = 'DELETE' THEN
    INSERT INTO log_produto (id_produto, operacao, valor_antigo)
    VALUES (OLD.id, 'DELETE', OLD.valor);

ELSE
    RAISE EXCEPTION 'Operação não esperada: %', TG_OP;

RETURN NEW;

END;
$$ LANGUAGE plpgsql;

-- Trigger para registrar log de alteração do produto

CREATE TRIGGER TRIGGER_LOG_PRODUTO
AFTER INSERT OR UPDATE OR DELETE ON produto
FOR EACH ROW
EXECUTE FUNCTION LOG_ALTERACAO_PRODUTO();

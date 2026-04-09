# 🛒 Sistema de Gestão de Vendas (SQL)

Este repositório contém a estrutura de um banco de dados relacional para controle de vendas e estoque, com automação de cálculos via Triggers.

## 🗂️ Organização dos Arquivos
Para configurar o banco corretamente, execute os arquivos na pasta `/sql` em um SGDB com suporte para PlPgSQL seguindo a ordem numérica:

1.  **`01_schema.sql`**: Cria as tabelas e relacionamentos
2.  **`02_triggers.sql`**: Configura a automação E logs de operações
3.  **`03_views.sql`**: Cria relatórios prontos para consulta (Faturamento, Estoque, etc).
4.  **`04_seed.sql`**: Popula o banco com dados de exemplo.

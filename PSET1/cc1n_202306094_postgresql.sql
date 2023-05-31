/*
_____________________________________
|      PROJETO PSET1 ABRANTES       |
|-----------------------------------|
| ALUNO: Ramsés de Oliveira Martins |
| TURMA: CC1N                       |
-------------------------------------
*/

-- Apagando o banco de dados "uvv" se existir
DROP DATABASE IF EXISTS uvv;

-- Deletando do usuário 'ramses' se existir
DROP USER IF EXISTS ramses;

-- Criação do usuário 'ramses' com permissão para criar bancos de dados e usuários com senha criptografada
CREATE USER ramses WITH CREATEDB CREATEROLE ENCRYPTED PASSWORD 'ramses123';

-- Criação do banco de dados "uvv" com o usuário 'ramses' como proprietário
CREATE DATABASE uvv
    WITH 
    OWNER = ramses
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;



-- Conectando como usuário 'ramses' 
\c "dbname=uvv user=ramses password=ramses123";

-- Criação do esquema "lojas" com o usuário 'ramses' como proprietário
CREATE SCHEMA lojas AUTHORIZATION ramses;

-- Configurando o esquema "lojas" como o padrão para o usuário 'ramses'
SET search_path TO lojas;


/*

__________________________________________
|CRIANDO AS TABELAS E COMENTANDO OS CAMPOS|
-------------------------------------------

*/

-- CRIANDO TABELA DE PRODUTOS
CREATE TABLE lojas.produtos (
    produto_id              NUMERIC(38) NOT NULL,
    nome                    VARCHAR(255) NOT NULL,
    preco_unitario          NUMERIC(10,2),
    detalhes                BYTEA,
    imagem                  BYTEA,
    imagem_mime_type        VARCHAR(512),
    imagem_arquivo          VARCHAR(512),
    imagem_charset          VARCHAR(512),
    imagem_ultima_atualizacao DATE,
    CONSTRAINT pk_produto PRIMARY KEY (produto_id)
);

-- COMENTANDO OS CAMPOS DA TABELA
COMMENT ON TABLE lojas.produtos IS 'Tabela para cadastro de produtos';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'ID do produto';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço da unidade do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Arquivo com mais detalhes e informações do produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem representativa do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Tipo MIME da imagem (PNG/JPEG)';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Caminho do arquivo da imagem';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Charset / Encode da imagem';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data da última atualização da imagem do produto';

/***************************************************************************************************/

-- CRIANDO A TABELA LOJAS
CREATE TABLE lojas.lojas (
    loja_id                     NUMERIC(38) NOT NULL,
    nome                        VARCHAR(255) NOT NULL,
    endereco_web                VARCHAR(100),
    endereco_fisico             VARCHAR(512),
    latitude                    NUMERIC,
    longitude                   NUMERIC,
    logo                        BYTEA,
    logo_mime_type              VARCHAR(512),
    logo_arquivo                VARCHAR(512),
    logo_charset                VARCHAR(512),
    logo_ultima_atualizacao     DATE,
    CONSTRAINT pk_loja PRIMARY KEY (loja_id)
);

-- COMENTANDO OS CAMPOS DA TABELA
COMMENT ON TABLE lojas.lojas IS 'Tabela usada para cadastrar as lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Identificador único da tabela Lojas';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da loja cadastrada';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereço Web ou site da loja';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereço físico da loja';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude da localização de onde se encontra a loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude da localização de onde se encontra a loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'Arquivo binário da logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Tipo do arquivo binário importado';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Caminho/Descrição do logo';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Indicador de codificação da logo';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última modificação realizada na logo';

/***************************************************************************************************/

-- CRIANDO A TABELA ESTOQUE
CREATE TABLE lojas.estoques (
    estoque_id   NUMERIC(38) NOT NULL,
    produto_id   NUMERIC(38) NOT NULL,
    loja_id      NUMERIC(38) NOT NULL,
    quantidade   NUMERIC(38) NOT NULL,
    CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

-- COMENTANDO OS CAMPOS DA TABELA ESTOQUE
COMMENT ON TABLE lojas.estoques IS 'Tabela para armazenar o estoque de produtos por empresa';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Identificador único da tabela Estoques';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Identificador único do produto';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Identificador único da loja';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade em estoque do produto na loja';

/***************************************************************************************************/

-- CRIANDO A TABELA DE CLIENTES
CREATE TABLE lojas.clientes (
    cliente_id   NUMERIC(38) NOT NULL,
    email        VARCHAR(255) NOT NULL,
    nome         VARCHAR(255) NOT NULL,
    telefone1    VARCHAR(20),
    telefone2    VARCHAR(20),
    CONSTRAINT pk_cliente PRIMARY KEY (cliente_id)
);

-- COMENTANDO A TABELA CLIENTES E OS CAMPOS DA MESMA
COMMENT ON TABLE lojas.clientes IS 'Tabela usada para cadastro dos clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Identificador único da tabela Clientes';
COMMENT ON COLUMN lojas.clientes.email IS 'Email para contato do cliente';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome completo do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS '1° Telefone para contato';
COMMENT ON COLUMN lojas.clientes.telefone2 IS '2° Telefone para contato';

/***************************************************************************************************/

-- CRIANDO A TABELA PEDIDOS
CREATE TABLE lojas.pedidos (
    pedido_id   NUMERIC(38) NOT NULL,
    data_hora   TIMESTAMP NOT NULL,
    status      VARCHAR(15) NOT NULL,
    loja_id     NUMERIC(38) NOT NULL,
    cliente_id  NUMERIC(38) NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (pedido_id)
);

-- COMENTANDO A TABELA PEDIDOS E OS CAMPOS DA MESMA
COMMENT ON TABLE lojas.pedidos IS 'Tabela que armazena as informações dos pedidos realizados pelos clientes';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Identificador único da tabela Pedidos';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e hora da realização do pedido';
COMMENT ON COLUMN lojas.pedidos.status IS 'Status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Identificador único da tabela Lojas';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Identificador único da tabela Clientes';

/***************************************************************************************************/

-- CRIANDO A TABELA ENVIOS
CREATE TABLE lojas.envios (
    envio_id          NUMERIC(38) NOT NULL,
    cliente_id        NUMERIC(38) NOT NULL,
    endereco_entrega  VARCHAR(512) NOT NULL,
    status            VARCHAR(15) NOT NULL,
    loja_id           NUMERIC(38) NOT NULL,
    CONSTRAINT pk_envio PRIMARY KEY (envio_id)
);

-- COMENTANDO A TABELA ENVIOS E OS CAMPOS DA MESMA
COMMENT ON TABLE lojas.envios IS 'Tabela para cadastro de envios de pedidos aos clientes.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Identificador único na tabela Envios';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Identificador único da tabela Clientes';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço de entrega do pedido';
COMMENT ON COLUMN lojas.envios.status IS 'Status de envio do pedido';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Identificador único da tabela Lojas';

/***************************************************************************************************/

-- CRIANDO A TABELA PEDIDOS_ITENS
CREATE TABLE lojas.pedidos_itens (
    produto_id        NUMERIC(38) NOT NULL,
    pedido_id         NUMERIC(38) NOT NULL,
    numero_da_linha   VARCHAR NOT NULL,
    preco_unitario    NUMERIC(10,2) NOT NULL,
    quantidade        NUMERIC(38) NOT NULL,
    envio_id          NUMERIC(38),
    CONSTRAINT pk_pedidos_itens PRIMARY KEY (produto_id, pedido_id)
);

-- COMENTANDO A TABELA PEDIDOS_ITENS E OS CAMPOS DA MESMA
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela para armazenar os itens contidos/solicitados em cada pedido';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Identificador único da tabela Pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Número da linha em que o item está no pedido';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço/Valor unitário do produto no pedido';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade do item no pedido';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Identificador único na tabela Envios';

/***************************************************************************************************/


-- Adicionando restrição de chave estrangeira (produto_id) à tabela estoques
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
    FOREIGN KEY (produto_id)
    REFERENCES lojas.produtos (produto_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

-- Adicionando a restrição de chave estrangeira (produto_id) na tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
    FOREIGN KEY (produto_id)
    REFERENCES lojas.produtos (produto_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


-- Adicionando a restrição de chave estrangeira (loja_id) na tabela envios
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
    FOREIGN KEY (loja_id)
    REFERENCES lojas.lojas (loja_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
--Adicionando CHECK CONSTRAINT para STATUS    
ALTER  TABLE lojas.envios ADD CONSTRAINT lojas_envios_verifica_status CHECK (status in ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

--Adicionando a restrição de chave estrangeira (loja_id) na tabela pedidos
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER  TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_verifica_status CHECK (status in ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

--Adicionando a restrição de chave estrangeira (loja_id) na tabela estoques
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
ALTER  TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_verifica_quantidade CHECK (quantidade >= 0);

--Adicionando a restrição de chave estrangeira (cliente_id) na tabela envios
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando a restrição de chave estrangeira (cliente_id) na tabela pedidos
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando a restrição de chave estrangeira (pedido_id) na tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando a restrição de chave estrangeira (envio_id) na tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER  TABLE lojas.produtos ADD CONSTRAINT lojas_produtos_verifica_preco_unitario CHECK (preco_unitario >= 0);

ALTER  TABLE lojas.pedidos_itens ADD CONSTRAINT lojas_pedidos_itens _verifica_preco_unitario CHECK (preco_unitario >= 0);

\dt lojas.*

# PSET1 - Modelagem de Dados das Lojas UVV

Neste PSET1, foi realizada a modelagem de dados das Lojas UVV, seguida da criação de um script SQL para a geração das tabelas no PostgreSQL. Abaixo estão as instruções para realizar essas tarefas.

## Descrição

O PSET1 consiste em realizar a modelagem de dados para o sistema de gerenciamento das Lojas UVV. O objetivo é criar um conjunto de tabelas que represente adequadamente as entidades e relacionamentos necessários para o funcionamento do sistema.

## Modelagem de Dados

A modelagem de dados foi realizada com base nas seguintes entidades:

- Clientes
- Lojas
- Produto
- Pedidos
- Item de Pedido
- Envios
- Estoque

Foram estabelecidos os relacionamentos entre essas entidades, de modo a representar corretamente as interações entre elas.

## Diagrama de Modelagem de Dados

O diagrama de modelagem de dados das Lojas UVV está disponível no repositório. Para acessá-lo, consulte o arquivo [Diagrama_Modelagem_Dados.png](link_para_o_diagrama) na pasta PSET1.

## Orientações da Atividade

As orientações detalhadas para a realização desta atividade estão disponíveis no repositório. Para acessá-las, consulte o arquivo [Orientacoes_PSET1.pdf](link_para_orientacoes) na pasta PSET1.

## Script SQL para Geração das Tabelas

Um script SQL foi elaborado para a criação das tabelas no PostgreSQL. Ele contém as instruções necessárias para criar as tabelas com seus respectivos campos e relacionamentos.

O código SQL para a criação das tabelas está disponível no arquivo "cc1n_202306094_postgresql.sql" neste repositório. Recomenda-se executar esse script no ambiente PostgreSQL para gerar as tabelas.

## Executando o Script SQL

Para executar o script SQL e gerar as tabelas, siga as etapas abaixo:

1. Certifique-se de que o PostgreSQL esteja instalado e em execução em sua máquina.

2. Abra o terminal ou prompt de comando.

3. Navegue até o diretório onde o arquivo "cc1n_202306094_postgresql.sql" está localizado.

4. Execute o seguinte comando para executar o script SQL:

   ```bash
   psql -U postgres < cc1n_202306094_postgresql.sql

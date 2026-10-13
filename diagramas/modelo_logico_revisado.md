# Modelo lógico relacional — versão revisada

Representação das tabelas, PK/FK e relações. Código Mermaid para visualização no GitHub; tipos e constraints completos no [script SQL](../docs/script.sql) e [dicionário de dados](../docs/dicionario_dados.html).

```mermaid
erDiagram
 CLIENTE ||--o{ ATENDIMENTO : realiza
 FUNCIONARIO ||--o{ ATENDIMENTO : atende
 ATENDIMENTO ||--o| RECEITA : gera
 ATENDIMENTO ||--o| PEDIDO : origina
 RECEITA ||--o| PEDIDO : utilizada
 RECEITA ||--|{ MEDIDA_RECEITA : descreve
 PEDIDO ||--|{ ITEM_PEDIDO : contem
 PRODUTO ||--o{ ITEM_PEDIDO : integra
 PEDIDO ||--o{ PAGAMENTO : recebe
 PEDIDO ||--o{ COMPRA : demanda
 FORNECEDOR ||--o{ COMPRA : fornece
 FUNCIONARIO ||--o{ COMPRA : solicita
 COMPRA ||--|{ ITEM_COMPRA : contem
 PRODUTO ||--o{ ITEM_COMPRA : comprado
 CATEGORIA ||--o{ PRODUTO : classifica
 PEDIDO ||--o| MONTAGEM : monta
 FUNCIONARIO ||--o{ MONTAGEM : acompanha
 PEDIDO ||--o{ TROCA : registra
 FUNCIONARIO ||--o{ TROCA : processa
 TROCA ||--|{ ITEM_TROCA : discrimina
 PRODUTO ||--o{ ITEM_TROCA : refere
 PRODUTO ||--o{ MOVIMENTACAO_ESTOQUE : movimenta
 COMPRA |o--o{ MOVIMENTACAO_ESTOQUE : entrada
 PEDIDO |o--o{ MOVIMENTACAO_ESTOQUE : saida
 TROCA |o--o{ MOVIMENTACAO_ESTOQUE : troca
 CLIENTE { INT id_cliente PK
 VARCHAR nome
 VARCHAR telefone
 VARCHAR email
 }
 FUNCIONARIO { INT id_funcionario PK
 VARCHAR nome
 VARCHAR funcao
 }
 ATENDIMENTO { INT id_atendimento PK
 INT id_cliente FK
 INT id_funcionario FK
 DATE data_atendimento
 }
 RECEITA { INT id_receita PK
 INT id_atendimento FK,UK
 VARCHAR origem
 DATE data_receita
 }
 MEDIDA_RECEITA { INT id_receita PK,FK
 CHAR olho PK
 VARCHAR distancia PK
 DECIMAL esferico
 DECIMAL cilindrico
 SMALLINT eixo
 }
 PEDIDO { INT id_pedido PK
 INT id_atendimento FK,UK
 INT id_receita FK,UK
 DATE data_pedido
 VARCHAR status
 DECIMAL desconto
 }
 ITEM_PEDIDO { INT id_pedido PK,FK
 INT id_produto PK,FK
 INT quantidade
 DECIMAL preco_unitario
 }
 PAGAMENTO { INT id_pagamento PK
 INT id_pedido FK
 SMALLINT numero_parcela
 DECIMAL valor
 VARCHAR forma
 }
 FORNECEDOR { INT id_fornecedor PK
 VARCHAR nome
 }
 CATEGORIA { INT id_categoria PK
 VARCHAR nome UK
 }
 PRODUTO { INT id_produto PK
 INT id_categoria FK
 VARCHAR sku UK
 VARCHAR descricao
 }
 COMPRA { INT id_compra PK
 INT id_pedido FK
 INT id_fornecedor FK
 INT id_funcionario FK
 }
 ITEM_COMPRA { INT id_compra PK,FK
 INT id_produto PK,FK
 INT quantidade
 DECIMAL custo_unitario
 }
 MONTAGEM { INT id_montagem PK
 INT id_pedido FK,UK
 INT id_funcionario FK
 DATE data_conclusao
 DATE data_retirada
 }
 TROCA { INT id_troca PK
 INT id_pedido FK
 INT id_funcionario FK
 VARCHAR motivo
 }
 ITEM_TROCA { INT id_troca PK,FK
 INT id_produto PK,FK
 INT quantidade
 VARCHAR destino
 }
 MOVIMENTACAO_ESTOQUE { INT id_movimento PK
 INT id_produto FK
 INT id_compra FK
 INT id_pedido FK
 INT id_troca FK
 INT quantidade
 }
```

**Notação requerida no trabalho final:** brModelo (com tipos, PK, FK e cardinalidades (mín,máx)); converter/validar este desenho se necessário.

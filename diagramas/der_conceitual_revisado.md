# DER conceitual revisado — Ótica Kadosh

**Notação visual:** retângulos para entidades, losangos para relacionamentos e cardinalidades (mín,máx); identificadores sublinhados. **Sem FK no DER conceitual**. Este diagrama é uma representação textual para conferência; para aderir estritamente à rubrica, exportar também a representação no brModelo.

| Entidade | Identificador | Atributos principais |
|---|---|---|
| CLIENTE | id_cliente | nome, telefone, e-mail, bairro, CEP |
| FUNCIONARIO | id_funcionario | nome, função, ativo |
| ATENDIMENTO | id_atendimento | data, procedimento, meio de contato |
| RECEITA | id_receita | origem, data, observação |
| MEDIDA_RECEITA | (id_receita, olho, distancia) | esférico, cilíndrico, eixo, DNP, altura |
| PEDIDO | id_pedido | data, status, desconto, observações |
| ITEM_PEDIDO | (id_pedido, id_produto) | quantidade, preço praticado |
| PAGAMENTO | id_pagamento | parcela, forma, valor, vencimento, quitação |
| PRODUTO | id_produto | SKU, descrição, preço de referência, mínimo |
| CATEGORIA | id_categoria | nome |
| FORNECEDOR | id_fornecedor | nome, telefone |
| COMPRA | id_compra | solicitação, chegada, status |
| ITEM_COMPRA | (id_compra,id_produto) | quantidade, custo unitário |
| MONTAGEM | id_montagem | início, previsão, conclusão, retirada |
| TROCA | id_troca | data, motivo, valor cobrado, status |
| ITEM_TROCA | (id_troca,id_produto) | quantidade, destino |
| MOVIMENTACAO_ESTOQUE | id_movimento | data, tipo, quantidade, origem |

## Relações conceituais e participações propostas

| Relacionamento (losango) | Lado A | Lado B |
|---|---|---|
| REALIZA | CLIENTE (0,N) | ATENDIMENTO (1,1) |
| ATENDE | FUNCIONARIO (0,N) | ATENDIMENTO (1,1) |
| REGISTRA | ATENDIMENTO (0,1) | PEDIDO (1,1) |
| PRODUZ | ATENDIMENTO (0,1) | RECEITA (1,1) |
| UTILIZA | RECEITA (0,1) | PEDIDO (1,1) |
| CONTÉM_MEDIDAS | RECEITA (1,N) | MEDIDA_RECEITA (1,1) |
| COMPOSTO_POR | PEDIDO (1,N) | ITEM_PEDIDO (1,1) |
| REFERE_PRODUTO | PRODUTO (0,N) | ITEM_PEDIDO (1,1) |
| PARCELADO_EM | PEDIDO (0,N) | PAGAMENTO (1,1) |
| NECESSITA_COMPRA | PEDIDO (0,N) | COMPRA (1,1) |
| FORNECE | FORNECEDOR (0,N) | COMPRA (1,1) |
| CONTÉM_ITEM_COMPRA | COMPRA (1,N) | ITEM_COMPRA (1,1) |
| COMPRA_PRODUTO | PRODUTO (0,N) | ITEM_COMPRA (1,1) |
| MONTA | PEDIDO (0,1) | MONTAGEM (1,1) |
| REQUER_TROCA | PEDIDO (0,N) | TROCA (1,1) |
| ABRANGE_PEÇAS | TROCA (1,N) | ITEM_TROCA (1,1) |
| CATEGORIZA | CATEGORIA (0,N) | PRODUTO (1,1) |
| MOVIMENTA | PRODUTO (0,N) | MOVIMENTACAO_ESTOQUE (1,1) |

**Nota:** no SQL, algumas participações mínimas entre linhas (ex.: pedido possuir pelo menos um item) são auditadas, não asseguradas por FK isolada. Validar cardinalidades com a organização e correção do professor.

# Modelo lógico proposto (não é o DER final validado)

```mermaid
erDiagram
    CLIENTE ||--o{ VENDA : realiza
    FUNCIONARIO ||--o{ VENDA : registra
    FUNCIONARIO ||--o{ COMPRA : solicita
    FORNECEDOR ||--o{ COMPRA : fornece
    CATEGORIA ||--o{ PRODUTO : classifica
    COMPRA ||--|{ ITEM_COMPRA : contem
    PRODUTO ||--o{ ITEM_COMPRA : comprado
    VENDA ||--|{ ITEM_VENDA : contem
    PRODUTO ||--o{ ITEM_VENDA : vendido
    VENDA ||--o{ PAGAMENTO : recebe
    PRODUTO ||--o{ MOVIMENTACAO_ESTOQUE : movimenta
    COMPRA |o--o{ MOVIMENTACAO_ESTOQUE : origina
    VENDA |o--o{ MOVIMENTACAO_ESTOQUE : origina
    VENDA ||--o| ORDEM_MONTAGEM : possui
    FUNCIONARIO ||--o{ ORDEM_MONTAGEM : acompanha
```

**Atenção:** representação Mermaid para consulta rápida. O original da E1 foi produzido com notação brModelo e tem escopo maior: [DER original](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados/blob/main/DER_conceitual_BRMW_HD.jpg). A cardinalidade aqui é proposição, não correção final homologada.

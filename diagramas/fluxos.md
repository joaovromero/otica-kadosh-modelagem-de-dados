# Fluxos operacionais propostos

## Venda

```mermaid
flowchart LR
 A[Atendimento] --> B[Selecionar produtos]
 B --> C[Registrar pedido/venda]
 C --> D[Receber pagamentos]
 D --> E[Separar estoque e montar]
 E --> F[Retirada e acompanhamento]
```

## Compra

```mermaid
flowchart LR
 A[Conferir necessidade] --> B[Solicitar a fornecedor]
 B --> C[Registrar itens]
 C --> D[Receber mercadoria]
 D --> E[Registrar entrada de estoque]
```

Fluxos reduzidos para demonstração da proposta técnica. Consultar os processos relatados na Entrega 1, que incluem receita/laudo, garantia e trocas.

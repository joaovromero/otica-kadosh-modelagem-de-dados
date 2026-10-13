# Levantamento de requisitos — Ótica Kadosh (Entrega 2)

## Procedência e limites
Este documento organiza exclusivamente os relatos e observações documentados pelo grupo na [Entrega 1 original](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados). **Não é uma nova entrevista, nem transcrição de falas**. Dados de pessoas atendidas ou prescrições reais não foram reproduzidos.

## Caracterização e acesso
- Organização real: Ótica Kadosh; Av. Diogo da Costa Tavares, 125, Jardim Romano, São Paulo — SP, CEP 08191-000.
- Contato informado pelo grupo na E1: (11) 99349-4371.
- Responsável entrevistado: **Marcos Vinícius Silva Menezes**, gerente.
- Visita/entrevista: **05/09/2026**, presencial na loja, segundo o README original.
- Equipe relatada: **3 funcionários**, optometrista, gerente e consultor óptico. Volume informado: **aproximadamente 100 atendimentos e 80 vendas por semana**.
- Fotografia da visita: [registro fotográfico inserido no repositório](otica_kadosh_visita.jpg), originalmente publicado no projeto da E1. **Conferir com o grupo se ela mostra a entrevista, pois só foi confirmada como foto tirada dentro da loja.**
- **Não foi registrado no README original quais alunos participaram presencialmente da entrevista.** Confirmar com a equipe; não completar sem evidência.

## Observação direta documentada na E1 (documentos/imagens)
O grupo registrou fotografia da loja, do formulário de pedido, do comprovante destinado ao cliente e de laudo realizado na ótica. Os documentos mostram campos para cliente, consultor, data de compra, armação, lentes, quantidade, valor por armação e por par de lentes, entrada/sinal, saldo, data de retirada e medidas para olho direito/esquerdo e longe/perto. O formulário registra, entre outros, DNP e altura. **Imagens com dados pessoais/de saúde reais não foram republicadas.**

## Respostas/relatos registrados na E1
- A receita trazida pelo cliente é conferida quanto à data, seguindo prazo operacional informado de até um ano. Quando não apresentada ou não adequada, foi relatada realização de teste/laudo.
- Cada pedido usa uma receita própria; não se reaproveita a mesma receita em outro pedido.
- Pagamentos incluem Pix, dinheiro, débito e crédito, sinal/parcelamento; acompanhamento de parcelas foi descrito em planilha separada.
- A ótica utiliza produtos do estoque e, quando necessário, o gerente solicita itens a fornecedores, associando cada compra a um pedido específico.
- Estoque possui entradas/saídas registradas em planilha; após separação/recebimento há montagem e retirada.
- Garantia relatada de um ano contada da montagem/finalização; **não se trata de afirmação de prazo legal geral**.
- Trocas/devoluções registram dano e eventual cobrança, com possibilidade de peças reaproveitadas ou descartadas.

## Problemas de informações mapeados para o projeto
P1: fluxo atendimento → pedido disperso. P2: pagamentos e parcelas separados dos pedidos. P3: conciliação de compras e estoque. P4: montagem, retirada e garantia sem visão única. P5: trocas e destino de peças sem histórico integrado.

## Pendências de validação presencial
1. Obter a correção individual do professor referente à E1 e registrar resposta para cada apontamento.
2. Confirmar quais integrantes estavam na visita e se a imagem anexada comprova entrevista com o responsável.
3. Validar significado específico das medidas (DE/DC, esférico/cilíndrico, DNP, altura) com a ótica — o modelo proposto usa campos distintos e não equipara automaticamente rótulos diferentes.
4. Confirmar exatamente como se registra prescrição para longe/perto, pagamentos e cobrança por danos, bem como autorizações LGPD e perfis de acesso.
5. Conferir se o prazo de receita externa e da garantia foram relatados corretamente e se continuam vigentes; não inserir regra legal suposta.
6. Apresentar diagrama de classes/entidades e massa de exemplo ao responsável, registrando sugestões sem alterar retroativamente o relato original.

## Interpretação técnica separada
As 17 entidades, o armazenamento com PK/FK, os códigos de status, os registros sintéticos e as consultas do SQL são **decisões de modelagem** da Entrega 2, e não alegação de que a empresa já opera com esses campos ou estrutura. As regras identificadas pelo grupo como confirmadas permanecem indicadas no relatório principal.
# Entrega 2 — Modelo Lógico, Implementação SQL e Apresentação Final
### Ótica Kadosh | Projeto acadêmico de Modelagem de Banco de Dados

> **Status:** versão técnica revisada, baseada no [levantamento original da Entrega 1](entrega_1/README.md). Não declarar como homologada: ainda faltam correções individualizadas do professor, confirmação presencial das regras propostas e execução do script em MySQL 8. **A avaliação utiliza o README da branch `main`.**

## Integrantes

| Nome completo | RGM | GitHub |
|---|---|---|
| Victor Augusto Silva Marcilio | 47190175 | A confirmar |
| João Felipe De Sousa Pires | 48165379 | [jfpiresoficial](https://github.com/jfpiresoficial) |
| Cauã Batista Freire | 48355127 | A confirmar |
| João Victor Gobi Romero | 48114642 | [joaovromero](https://github.com/joaovromero) |
| Guilherme Araujo De Oliveira | 47116862 | A confirmar |

## Índice de artefatos

| Artefato | Link | Situação |
|---|---|---|
| Entrega 1 original | [README da E1](entrega_1/README.md) | Fonte de pesquisa de campo |
| Levantamento atualizado | [levantamento/levantamento.md](levantamento/levantamento.md) | Relato organizado, sem inventar dados |
| DER conceitual revisado | [DER e cardinalidades](diagramas/der_conceitual_revisado.md) | Representação textual, falta imagem em notação brModelo |
| Modelo lógico relacional | [Modelo Mermaid](diagramas/modelo_logico_revisado.md) | Visualização no GitHub, falta artefato final brModelo |
| Script SQL + massa sintética | [docs/script.sql](docs/script.sql) | MySQL 8; teste direto pendente |
| Dicionário de dados | [HTML único](docs/dicionario_dados.html) | 17 tabelas, tipos e restrições |
| Transparência de IA | [uso_de_ia.md](docs/uso_de_ia.md) | Etapas, resultados e limitações |
| Verificações antes da submissão | [validacoes_pendentes.md](docs/validacoes_pendentes.md) | Checklist obrigatório |

## 1. Relatório Técnico Final

### 1.1 Revisão do Modelo Conceitual

**Caracterização.** A Ótica Kadosh é um estabelecimento comercial de produtos ópticos, situado na **Av. Diogo da Costa Tavares, 125, Jardim Romano, São Paulo – SP, CEP 08191-000**, contato **(11) 99349-4371**, conforme documentação fornecida pelo grupo na Entrega 1. A entrevista foi realizada presencialmente em **05/09/2026** com o gerente **Marcos Vinícius Silva Menezes**. O grupo informou **3 funcionários, aproximadamente 100 atendimentos e 80 vendas por semana**, com atuação de optometrista, gerente e consultor óptico. Esses números são **relatados**, não extraídos do banco operacional. A foto da loja, fornecida pelo grupo, está [neste repositório](entrega_1/Otica%20kadoshi.jpeg). O grupo deve confirmar os participantes efetivos da entrevista e se a foto representa a entrevista, pois o README original apenas a identifica como foto realizada no interior da ótica.

**Problemas de gestão de informação:**

| Código | Problema relatado e consequência | Processo/modelo responsável | Consulta SQL |
|---|---|---|---|
| P1 | Dados de atendimento e pedido separados em papéis/planilhas, sem visão integrada | CLIENTE, ATENDIMENTO, RECEITA, PEDIDO | G01, G10 |
| P2 | Pagamentos parciais e parcelas monitorados em planilha separada | PEDIDO, ITEM_PEDIDO, PAGAMENTO | G02, G03, G09 |
| P3 | Entradas e saídas de estoque dependem de conciliação manual com fornecedores e pedidos | FORNECEDOR, COMPRA, ITEM_COMPRA, PRODUTO, MOVIMENTACAO_ESTOQUE | G04, G05 |
| P4 | Montagem, retirada e garantia devem ser acompanhadas pelo pedido | PEDIDO, MONTAGEM | G06, G07 |
| P5 | Histórico de trocas e destino de peças não está integrado ao pedido | TROCA, ITEM_TROCA, PRODUTO, PEDIDO | G08 |

**Escopo completo representado:** cliente, funcionários, atendimento, receita, medidas ópticas por olho e distância, produto e categoria, pedido e itens, pagamentos e parcelas, fornecedores e compras, movimentações de estoque, montagem/retirada, garantia calculada e trocas/devoluções. O modelo usa 17 tabelas. O processo fiscal e eventuais convênios **não foram confirmados** no levantamento da E1; não se presume que a ótica os opere da forma de qualquer exemplo genérico.

**Entrevista e observações.** Conforme [levantamento registrado](levantamento/levantamento.md), o grupo realizou visita à unidade e registrou imagens da loja, formulário de pedido, comprovante e laudo óptico; por privacidade, documentos com dados pessoais reais não são reproduzidos. **Observações documentais:** campos de dados do cliente e consultor, datas, armação, lentes, quantidades, preço por armação e par de lentes, total, sinal, saldo e data de retirada; medidas para olho direito/esquerdo, longe/perto, DNP e altura. **Respostas relatadas:** receita externa conferida com prazo operacional de até um ano; uma receita por pedido; pagamentos Pix, dinheiro, débito e crédito, inclusive parcelas; compras vinculadas ao pedido quando estoque insuficiente; garantia de um ano após montagem; troca com peça reaproveitada ou descartada. Não há confirmação dos nomes dos integrantes presentes nem da redação literal de perguntas; esses dados não foram inventados.

**Fluxos de negócio:**
1. Cliente informa nome e contatos; funcionário registra atendimento, data e procedimento; pode haver receita externa ou laudo da própria ótica.
2. Receita vinculada ao atendimento tem origem, data e medidas por olho (OD/OE) e uso (LONGE/PERTO). DNP e altura são campos separados; correspondência DE/DC do laudo deve ser validada.
3. Pedido vincula atendimento e receita exclusivos; itens de armação/lentes preservam quantidades e preços praticados. Estados técnicos propostos: ABERTO, CONCLUIDO e CANCELADO.
4. Pagamento registra parcela, vencimento, forma, valor, quitação ou estorno. Compra quando necessária referencia pedido, fornecedor, funcionário e itens recebidos.
5. Movimento registra produto, data, tipo, quantidade e origem; montagem mantém início, previsão, conclusão e retirada, com data final da garantia **derivada** por um ano; troca detalha motivo, eventual cobrança e destino da peça.

**Requisitos funcionais (refinamento da E1):**

| Código | Exigência do sistema e campos relacionados |
|---|---|
| RF01 | Cadastrar e consultar cliente com identificador, nome, telefone, email, bairro, CEP e estado ativo. |
| RF02 | Registrar atendimento com data, meio, procedimento, cliente e funcionário responsável. |
| RF03 | Registrar receita com origem/data; medidas por receita, olho e distância, incluindo esférico, cilíndrico, eixo, DNP e altura. |
| RF04 | Conferir prazo operacional informado para receita externa na data do pedido (A03). |
| RF05 | Registrar pedido com atendimento e receita únicos, data, status, itens (produto, quantidade, preço), desconto e observações. |
| RF06 | Registrar recebimentos e parcelas com valor, vencimento, data, forma e estado; calcular saldo pendente (G03). |
| RF07 | Registrar compra de fornecedor associada ao pedido, itens, custos, solicitação, status e chegada. |
| RF08 | Controlar entradas, saídas e ajustes por produto com data, quantidade e origem do movimento (G04). |
| RF09 | Acompanhar montagem, previsão, conclusão, retirada e prazo de garantia decorrente da conclusão (G06, G07). |
| RF10 | Registrar troca por pedido, motivo, data, eventual cobrança e destino das peças (G08). |

**Não funcionais:** RNF01 — restringir acesso a informações pessoais e ópticas sensíveis; RNF02 — gerar cópias de segurança e testes de restauração; RNF03 — assegurar transações atômicas para recebimento e baixa de estoque; RNF04 — consultas de histórico e indicadores acessíveis a usuários não técnicos; RNF05 — trilha de auditoria de alterações sensíveis na aplicação. A implementação plena dos RNFs de segurança e auditoria exige componentes além do esquema SQL acadêmico.

**Regras de negócio (RN01–RN11):**

| Código | Regra e evidência/modelagem |
|---|---|
| RN01 | Não há pedido sem atendimento (relato E1; FK e auditoria A01). |
| RN02 | Cada pedido utiliza receita própria, vinculada ao mesmo atendimento (relato E1; FK UNIQUE e A02). |
| RN03 | Conferir se receita externa tem até um ano na data do pedido (procedimento da ótica relatado, não legislação geral; A03). |
| RN04 | Pedido inclui armação e lentes com preço praticado; conferir por itens/categorias (relato E1, A04). |
| RN05 | Pedido pode ter sinal e parcelas, com conciliação entre total, desconto e pagamentos (relato E1, A05). |
| RN06 | Compra pode ser dispensada quando há estoque; cada compra atende um pedido e um fornecedor (relato E1, A06). |
| RN07 | Garantia de um ano começa na conclusão da montagem; retirada efetiva registrada separadamente (relato E1, G07/A07). |
| RN08 | Peças de trocas podem ser reaproveitadas ou descartadas; SUBSTITUIDO é status técnico adicional proposto (relato E1, A08). |
| RN09 | Saldo de estoque não pode ser negativo (controle técnico proposto, A09; requer validação transacional). |
| RN10 | Pedido cancelado não deve manter recebimentos quitados não estornados (controle técnico proposto, A10). |
| RN11 | Entrada de compra só deve ocorrer após status RECEBIDA (controle técnico proposto, A11). |

**DER conceitual e revisão E1:** [DER original do grupo](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados/blob/main/DER_conceitual_BRMW_HD.jpg) e [estrutura conceitual revisada de 17 entidades](diagramas/der_conceitual_revisado.md). Ferramenta da representação atual: **Markdown estruturado**; ainda é necessário exportar um DER gráfico na **notação brModelo** (entidade-retângulo, relacionamento-losango, cardinalidade (mín,máx), chave identificadora sublinhada, sem FKs). Os **apontamentos individuais da correção do professor não foram disponibilizados**; a tabela abaixo mostra diferenças técnicas, não substitui resposta à correção:

| Revisão técnica proposta | Alteração | Justificativa |
|---|---|---|
| Protótipo genérico de 12 tabelas não cobria atendimento/receita | Inclusão de ATENDIMENTO, RECEITA, MEDIDA_RECEITA | Apoiar processo registrado na visita |
| Compra desvinculada do pedido | COMPRA.id_pedido obrigatório | Seguir regra de compra vinculada a pedido |
| Venda genérica e ordem de montagem | PEDIDO e MONTAGEM | Linguagem e processo do formulário real |
| Falta de tratamento da troca | TROCA e ITEM_TROCA | Controlar peça e destino |
| Data de garantia armazenada isoladamente | Data final derivada de MONTAGEM.data_conclusao | Evitar inconsistência |

### 1.2 Conversão do Modelo Conceitual para o Modelo Lógico

As 17 entidades originaram 17 tabelas. Cada atributo simples virou coluna; cada vínculo 1:N é implementado por FK no lado N (CLIENTE → ATENDIMENTO, PEDIDO → PAGAMENTO, FORNECEDOR → COMPRA), com participação obrigatória definida por NOT NULL. Vínculos 1:0..1 usam FK UNIQUE (ATENDIMENTO → RECEITA, ATENDIMENTO → PEDIDO, RECEITA → PEDIDO, PEDIDO → MONTAGEM). Os relacionamentos N:N PEDIDO–PRODUTO, COMPRA–PRODUTO e TROCA–PRODUTO são decompostos em ITEM_PEDIDO, ITEM_COMPRA e ITEM_TROCA com PK composta. Medidas têm PK (id_receita,olho,distancia) e guardam atributos que dependem do trio. Não foi necessária generalização/especialização.

### 1.3 Chaves primárias e estrangeiras

| Tabela | PK | FKs |
|---|---|---|
| cliente | id_cliente | — |
| funcionario | id_funcionario | — |
| atendimento | id_atendimento | id_cliente, id_funcionario |
| receita | id_receita | id_atendimento UNIQUE |
| medida_receita | id_receita, olho, distancia | id_receita |
| fornecedor | id_fornecedor | — |
| categoria | id_categoria | — |
| produto | id_produto | id_categoria |
| pedido | id_pedido | id_atendimento UNIQUE, id_receita UNIQUE |
| item_pedido | id_pedido, id_produto | id_pedido, id_produto |
| pagamento | id_pagamento | id_pedido; UNIQUE(id_pedido,numero_parcela) |
| compra | id_compra | id_pedido, id_fornecedor, id_funcionario |
| item_compra | id_compra, id_produto | id_compra, id_produto |
| montagem | id_montagem | id_pedido UNIQUE, id_funcionario |
| troca | id_troca | id_pedido, id_funcionario |
| item_troca | id_troca, id_produto | id_troca, id_produto |
| movimentacao_estoque | id_movimento | id_produto, id_compra?, id_pedido?, id_troca? |

### 1.4 Normalização — 1FN, 2FN e 3FN

**1FN:** cada célula representa um valor indivisível; itens de pedidos, pagamentos, medidas por olho/distância e trocas foram desmembrados em tabelas próprias para eliminar listas e atributos repetidos. **2FN:** em ITEM_PEDIDO a quantidade/preço dependem de (id_pedido,id_produto), em ITEM_COMPRA de (id_compra,id_produto), em ITEM_TROCA de (id_troca,id_produto) e em MEDIDA_RECEITA de (id_receita,olho,distancia); o nome do produto e dados do pedido não são duplicados nessas tabelas. **3FN:** fornecedores, funcionários, clientes, produtos e categorias são tabelas independentes; dados descritivos não ficam duplicados em pedidos. Os preços praticados são fatos históricos da transação e não devem ser substituídos pelo preço atual. Garantia final é derivada de conclusão de montagem e estoque é calculado pelo balanço dos movimentos — eliminam redundância derivável.

### 1.5 Justificativas técnicas

PKs numéricas identificam registros estáveis, enquanto chaves compostas garantem unicidade do fato por par/trio; FKs RESTRICT preservam histórico. UNIQUE assegura exclusividade de receita e atendimento por pedido (RN02); CHECK valida domínio de procedimento, status, preços e quantidades, e datas no contexto da linha (RN04, RN05, RN07, RN08). Restrição de movimentação identifica uma origem válida segundo o tipo. A igualdade entre atendimento da receita e pedido, idade de receita, saldo não negativo, itens necessários e conciliação entre tabelas **não são garantidas por CHECK**: são avaliadas nas consultas A01–A11 e deverão ser aplicadas transacionalmente no sistema. Uso de InnoDB e índices por data/produto favorece relatórios sem duplicar informações.

### 1.6 Arquitetura analítica para BI e IA

Indicadores agregados por pedido, data, cliente, categoria, fornecedor e movimentação podem alimentar painéis com visualização de vendas, estoque, atrasos e pagamentos. Predição de demanda só seria apropriada com histórico real suficientemente amplo, anonimização e aprovação da organização; a massa sintética **não valida modelos preditivos**.

| Problema / KPI | Fórmula | Período / meta | Tabelas | Consulta |
|---|---|---|---|---|
| P1 / Conversão atendimento-pedido | 100 × pedidos / atendimentos | semanal, meta a validar | atendimento, pedido | G01 |
| P1 / Cancelamentos | 100 × cancelados / total pedidos | mensal, meta a validar | pedido | G10 |
| P2 / Faturamento estimado de pedidos concluídos | Σ itens (quantidade × preço) − descontos | mensal, meta a validar | pedido, item_pedido | G02 |
| P2 / Ticket médio | faturamento estimado / pedidos concluídos | mensal, meta a validar | pedido, item_pedido | G02 |
| P2 / Saldo pendente | total devido − pagamentos quitados | por pedido, meta zero na conclusão | pedido, item_pedido, pagamento | G03 |
| P2 / Recebimento por forma | Σ parcelas quitadas por forma | mensal, meta a validar | pagamento | G09 |
| P3 / SKUs abaixo do mínimo | contagem de saldos calculados menores que mínimo | diário, meta a validar | produto, movimentacao_estoque | G04 |
| P3 / Custo de compras recebidas | Σ quantidade × custo unitário | mensal, meta a validar | fornecedor, compra, item_compra | G05 |
| P4 / Montagens atrasadas | contagem de montagens em aberto após previsão | diário, meta a validar | montagem | G06 |
| P4 / Garantias vigentes | contagem com conclusão ≤ referência ≤ conclusão + 1 ano | diário, meta a validar | montagem | G07 |
| P5 / Destino de peças trocadas | contagem por destino | mensal, meta a validar | troca, item_troca | G08 |

Consultas calculam os números, porém o termo *faturamento estimado* é indicador de valor de pedidos, não de faturamento fiscal/recebimento efetivo.

## 2. Modelo lógico relacional

[Modelo lógico — 17 tabelas](diagramas/modelo_logico_revisado.md). Ferramenta atual: Mermaid/Markdown no GitHub. Exigência adicional da rubrica: versão gráfica na notação **brModelo**, com nome, tipo, PK, FK e cardinalidade (mín,máx) por extremidade.

## 3. Script SQL completo

**[Abrir script SQL MySQL 8](docs/script.sql)**. Arquivo único com CREATE DATABASE, 17 CREATE TABLE e constraints, INSERTs de massa sintética reproduzível, JOINs, UPDATE/DELETE em transação com ROLLBACK, **G01–G10** e **A01–A11**. MySQL 8.0.16+ necessário para suporte adequado a CHECK. Teste de ponta a ponta **ainda não comprovado** em servidor MySQL nesta sessão. Com a conexão configurada no MySQL Workbench, executar o script integral em banco vazio e conferir resultados, inclusive auditorias.

## 4. Massa de dados

Os INSERTs **fictícios** representam quatro semanas de operação hipotética, baseadas nas **aproximações de 100 atendimentos e 80 vendas semanais relatadas** na E1 — sem usar cliente ou prescrição reais. O modelo possui 280 clientes simulados, 3 funcionários simulados, 400 atendimentos, 320 receitas, 768 linhas de medidas, 320 pedidos (280 concluídos, 25 abertos, 15 cancelados), 666 itens de pedido, 400 parcelas, 36 produtos, 8 fornecedores, 35 compras, 35 itens de compra, 305 registros de montagem, 12 trocas, 12 itens de troca e 655 movimentos, além de 3 categorias. As quantidades por mês/dia e estados foram criados para demonstrar consultas; **não são números reais da ótica**. Há clientes sem pedido, parcelas pendentes, diferentes meios de pagamento, itens abaixo do mínimo, pedidos cancelados e montagem em atraso.

## 5. Organização do repositório

O professor corrige este **README da raiz de `main`**. O [dicionário atualizado](docs/dicionario_dados.html), [script](docs/script.sql), [levantamento](levantamento/levantamento.md), [DER](diagramas/der_conceitual_revisado.md), [modelo lógico](diagramas/modelo_logico_revisado.md), [evidência fotográfica](entrega_1/Otica%20kadoshi.jpeg) e demais evidências estão ligados aqui. **A colaboração real precisa ser demonstrada pelos commits de cada integrante**, sem atribuir falsamente contribuições a terceiros.

## 6. Uso de Inteligência Artificial

Usou-se **ChatGPT (OpenAI)** para revisar os requisitos da rubrica, comparar o levantamento original da E1 com o modelo anterior, sugerir normalização, estruturar tabelas SQL/queries, gerar massa fictícia de testes, produzir modelo documental e redigir partes do relatório. **[Registro detalhado com motivação, prompts aproximados, respostas, ajustes/rejeições, verificação e limites](docs/uso_de_ia.md)**. O protótipo anterior de 12 tabelas foi rejeitado como insuficiente; não foram criadas respostas de entrevista nem correções atribuídas ao professor. Os artefatos são sugestões técnicas que exigem validação do grupo, testes e conferência do docente.

## 7. Apresentação corporativa final (8 minutos)

**Roteiro cronometrado sugerido:** 0:00–0:55 contexto e P1–P5; 0:55–1:50 solução integrada; 1:50–3:00 modelo lógico 17 tabelas; 3:00–4:20 demonstração CREATE/INSERT/JOIN no MySQL; 4:20–5:45 demonstração G03, G04 e A03/A05; 5:45–6:50 KPIs e BI/IA; 6:50–8:00 benefícios e conclusão. Todos os integrantes devem participar da defesa, e a demonstração precisa ser executada de fato em MySQL. Preparar slides finalizados, ensaiar e confirmar disponibilidade de laboratório.

### Antes da entrega definitiva
Ver [pendências de verificação](docs/validacoes_pendentes.md). Faltam **correções oficiais da E1**, desenhos brModelo finais, teste SQL MySQL e confirmação de dados/participação da entrevista. A versão atual é **material de trabalho para revisão acadêmica**, não entrega homologada.

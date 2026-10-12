# Entrega 2 — Modelo Lógico, Implementação SQL e Apresentação Final
### Ótica Kadosh | Modelagem de sistema de gestão de informações
> **Levantamento real localizado:** A [Entrega 1 do grupo](entrega_1/README.md) documenta visita presencial em 05/09/2026 à Ótica Kadosh (Av. Diogo da Costa Tavares, 125, Jardim Romano, São Paulo/SP), entrevista do gerente Marcos Vinícius Silva Menezes, três funcionários e aproximadamente 100 atendimentos e 80 vendas semanais *segundo relato da equipe*.
>
> **Diferença entre os modelos:** O DER original tem 13 entidades e inclui processos ópticos específicos de **receita/laudo, atendimento, pedido, troca e garantia**. O protótipo de Entrega 2 abaixo modela apenas 12 tabelas e **não substitui a revisão do DER original nem representa integralmente esses processos**. SQL, dicionário e diagramas são propostas técnicas sujeitas a revisão, e não validação da loja ou do professor. Veja [pendências de adequação](docs/validacoes_pendentes.md).
>
> **Privacidade:** As informações sobre clientes e prescrições ópticas devem permanecer anonimizadas. A massa de teste é totalmente fictícia.


> **Estado do projeto:** protótipo acadêmico de Entrega 2 em revisão. A pesquisa de campo original foi recuperada e preservada em `entrega_1/README.md`; ainda faltam adequação do modelo à E1, feedback do professor e testes diretos no MySQL.

**Esta pasta destina-se à branch `main` do GitHub.** A correção considera o `README.md` da raiz da `main`; não basta enviar PDF ou apontar para outra branch. O arquivo presente é uma versão técnica preparada para incorporação ao projeto, não evidencia commits ou entrega realizada pelo grupo.

## 1. Relatório Técnico Final

### Integrantes

| Nome completo do aluno | RGM | Usuário do GitHub |
|---|---|---|
| Victor Augusto Silva Marcilio | 47190175 | A INFORMAR |
| João Felipe De Sousa Pires | 48165379 | jfpiresoficial |
| Cauã Batista Freire | 48355127 | A INFORMAR |
| João Victor Gobi Romero | 48114642 | joaovromero |
| Guilherme Araujo De Oliveira | 47116862 | A INFORMAR |

### 1.1 Revisão do Modelo Conceitual

**Caracterização:** Ótica Kadosh, varejo óptico na Av. Diogo da Costa Tavares, 125, Jardim Romano, São Paulo — SP, CEP 08191-000. Segundo o levantamento do grupo, três funcionários, cerca de 100 atendimentos e 80 vendas semanais. O processo real relatado inclui atendimento, receita/laudo, pedido, pagamento, compras, estoque, montagem, retirada, garantia e trocas. O modelo simplificado atual cobre apenas parte desse escopo.

**Problemas de gestão de informações propostos para confirmação (cada qual com consulta SQL):**

- **P1 —** Dificuldade de acompanhar valores vendidos, descontos e ticket médio quando há registros dispersos. Consulta: **G01, G02**.
- **P2 —** Dificuldade de conhecer o saldo de estoque, giro e necessidade de reposição. Consulta: **G03, G04**.
- **P3 —** Dificuldade de acompanhar fornecedores, compras e recebimentos. Consulta: **G05**.
- **P4 —** Dificuldade de conciliar pagamentos e acompanhar cancelamentos de vendas. Consulta: **G06, G08**.
- **P5 —** Dificuldade de acompanhar prazos de pedidos que dependem de montagem. Consulta: **G07**.

**Escopo:** clientes, funcionários, fornecedores, categorias, catálogo, compras, itens comprados, vendas, itens vendidos, pagamentos, movimentações de estoque e ordens de montagem. *Processos prováveis ainda não verificados*, como trocas, devoluções, contas a pagar, vendas sem identificação e prescrições, deverão ser investigados em campo e acrescentados quando de fato necessários. Se houver atividades clínicas, também será necessário avaliar a proteção de dados sensíveis. A justificativa da escolha é a possibilidade de estruturar informação operacional e apoiar a decisão; isso não prova que os problemas ocorram na empresa.

**Evidências:** consultar [levantamento presencial na E1](entrega_1/README.md), com dados da visita, entrevistado e [fotografia da loja no repositório original](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados/blob/main/Otica%20kadoshi.jpeg). Não publicar laudos ou formulários com dados pessoais reais.

**Entrevista:** gerente Marcos Vinícius Silva Menezes, em visita presencial à unidade em 05/09/2026, conforme registro da equipe na E1. Não se atribuem respostas adicionais ao entrevistado.

**Processos propostos:** cadastro, gestão de catálogo, compras e recebimentos, venda de itens, pagamentos, controle de estoque, possível montagem e relatórios. Fluxos em [fluxos da proposta](diagramas/fluxos.md). A aplicação proposta cobre os processos listados, mas a cobertura de **todos os dados reais da ótica** depende de validação presencial.

**Requisitos funcionais:**

- **RF01 —** Cadastrar cliente com nome, telefone, e-mail opcional e CPF opcional e único quando preenchido; manter indicador ativo.
- **RF02 —** Cadastrar colaboradores com nome, cargo e estado ativo, vinculando responsáveis a compras, vendas e montagens.
- **RF03 —** Cadastrar fornecedores com nome, CNPJ opcional e telefone; identificar o fornecedor de cada compra.
- **RF04 —** Cadastrar categorias e produtos com SKU, descrição, preço, estoque mínimo e indicador ativo.
- **RF05 —** Registrar compras com data, fornecedor, colaborador e status, contendo produtos, quantidades e custos unitários.
- **RF06 —** Registrar recebimentos de compras, gerando entradas correspondentes no histórico de movimentações.
- **RF07 —** Registrar vendas com cliente, colaborador, data, status, desconto e itens com preço praticado e quantidade.
- **RF08 —** Registrar pagamentos parciais ou totais por venda, com data, forma, valor e estado de confirmação.
- **RF09 —** Gerar saídas de estoque para vendas concluídas e permitir ajustes documentados com justificativa.
- **RF10 —** Consultar estoque calculado a partir de movimentos, sinalizando produtos abaixo do mínimo.
- **RF11 —** Abrir e acompanhar ordem de montagem vinculada à venda, com previsão, responsável, status e conclusão.
- **RF12 —** Produzir relatórios gerenciais e consultas de auditoria de vendas, estoque, compras, pagamentos e montagens.

**Requisitos não funcionais:**

- **RNF01 —** Controle de acesso por função: operações comerciais, estoque, gestão e manutenção com privilégios mínimos.
- **RNF02 —** Proteção de dados pessoais: acesso registrado, criptografia em trânsito, backups protegidos e política de retenção.
- **RNF03 —** Integridade transacional ao registrar venda, pagamento e saída, ou compra, recebimento e entrada.
- **RNF04 —** Interface legível e responsiva, uso simples por colaboradores e validação de erros nos formulários.
- **RNF05 —** Consultas por SKU, venda e data indexadas; meta de tempo deve ser medida e acordada com a organização.
- **RNF06 —** Backup e recuperação testados; disponibilidade e RPO/RTO a definir em campo.

**Regras de negócio propostas:**

- **RN01 —** Todo cliente deve possuir identificador, nome e telefone; CPF é opcional e, quando fornecido, não pode repetir.
- **RN02 —** Funcionário deve ter nome, cargo e situação; operações registram o responsável.
- **RN03 —** Fornecedor deve ter nome; CNPJ quando informado não se repete.
- **RN04 —** Produto deve ter SKU único, descrição, categoria e indicador de atividade.
- **RN05 —** Preços e descontos não podem ser negativos; preços praticados em itens históricos não mudam com atualização do catálogo.
- **RN06 —** Cada compra pertence a um fornecedor e a um colaborador; estados válidos: ABERTA, RECEBIDA, CANCELADA.
- **RN07 —** Cada item de compra deve referenciar exatamente uma compra e um produto; quantidade positiva, custo não negativo e par sem repetição.
- **RN08 —** Cada venda referencia um cliente e um colaborador; estados ABERTA, CONCLUIDA, CANCELADA; desconto não negativo.
- **RN09 —** Cada item de venda tem produto, quantidade positiva e preço do momento; venda concluída precisa de ao menos um item.
- **RN10 —** Movimento tem produto, quantidade positiva e tipo; entrada de compra refere compra, saída refere venda; ajustes sem vínculo; o saldo não deve ficar negativo.
- **RN11 —** Pagamento referencia venda, forma válida e valor positivo; venda cancelada não deve possuir pagamento confirmado; conciliação é verificada.
- **RN12 —** Uma venda origina no máximo uma ordem de montagem; previsão não precede abertura; conclusão requer data.
- **RN13 —** Excluir cadastros com histórico de compras/vendas deve ser restringido para preservar rastreabilidade.
- **RN14 —** Informações de prescrição e saúde não integram este protótipo sem confirmação explícita de necessidade e medidas específicas de proteção.

**Regras típicas não incorporadas:** prescrição e exames, emissão fiscal, devolução de mercadoria, faturamento a convênios e logística com laboratório externo não foram modelados porque não se dispõe de confirmação de como a ótica realiza tais processos; precisarão ser acrescentados se forem praticados. Os vínculos com saúde são especialmente sujeitos a controles legais.

**DER revisado (proposta Graphviz usando notação gráfica equivalente à do brModelo):**

[DER conceitual original em notação brModelo](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados/blob/main/DER_conceitual_BRMW_HD.jpg) — [visualização simplificada em Mermaid da proposta E2](diagramas/modelo_proposto.md).

**Software:** Graphviz/DOT; atributos no retângulo com identificadores sublinhados, relações em losangos, cardinalidades min/max por extremidade e sem FKs no modelo conceitual. A versão final nativa do brModelo não foi produzida.

**Caso A — correção E1:** a correção individual do professor não foi fornecida, apesar de o README da Entrega 1 estar disponível; portanto esta tabela separa propostas técnicas de apontamentos que ainda precisam ser efetivamente transcritos:

| Apontamento da correção E1 | O que mudou | Por quê |
|---|---|---|
| **[NÃO DISPONÍVEL]** — anexar feedback individual do professor | Ainda não foi possível confrontar o DER pré-existente com a versão revisada | A entrega 2 exige citar cada apontamento, e não é correto inventá-lo |
| **Revisão técnica proposta (não atribuída ao professor):** relação N:N entre venda e produto | Adotada ITEM_VENDA com quantidade e preço histórico | Evitar relação N:N desestruturada |
| **Revisão técnica proposta (não atribuída ao professor):** relação N:N entre compra e produto | Adotada ITEM_COMPRA com quantidade e custo | Preservar granularidade |
| **Revisão técnica proposta (não atribuída ao professor):** múltiplos pagamentos | Separada entidade PAGAMENTO | Permitir uma ou várias formas por venda |

### 1.2 Conversão do Modelo Conceitual para o Modelo Lógico

As 12 entidades foram convertidas em 12 tabelas; atributos simples tornaram-se colunas tipadas. No 1:N, a PK do lado 1 migrou como FK para o lado N (ex.: `venda.id_cliente`). No N:N, as entidades associativas `item_venda` e `item_compra` recebem duas FKs que formam uma PK composta. A relação VENDA–ORDEM_MONTAGEM (0:1) foi materializada com FK **UNIQUE** em `ordem_montagem.id_venda`. As relações de origem entre movimentos de estoque e compra/venda têm FKs opcionais com `CHECK` dependente do tipo de movimento. Não existe generalização/especialização, portanto não há conversão desse recurso.

### 1.3 Definição de Chaves Primárias e Estrangeiras

| Tabela | PK | FKs |
|---|---|---|
| `cliente` | `id_cliente` | — |
| `funcionario` | `id_funcionario` | — |
| `fornecedor` | `id_fornecedor` | — |
| `categoria` | `id_categoria` | — |
| `produto` | `id_produto` | id_categoria → categoria.id_categoria |
| `compra` | `id_compra` | id_fornecedor → fornecedor.id_fornecedor; id_funcionario → funcionario.id_funcionario |
| `item_compra` | `id_compra`, `id_produto` | id_compra → compra.id_compra; id_produto → produto.id_produto |
| `venda` | `id_venda` | id_cliente → cliente.id_cliente; id_funcionario → funcionario.id_funcionario |
| `item_venda` | `id_venda`, `id_produto` | id_venda → venda.id_venda; id_produto → produto.id_produto |
| `pagamento` | `id_pagamento` | id_venda → venda.id_venda |
| `movimentacao_estoque` | `id_movimentacao` | id_produto → produto.id_produto; id_compra → compra.id_compra; id_venda → venda.id_venda |
| `ordem_montagem` | `id_ordem` | id_venda → UNIQUE venda.id_venda; id_funcionario → funcionario.id_funcionario |

### 1.4 Processo de Normalização (1FN, 2FN e 3FN)

**1FN — atomicidade:** listas de produtos em uma célula e listas de telefones de clientes foram evitadas; cada item de compra e de venda ocupa uma linha. O modelo atual usa apenas um telefone principal por cliente; se a organização exigir múltiplos contatos, será necessária entidade adicional. **2FN — dependência total:** nas tabelas de PK composta `(id_venda,id_produto)` e `(id_compra,id_produto)`, `quantidade` e `preco_unitario/custo_unitario` dependem do par completo; nomes e descrições do produto não se repetem nessas tabelas. As demais tabelas possuem PK simples, sem dependência parcial. **3FN — ausência de dependência transitiva indevida:** a descrição da categoria fica na tabela CATEGORIA, o nome do fornecedor em FORNECEDOR e os dados do cliente em CLIENTE, todos ligados por FKs. O preço no item é um fato da própria transação (histórico), não uma cópia indevida do preço atual de PRODUTO. Saldo de estoque não é armazenado em PRODUTO, pois deriva da soma de MOVIMENTACAO_ESTOQUE. Assim, evitam-se anomalias de atualização, inserção e exclusão.

### 1.5 Justificativas Técnicas das Decisões

PKs inteiras por sua estabilidade, exceto `item_venda` e `item_compra` com PKs compostas que proíbem item duplicado dentro do mesmo evento. FKs `NOT NULL` expressam participações obrigatórias (RN06–RN09), enquanto `id_compra` e `id_venda` opcionais no estoque representam a origem condicional. As restrições `UNIQUE` impedem duplicação de SKU (RN04), categoria (RN04), CPF/CNPJ quando preenchidos (RN01/RN03) e múltiplas ordens por venda (RN12). `CHECK` protege domínios de estados (RN06/RN08/RN11/RN12), quantidades (RN07/RN09/RN10), valores (RN05/RN11) e datas (RN12). O vínculo histórico usa `ON DELETE RESTRICT` (RN13). Regras entre linhas ou tabelas, como venda concluída com ao menos um item, estoque sem saldo negativo e igualdade entre itens e movimentações, exigem transação e consultas A01–A06; CHECK isolado não as garante. O modelo minimiza coleta sensível (RN14).

### 1.6 Proposta de Arquitetura Analítica para BI e IA

A camada transacional InnoDB registra compras, vendas e movimentos com chaves coerentes; visões de consulta ou extrações agregadas por período, categoria e produto podem alimentar BI sem alterar as tabelas operacionais. Aplicações possíveis: detecção de necessidade de reposição, distribuição do faturamento, atraso de ordens e previsão sazonal após validação de qualidade e volume dos dados. Não há garantia de eficácia preditiva com a massa sintética; dados reais tratados de maneira lícita e historicamente suficientes são necessários para IA.

**KPIs obrigatoriamente calculáveis e rastreabilidade dos problemas** (as metas dependem da organização):

| Problema/KPI | Fórmula | Periodicidade e meta | Tabelas | Consulta |
|---|---|---|---|---|
| P1 / Faturamento | Soma de (quantidade×preço do item) − desconto, por mês | mês; meta pendente | VENDA, ITEM_VENDA | `G01` |
| P1 / Ticket médio | Valor líquido de vendas concluídas ÷ nº vendas concluídas | mês; meta pendente | VENDA, ITEM_VENDA | `G02` |
| P2 / Abaixo do mínimo | Contagem de SKUs cujo saldo de movimentos é menor que mínimo | dia; meta pendente | PRODUTO, MOVIMENTACAO_ESTOQUE | `G03` |
| P2 / Giro | Soma de unidades vendidas por SKU | período; meta pendente | PRODUTO, ITEM_VENDA, VENDA | `G04` |
| P3 / Compras | Soma de custos×quantidades de compras recebidas | período; meta pendente | FORNECEDOR, COMPRA, ITEM_COMPRA | `G05` |
| P4 / Cancelamento | 100×nº vendas canceladas ÷ nº vendas | mês; meta pendente | VENDA | `G06` |
| P5 / Montagens atrasadas | Nº de ordens abertas com previsão antes da data corrente | dia; meta pendente | ORDEM_MONTAGEM | `G07` |
| P4 / Conciliação | Total dos itens − descontos − pagamentos confirmados | por venda; meta diferença 0 | VENDA, ITEM_VENDA, PAGAMENTO | `G08` |

## 2. Modelo Lógico Relacional

![Diagrama do modelo lógico](diagramas/modelo_proposto.md)

[Modelo lógico PNG](diagramas/modelo_proposto.md). **Software:** Graphviz/DOT (diagrama com tabelas, tipos, PK, FK e cardinalidades, estilizado conforme convenções do brModelo; sem arquivo `.brM`). Para implementar as restrições: [dicionário HTML](docs/dicionario_dados.html).

## 3. Script SQL Completo

[**docs/script.sql — MySQL 8.0.16+**](docs/script.sql). Inclui `CREATE DATABASE`, 12 `CREATE TABLE`, FKs, CHECKs, UNIQUE, massa fictícia, `SELECT` com JOIN, `UPDATE` e `DELETE` em transação revertida, consultas gerenciais G01–G08 e auditorias A01–A06. **Como usar:** MySQL Workbench → abrir `docs/script.sql` → executar a partir de servidor MySQL 8.0.16+ configurado. A sessão usou validação estrutural local, mas **não executou o script num servidor MySQL**; rodar integralmente em ambiente de laboratório antes da apresentação.

## 4. Massa de Dados

A massa está incorporada ao [script SQL](docs/script.sql), é **inteiramente fictícia** e serve para exercitar casos de vendas concluídas, abertas e canceladas, pagamentos com duas formas, compras recebidas e abertas, produtos abaixo do estoque mínimo, montagens atrasadas e conciliação de movimentos.

| Tabela | Linhas aproximadas sintéticas | Observação |
|---|---:|---|
| `cliente` | 60 | Massa de demonstração, não observação real. |
| `funcionario` | 5 | Massa de demonstração, não observação real. |
| `fornecedor` | 6 | Massa de demonstração, não observação real. |
| `categoria` | 4 | Massa de demonstração, não observação real. |
| `produto` | 25 | Massa de demonstração, não observação real. |
| `compra` | 12 | Massa de demonstração, não observação real. |
| `item_compra` | 36 | Massa de demonstração, não observação real. |
| `venda` | 75 | Massa de demonstração, não observação real. |
| `item_venda` | 150 | Massa de demonstração, não observação real. |
| `pagamento` | 77 | Massa de demonstração, não observação real. |
| `movimentacao_estoque` | 158 | Massa de demonstração, não observação real. |
| `ordem_montagem` | 23 | Massa de demonstração, não observação real. |

**Justificativa provisória do volume:** os números acima não foram derivados de vendas, clientes ou estoque reais, pois os dados de porte e entrevista ainda não estavam acessíveis. São suficientes apenas para teste acadêmico dos relacionamentos. **Antes da entrega, obter os números reais do porte e ajustar/justificar o volume da massa em função deles, sem substituir registros fictícios por dados pessoais.**

## 5. Repositório GitHub

Estrutura proposta: `README.md` na raiz da branch `main`; `entrega_1/README.md`; `diagramas/*.png`; `docs/dicionario_dados.html`; `docs/script.sql`; `levantamento/levantamento.md`, fotos JPG/PNG **a inserir pelo grupo**; `apresentacao/pitch_otica_kadosh.pptx`.

O histórico de commits de cada integrante e o perfil verificado são evidências próprias do GitHub e **não foram criados por esta ferramenta**. Não atribuir contribuição a pessoas que não participaram de fato.

## 6. Uso de Inteligência Artificial

## Registro de uso de Inteligência Artificial (aplicável às duas entregas)

| Item | Registro transparente |
|---|---|
| Ferramenta e etapa | ChatGPT (GPT-6), outubro de 2026; leitura dos esqueletos e materiais, estruturação dos relatórios, proposta de modelo, diagramas, dicionário, geração de dados sintéticos, SQL, slides. |
| Motivação | Apoiar organização dos artefatos e consistência das relações e restrições. |
| Prompt próximo do original | “Com base em todo o material disponível das aulas e dos projetos faça o que se pede no esqueleto de entrega 1 e 2. Drive das aulas [URL], referência de dicionário [URL], baseado no GitHub da Ótica Kadosh [URL].” |
| Resposta recebida | Estrutura de 12 entidades; especificação de requisitos, regras, diagramas e script MySQL; conjuntos de dados gerados com nomes fictícios. |
| Fontes consultadas | Esqueletos oficiais `00-c_Esqueleto_Entrega_1.md` e `00-d_Esqueleto_Entrega_2.md`, aulas de modelagem, conversão, normalização, DDL/DML, exemplo `02-03g_Exemplo_Dicionario_Dados.pdf` e artigo Datapsico. O GitHub de referência não foi efetivamente recuperado. |
| Material rejeitado ou corrigido | Não foram inventados nomes/RGMs de alunos, endereço, contato, entrevista, fotos, porte, volumes reais, correções do professor e procedimentos não comprovados. O conjunto sintético NÃO é evidência de porte real. |
| Justificativa da versão atual | Entregáveis técnicos utilizáveis para validação, preservando integridade e demonstrando queries e regras; a pesquisa de campo continua essencial. |
| Reflexão crítica | IA não observa processos presencialmente, não autentica entrevistas, não substitui revisão do professor e não atesta execução em MySQL sem ambiente de testes disponível. Um esquema plausível não é necessariamente o esquema real da organização. |

O grupo deve complementar o histórico com seus próprios prompts, revisões, exclusões e decisões de validação; não apresentar esta tabela como relato de trabalho humano que não ocorreu.

## 7. Apresentação Corporativa Final

[Pitch de aproximadamente 8 minutos — PPTX editável](apresentacao/pitch_otica_kadosh.pptx). Ordem: problema, solução, modelo lógico, SQL, consultas, BI/IA e benefícios. A demonstração real do script no MySQL e a defesa do modelo devem ser feitas pelo grupo. Os slides são um roteiro, não evidência de que a demonstração já aconteceu.

## Critérios Atitudinais (20%)

Dependem de avaliação 360º e de participação real, postura, responsabilidade e distribuição de commits. Não são preenchíveis por IA.

## Resumo dos Pesos

| Dimensão | Peso |
|---|---:|
| Conceitual | 30% |
| Procedimental | 50% |
| Atitudinal | 20% |

## Referências usadas

- [Drive das aulas e materiais oficiais](https://drive.google.com/drive/folders/1QVVdiG4LxFE7L3BSnZDFmHyakaoPX94A), com destaque para os esqueletos 00-c e 00-d, os materiais de DER, integridade, normalização, DDL e o exemplo 02-03g.
- [Datapsico — guia para criação de dicionários de dados](https://medium.com/datapsico/dicionario-de-dados-ac3ce726c34b).
- [Repositório informado para a Entrega 1 da Ótica Kadosh](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados) — **referência solicitada; conteúdo não verificado nesta execução**.
> **Cópia de referência acadêmica:** conteúdo proveniente do [repositório original da Entrega 1](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados), preservado com autoria do grupo. Os artefatos mencionados no README estão disponíveis no projeto original; laudos/pedidos com dados pessoais não foram replicados.




# Entrega 1 — Modelo Conceitual (DER)
### Modelagem de um sistema de gestão de informações para uma organização de pequeno porte

## Metadados

- **Nomes dos alunos e RGM**

| Integrante | RGM |
|---|---:|
| Victor Augusto Silva Marcilio | 47190175 |
| João Felipe De Sousa Pires | 48165379 |
| Cauã Batista Freire | 48355127 |
| João Victor Gobi Romero | 48114642 |
| Guilherme Araujo De Oliveira | 47116862 |

## 1. Caracterização da Organização
*(vale 7,5% — Dimensão Conceitual)*

- **Nome e natureza da organização:** **Ótica Kadosh**, estabelecimento comercial de produtos ópticos situado na Av. Diogo da Costa Tavares, 125, Jardim Romano, São Paulo — SP, CEP 08191-000. **Contato da loja, confirmado pelo grupo:** (11) 99349-4371.
- **Contexto e porte:** A ótica tem três funcionários: **Guilherme de Souza Silva — optometrista; Marcos Vinícius Silva Menezes — gerente; Kaique Batista dos Santos — consultor óptico**. O grupo informou aproximadamente **100 atendimentos e 80 vendas por semana**. A ótica atende clientes presencialmente, trabalha com armações e lentes, recebe pagamentos, mantém estoque e solicita produtos a fornecedores quando necessário.
- **Problemas e necessidades identificados:** Pedidos e outras informações são mantidos em papel e planilhas. Segundo o relato da entrevista, um banco de dados usado anteriormente apresentava falhas frequentes. A necessidade concreta é relacionar atendimento, prescrição, pedido, pagamentos, compras, estoque e trocas sem depender de registros dispersos.
- **Justificativa da escolha:** A organização real reúne processos conectados e observáveis — atendimento, laudo/receita, venda, pagamento, compra, montagem, retirada, garantia e trocas — adequados a um DER conceitual de pequeno porte.
- **Evidências da organização:** Endereço informado acima; gerente entrevistado: Marcos Vinícius Silva Menezes. A [fotografia feita no interior da ótica durante a visita](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados/blob/main/Otica%20kadoshi.jpeg) está neste repositório e pôde ser aberta na revisão dos arquivos. O grupo também apresentou fotografias do formulário do pedido, do comprovante ao cliente e de um laudo produzido na ótica. Essas últimas imagens contêm dados pessoais e de saúde reais e não devem ser publicadas sem anonimização. **Data da visita/entrevista:** 05/09/2026. O acesso relatado foi presencial na unidade.

---

## 2. Processos de Negócio
*(vale 10% — Dimensão Procedimental)*

- **Principais processos mapeados:**
  1. **Atendimento e prescrição:** o cliente comparece à loja e é atendido por um funcionário. Uma receita trazida pelo cliente é aceita segundo a prática informada de até um ano; caso contrário, a ótica realiza teste e produz um laudo. A data da receita é anotada. O laudo fotografado tem medidas para longe/perto e olho direito/esquerdo; DNP e Altura aparecem no formulário do pedido e sua origem depende do atendimento.
  2. **Pedido e venda:** após conversar sobre as necessidades do cliente, o consultor registra armação e lente no formulário. Há via da ótica e comprovante resumido para o cliente. O formulário identifica consultor, cliente, datas, medidas, produtos, quantidades, preços por armação/par de lentes, total, sinal pago e saldo.
  3. **Pagamento e parcelas:** a ótica aceita Pix, dinheiro, débito e crédito, inclusive pagamento parcial ou parcelado. As parcelas são acompanhadas em planilha separada; seus cabeçalhos não foram fornecidos.
  4. **Estoque e fornecedores:** o pedido pode ser atendido só com produtos disponíveis. Se necessário, o gerente solicita lentes/armações a um ou mais fornecedores, anotando fornecedor/contato, produto, quantidade, custo, data do pedido e chegada. Entradas e saídas são registradas na planilha de estoque.
  5. **Montagem, retirada e garantia:** após receber ou separar os produtos, a ótica monta e finaliza os óculos e avisa o cliente. “Data da Retirada” foi explicada como retirada efetiva. A garantia relatada dura um ano contado da montagem/finalização.
  6. **Trocas e devoluções:** o pedido de papel registra data do ocorrido, possível cobrança e descrição do dano. Na substituição, a ótica usa estoque quando disponível ou pede ao fornecedor. Peças intactas podem ser reaproveitadas; as demais são descartadas. Valor e critérios da cobrança não foram detalhados.


---

## 3. Requisitos do Sistema
*(esta seção e a Seção 4 "Regras de Negócio" DIVIDEM 7,5% na dimensão conceitual — juntas valem 7,5%, não 7,5% cada — + 4% exclusivos desta seção na organização/documentação)*

### 3.1 Requisitos Funcionais

Os requisitos abaixo são **propostas para o sistema**, fundamentadas no processo relatado; não afirmam que essas funções já existam.

| ID | O sistema deve permitir... | Origem |
|---|---|---|
| RF-01 | Cadastrar e consultar os dados de cliente usados no pedido. | Formulário fotografado. |
| RF-02 | Registrar atendimento e associá-lo ao cliente e ao funcionário responsável. | Atendimento presencial e campo “Consultor”. |
| RF-03 | Registrar receita trazida ou laudo da ótica, data e medidas por olho e distância, mantendo DNP e Altura distintos. | Laudo, pedido e entrevista. |
| RF-04 | Conferir a data da receita trazida conforme a regra de um ano informada pela ótica. | Entrevista. |
| RF-05 | Registrar pedido com armação/lente, quantidades, preços, total, sinal e saldo. | Formulário e comprovante. |
| RF-06 | Registrar recebimentos parciais e acompanhar parcelas sem perder o vínculo com o pedido. | Entrevista e planilha relatada. |
| RF-07 | Registrar compra a fornecedor e seus itens, quantidades, custos, data de solicitação e chegada. | Entrevista. |
| RF-08 | Registrar entradas e saídas de estoque ligadas aos produtos. | Planilha de estoque relatada. |
| RF-09 | Registrar montagem/finalização, retirada e o prazo de garantia derivado da data de montagem. | Entrevista e formulário. |
| RF-10 | Registrar troca/devolução, dano, eventual cobrança e destino de peças reaproveitadas ou descartadas. | Entrevista e anotação no pedido. |

### 3.2 Requisitos Não Funcionais

| ID | Qualidade proposta | Justificativa |
|---|---|---|
| RNF-01 | Restringir acesso a dados pessoais e às medidas ópticas conforme a função do usuário. | Os documentos contêm CPF, contatos e dados de saúde. |
| RNF-02 | Manter cópias de segurança e permitir recuperação após falha. | A ótica relatou falhas no banco de dados anterior. |
| RNF-03 | Preservar a integridade entre pedido, itens, pagamentos, compras e movimentos de estoque. | Evita registros órfãos e saldos sem origem. |
| RNF-04 | Em teste de uso com um funcionário, a consulta ao histórico e ao estado de um pedido deve ser concluída pela interface sem consultar papel ou planilhas. | Critério de usabilidade proposto porque hoje as informações estão distribuídas em vários registros. |
| RNF-05 | Manter uma trilha de auditoria com autor e data para alterações de valores, medidas e trocas. | Critério de rastreabilidade proposto para permitir conferência posterior das mudanças. |

---

## 4. Regras de Negócio
*(esta seção DIVIDE com a Seção 3 "Requisitos do Sistema" os mesmos 7,5% da dimensão conceitual — juntas valem 7,5%, não 7,5% cada — + 4% exclusivos desta seção na documentação. "Regras de negócio" é o termo técnico usado em modelagem de dados para as regras de funcionamento de qualquer organização, com ou sem fins lucrativos)*

- **Regras operacionais:**

  | ID | Regra | Fundamento |
  |---|---|---|
  | RN-01 | Não há venda sem atendimento. | Relato da entrevista. |
  | RN-02 | Cada pedido utiliza sua própria receita; a mesma receita não é reutilizada em outro pedido. | Esclarecimento do grupo sobre a entrevista. |
  | RN-03 | Receita trazida é conferida pela data segundo o prazo de um ano praticado pela ótica. | Relato da entrevista; não é afirmação de prazo legal geral. |
  | RN-04 | O pedido registra armação e lentes; os preços informados são por armação e por par de lentes. | Formulário e esclarecimento do grupo sobre a entrevista. |
  | RN-05 | O pedido pode ser pago em partes e ter parcelas acompanhadas em planilha. | Esclarecimento do grupo sobre a entrevista. |
  | RN-06 | Um pedido pode não gerar compra ao fornecedor quando houver produto em estoque; se houver compras, cada uma atende um único pedido e um fornecedor. | Esclarecimentos do grupo sobre a entrevista. |
  | RN-07 | A garantia de um ano começa na montagem/finalização. | Esclarecimento do grupo sobre a entrevista. |
  | RN-08 | Em troca/devolução, peças intactas podem ser reaproveitadas e as demais são descartadas. | Esclarecimento do grupo sobre a entrevista. |

- **Restrições organizacionais confirmadas:** A ótica confere a data da receita trazida conforme o prazo relatado de até um ano; cada pedido exige sua própria receita; a garantia relatada começa na montagem/finalização. Essas condições restringem o vínculo entre atendimento, receita, venda e garantia no modelo.
- **Cuidados de publicação:** O formulário contém dados pessoais e medidas ópticas. Por isso, exemplos divulgados devem ser fictícios, e as fotografias de documentos com dados reais não são anexadas sem anonimização.
- **Pendências do levantamento e propostas:** Não foram confirmados o valor ou critério da cobrança por dano, os cabeçalhos das planilhas e a referência de DNP/Altura por olho ou por par. Identificadores técnicos e estados do sistema são propostas de modelagem, não campos comprovados nos papéis atuais.

---

## 5. Dicionário de Dados Conceitual (Preliminar)
O dicionário descreve as **13 entidades e 90 atributos visíveis no DER atual do grupo**. A origem **DER — proposta** identifica campos desenhados sem confirmação no formulário, no laudo ou na entrevista. Essa correspondência de nomes não corrige os relacionamentos e as cardinalidades apontados na Seção 7.

**Nota de terminologia:** DE, DC e AV seguem o [informe da Secretaria da Saúde do Ceará](https://www.ce.gov.br/saude/download/boletins/); DNP segue a [denominação da Prefeitura de São Borja](https://www.saoborja.rs.gov.br/images/conteudo/Licitacoes/2024/OTICAS_SANTA_TERESA_LTDA.pdf). Essas fontes explicam termos, sem comprovar os procedimentos da ótica.

O mesmo arquivo HTML pode ser acessado de duas formas:

1. [Código do dicionário em HTML](Dicionario_de_Dados_Otica_Kadosh.html)
2. [Visualização direta do dicionário no GitHub Pages](https://jfpiresoficial.github.io/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados/Dicionario_de_Dados_Otica_Kadosh_Preliminar.html)

### CLIENTE

Pessoa identificada no formulário do pedido.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_cliente` | Código interno que distingue um cadastro de cliente dos demais no sistema proposto. | **Modelo:** Chave técnica proposta para ligar o cliente aos atendimentos; o formulário não apresenta esse código. |
| `nome` | Nome pelo qual o cliente é identificado no formulário de pedido. | **Formulário:** Refere-se ao cliente do pedido, não ao funcionário do campo ‘Consultor’; a obrigatoriedade do preenchimento não foi confirmada. |
| `data_nasc` | Data de nascimento informada para a pessoa atendida. | **Formulário:** Corresponde ao campo ‘Data Nasc.’; o formulário não esclarece se deve ser preenchido em todos os pedidos. |
| `cpf` | Número de inscrição do cliente no Cadastro de Pessoas Físicas (CPF). | **Formulário:** Há um campo ‘CPF’ no pedido; o grupo não confirmou exigência de preenchimento, validação ou uso como identificador único. |
| `email` | Endereço eletrônico informado pelo cliente para contato. | **Formulário:** O campo ‘E-mail’ aparece no pedido; não há confirmação de que o cliente precise fornecê-lo. |
| `bairro` | Nome do bairro indicado como parte do endereço do cliente. | **Formulário:** É registrado em campo próprio no pedido; seu preenchimento obrigatório não foi confirmado. |
| `cep` | Código de Endereçamento Postal (CEP) anotado para o endereço do cliente. | **Formulário:** Existe campo específico ‘CEP’; formato, conferência e obrigatoriedade não foram informados. |
| `numero_endereco` | Número do imóvel indicado na linha do endereço do cliente. | **Formulário:** Corresponde ao ‘Nº’ ao lado do CEP; não representa o número impresso do pedido. |
| `cidade` | Município informado no endereço do cliente. | **Formulário:** Há campo ‘Cidade’ no pedido; não foi confirmada regra para preenchimento ou padronização. |
| `telefone_fixo` | Número de telefone fixo informado como contato do cliente. | **Formulário:** O pedido separa ‘Tel. Fixo’ de ‘Tel. Celular’; não há exigência confirmada de informar ambos. |
| `telefone_celular` | Número de telefone celular informado como contato do cliente. | **Formulário:** O pedido possui campo próprio para celular; não foi confirmado se ele é sempre preenchido ou usado para avisar a retirada. |

**Observação:** O formulário também possui linha para endereço, mas a imagem atual do DER não desenha esse atributo. A inclusão precisa ser decidida no próprio DER; esta tabela descreve apenas os atributos visíveis nele.

### FUNCIONARIO

Integrante da equipe associado ao atendimento.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_funcionario` | Código interno que distingue cada integrante da equipe no sistema proposto. | **Modelo:** Chave técnica proposta para associar o responsável aos atendimentos; não consta no formulário. |
| `nome` | Nome do integrante da equipe que pode ser associado ao atendimento. | **Formulário e relato:** O pedido identifica um ‘Consultor’ e a entrevista identificou profissionais da ótica; o nome do cliente pertence a CLIENTE. |
| `funcao` | Papel desempenhado pelo integrante da equipe na operação da ótica. | **Relato:** Foram informadas as funções optometrista, gerente e consultor óptico; outras funções não foram confirmadas. |
| `telefone` | Número de telefone atribuído ao funcionário no desenho. | **DER — proposta:** O grupo não confirmou que guarda telefone individual de funcionário; o campo do DER permanece sem validação de uso. |
| `data_emissao` | Data indicada no desenho como atributo de funcionário, sem objeto de emissão definido. | **DER — proposta:** Não foi confirmado o que foi emitido nem por que a data pertence a FUNCIONARIO. Não interpretar como emissão dos óculos sem corrigir o DER. |

**Observação:** Telefone e data_emissao aparecem no desenho, mas não foram confirmados no levantamento. A data de montagem/finalização dos óculos pertence ao processo de venda.

### ATENDIMENTO

Ocorrência em que um funcionário atende um cliente na loja.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_atendimento` | Código interno de uma ocorrência de atendimento ao cliente no sistema proposto. | **Modelo:** Chave técnica proposta para ligar cliente, funcionário e eventual pedido; não está impressa no formulário. |
| `data_hora` | Data e horário em que o atendimento ao cliente ocorreu. | **Modelo:** Registro proposto; a ‘Data da Compra’ do pedido não comprova o horário nem substitui a data própria do atendimento. |
| `meio_contato` | Informação anotada no espaço ‘Meio de contato’ do formulário do pedido. | **Formulário:** O rótulo existe, mas a ótica não confirmou valores possíveis nem como usa o campo no atendimento. |
| `procedimento` | Caminho seguido para obter a prescrição usada no atendimento: receita apresentada ou teste realizado na ótica. | **Relato:** A receita trazida é conferida pelo prazo informado de até um ano; se não puder ser usada, foi relatado teste na ótica. |

**Observação:** Cada atendimento é associado no desenho a um cliente e a um funcionário. A relação com venda ainda tem cardinalidade a corrigir na imagem.

### RECEITA

Prescrição apresentada pelo cliente ou obtida no atendimento da ótica.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_receita` | Código interno que distingue a prescrição usada em um pedido no sistema proposto. | **Modelo:** Chave técnica proposta; o laudo fotografado não contém esse identificador. |
| `origem` | Indicação de onde veio a prescrição: apresentada pelo cliente ou produzida durante o atendimento na ótica. | **Relato:** Os dois caminhos foram relatados; o laudo fotografado é exemplo de documento produzido na ótica. |
| `data` | Data registrada no laudo ou na receita apresentada pelo cliente. | **Laudo e relato:** A data é anotada e, quando a receita vem de fora, é usada na conferência do prazo relatado de até um ano. |
| `observacao_laudo` | Informação complementar escrita no espaço ‘Obs.’ do laudo optométrico. | **Laudo:** Registrar apenas quando houver anotação; não foi confirmada exigência de preencher o campo. |
| `olho(OD/OE)` | Lado da prescrição a que uma linha de medidas se refere: olho direito (O.D.) ou esquerdo (O.E.). | **Laudo e formulário:** Os documentos separam os dois olhos; medidas de um olho não devem ser atribuídas automaticamente ao outro. |
| `distancia` | Finalidade visual da linha de prescrição, indicada nos documentos como ‘Longe’ ou ‘Perto’. | **Laudo e formulário:** As seções são separadas; não foi confirmado que ambas sempre tenham valores preenchidos. |
| `de/dc_laudo` | Rótulo conjunto usado na imagem para as medidas DE e DC do laudo. | **DER — proposta:** O laudo mostra DE e DC separadamente por olho e por longe/perto. O desenho não explica como os dois valores são guardados sem mistura. |
| `esferico_pedido` | Valor da coluna ‘Esférico’ na linha de prescrição do formulário de pedido. | **Formulário:** A anotação pertence ao olho e à seção de longe/perto correspondentes; não presumir equivalência confirmada com ‘DE’ do laudo. |
| `cilindro_pedido` | Valor da coluna ‘Cilíndrico’ na linha de prescrição do formulário de pedido. | **Formulário:** A anotação pertence ao olho e à seção de longe/perto correspondentes; não presumir equivalência confirmada com ‘DC’ do laudo. |
| `eixo` | Valor angular anotado na coluna ‘Eixo’ da linha de prescrição. | **Laudo e formulário:** Conservar a associação com olho e longe/perto; não há evidência de valor em todas as linhas. |
| `av` | Valor de acuidade visual (AV) anotado na linha correspondente do laudo optométrico. | **Laudo:** A sigla aparece no laudo; a finalidade desse registro no processo da ótica não foi esclarecida na entrevista. |
| `dnp` | Distância nasopupilar (DNP) registrada no formulário do pedido para a montagem das lentes. | **Formulário e relato:** DNP aparece no pedido, não no laudo mostrado. Sua referência por olho ou par não foi confirmada; no DER atual está ligada a RECEITA. |
| `altura` | Medida vertical anotada no campo ‘Altura’ do formulário para a montagem das lentes na armação. | **Formulário e relato:** Altura aparece no pedido, não no laudo mostrado. Sua referência por olho ou par não foi confirmada; no DER atual está ligada a RECEITA. |

**Observação:** A imagem reúne as medidas em RECEITA. Um atributo olho e uma distância únicos não demonstram como guardar as linhas distintas do olho direito/esquerdo e de longe/perto. O vínculo direto entre RECEITA e VENDA também não aparece no DER.

### VENDA

Pedido registrado após o atendimento ao cliente.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_venda` | Código interno que identifica de forma inequívoca o pedido no sistema proposto. | **Modelo:** Chave técnica proposta porque a unicidade do número impresso no bloco de pedidos não foi confirmada. |
| `data` | Data escrita no campo ‘Data da Compra’ do pedido comercial. | **Formulário:** Representa a data do pedido no formulário; não deve ser confundida com montagem, retirada efetiva ou pagamento. |
| `data_retirada` | Data em que o cliente efetivamente retirou os óculos finalizados. | **Formulário e relato:** O significado de retirada efetiva foi confirmado; não representa a data de montagem que inicia a garantia. |
| `horario_retirada` | Horário escrito após a expressão ‘A partir das’ no formulário. | **Formulário:** O papel traz esse horário, mas não foi confirmado se indica disponibilidade prevista ou momento efetivo da retirada. |
| `valor_total` | Valor total cobrado pelo conjunto de itens do pedido, antes de considerar o que já foi pago. | **Formulário e relato:** Corresponde a ‘Total: R$’ e ao ‘total do pedido’ esclarecido pelo usuário; não é o grau nem o valor da receita. |
| `valor_sinal_pago` | Quantia anotada no pedido como sinal ou montante já pago naquele registro. | **Formulário e relato:** O campo ‘Sinal/Pago’ convive com pagamentos parciais; não representa, por si só, todo o histórico de parcelas da planilha. |
| `valor_a_pagar` | Quantia restante indicada no campo ‘Valor a Pagar’ do pedido em papel. | **Formulário:** É o saldo anotado naquele momento; a atualização após parcelas, descontos ou ajustes não foi detalhada. |
| `data_montagem_finalizacao` | Data em que lente e armação foram montadas e os óculos ficaram finalizados. | **Relato:** Esse evento inicia o prazo de garantia de um ano informado pelo usuário, independentemente da data de retirada. |
| `status` | Etapa em que o pedido se encontra no acompanhamento pelo sistema proposto. | **Modelo:** Campo previsto no modelo; nomes e transições das etapas não foram confirmados com a ótica. |
| `observacao` | Texto livre anotado no campo ‘Obs.’ do pedido ou comprovante do cliente. | **Formulário:** O espaço existe nos documentos; conteúdo esperado e obrigatoriedade não foram esclarecidos. |

**Observação:** O formulário impresso possui número do pedido, mas a imagem do DER não o traz. A imagem também não liga VENDA diretamente a RECEITA ou COMPRA; essas são pendências de modelagem, não regras descartadas.

### PAGAMENTO

Valor efetivamente recebido em uma venda.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_pagamento` | Código interno que distingue um recebimento dos demais no sistema proposto. | **Modelo:** Chave técnica proposta para preservar vários pagamentos vinculados a um mesmo pedido. |
| `valor` | Quantia recebida do cliente em uma operação de pagamento específica. | **Formulário e relato:** Pagamentos parciais são aceitos; um recebimento individual não deve ser confundido com o total do pedido ou com todo o saldo pago. |
| `forma` | Meio pelo qual o cliente efetuou um recebimento específico. | **Relato:** Foram informados Pix, dinheiro, cartão de débito e cartão de crédito; parcelamento é tratado separadamente na planilha. |
| `data_pagamento` | Data em que o recebimento específico ocorreu. | **Modelo:** Registro proposto para acompanhar pagamentos parciais; não aparece como campo próprio no formulário fotografado. |

**Observação:** A ótica aceita pagamentos parciais. O mínimo 1 desenhado para os pagamentos de uma venda não foi confirmado como regra. O modelo de 13 entidades não detalha parcelas futuras anotadas em planilha.

### ITEM_VENDA

Produto e quantidade incluídos em um pedido.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_venda` | Identificador rotulado como id_venda na própria entidade ITEM_VENDA da imagem. | **DER — proposta:** O rótulo repete o identificador de VENDA e não distingue os itens entre si. Precisa de correção no desenho antes da implementação. |
| `quantidade` | Número de unidades de armação ou de pares de lentes registrados na linha do pedido. | **Formulário:** A ficha separa ‘Qnt. Armação’ e ‘Qnt. de Lentes em Pares’; interpretar a unidade conforme a categoria do produto. |
| `preco_unitario` | Preço cobrado por uma armação ou por um par de lentes no pedido. | **Formulário e relato:** ‘Valor Armação’ e ‘Valor da Lente’ foram confirmados como preços por unidade/par; não confundir com o valor total do pedido. |
| `tipo_armacao` | Descrição do tipo de armação escolhido pelo cliente para este item. | **Formulário:** Corresponde a ‘Tipo de Armação’; aplica-se ao item de armação, não ao de lente. |
| `referencia_armacao` | Código ou referência comercial anotado para a armação escolhida no pedido. | **Formulário:** Corresponde a ‘Ref. Armação’; formato, preenchimento e unicidade não foram confirmados. |
| `observacao_lente` | Comentário específico sobre a lente escolhida para o pedido. | **Formulário:** Corresponde a ‘Obs. da Lente’; aplica-se ao item de lente e não substitui as medidas da receita. |

**Observação:** No processo relatado, um item pertence a um único pedido. A imagem deve ser corrigida onde a cardinalidade permite vários pedidos para o mesmo item.

### PRODUTO

Armação ou lente identificável no catálogo e no estoque proposto.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_produto` | Código interno que distingue uma referência de armação ou lente no cadastro proposto. | **Modelo:** Chave técnica proposta para relacionar itens de venda, itens de compra e movimentos de estoque ao produto. |
| `tipo` | Tipo de produto representado pelo cadastro: armação ou lente. | **Relato:** A ótica informou venda separada apenas dessas duas categorias; serviços ou outros produtos não foram confirmados. |
| `referencia` | Código, modelo ou outra referência comercial que ajuda a reconhecer o produto. | **Formulário e Modelo:** O formulário mostra referência para armação; existência de referência equivalente para lentes no cadastro atual não foi confirmada. |
| `marca` | Nome da marca associada à armação ou lente, se usado para identificá-la. | **Formulário e Modelo:** Há marcas e opções de lente no formulário; a existência de um cadastro geral de marcas na ótica não foi confirmada. |
| `material` | Material atribuído ao produto no desenho. | **DER — proposta:** Pode descrever uma armação, mas o uso e preenchimento pela ótica não foram confirmados. |
| `tipo_montagem` | Tipo de montagem indicado para o produto no desenho. | **DER — proposta:** Classificação proposta no DER; a ótica não confirmou valores ou preenchimento. |
| `tratamento` | Tratamento indicado para uma lente no desenho. | **DER — proposta:** O formulário apresenta opções de lente, mas não foi confirmado como cada tratamento é registrado no estoque. |
| `medida` | Medida técnica do produto indicada genericamente no desenho. | **DER — proposta:** A grandeza e a unidade não foram especificadas; não confundir automaticamente com DNP ou Altura do pedido. |
| `grau` | Grau óptico associado ao produto no desenho. | **DER — proposta:** O grau do cliente é parte da prescrição; a relação exata com o cadastro de produto não foi esclarecida. |
| `bloco` | Característica de lente denominada bloco no desenho. | **DER — proposta:** O formulário não confirma que a ótica cadastre esse dado para todos os produtos. |
| `indice` | Índice de lente indicado no desenho. | **DER — proposta:** Há opções de índice no formulário, mas seu uso por produto precisa ser validado. |
| `quantidade_disponivel` | Saldo de unidades disponíveis atribuído ao produto no desenho. | **DER — proposta:** O saldo deve ser apurado pelas entradas e saídas registradas; se mantido, é derivado e não outro total independente. |

**Observação:** Armações e lentes têm características diferentes; campos específicos podem ficar vazios conforme o tipo. A imagem não marca quantidade_disponivel como derivada, embora essa seja a interpretação coerente com MOVIMENTO_ESTOQUE.

### FORNECEDOR

Organização da qual a ótica solicita armações ou lentes.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_fornecimento` | Código desenhado para identificar um fornecedor, com o rótulo id_fornecimento. | **DER — proposta:** O nome pode ser confundido com uma transação de fornecimento; o grupo não confirmou uso de código no cadastro atual. |
| `nome` | Nome pelo qual o fornecedor de lentes ou armações é identificado pela ótica. | **Relato:** O usuário confirmou o registro do nome; não foram fornecidas regras de padronização ou identificação fiscal. |
| `contato` | Informação usada para falar com o fornecedor, como telefone ou canal de mensagens. | **Relato:** O contato é registrado e o gerente acompanha solicitações por mensagens ou ligações; formato do dado não foi confirmado. |
| `telefone` | Número telefônico atribuído ao fornecedor no desenho. | **DER — proposta:** Foi confirmado que há contato com fornecedores por ligações e mensagens, mas não a separação deste campo de contato. |
| `localizacao` | Localização ou endereço do fornecedor indicado no desenho. | **DER — proposta:** A entrevista não confirmou que a ótica registre endereço de fornecedor. |
| `cnpj` | Número de inscrição do fornecedor no Cadastro Nacional da Pessoa Jurídica (CNPJ). | **DER — proposta:** Campo proposto no desenho; seu registro pela ótica não foi confirmado. |

**Observação:** Nome e meio de contato foram relatados. Telefone, localização e CNPJ aparecem no DER como propostas sem confirmação no levantamento.

### COMPRA

Solicitação de produtos a um fornecedor.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_compra` | Código interno que distingue uma solicitação feita a fornecedor no sistema proposto. | **Modelo:** Chave técnica proposta; cada solicitação deve poder ser associada ao pedido de cliente e ao fornecedor correspondentes. |
| `data_pedido` | Data em que a ótica encaminhou a solicitação de produtos ao fornecedor. | **Relato:** É um dado confirmado da compra; não se confunde com a ‘Data da Compra’ registrada para o cliente em VENDA. |
| `data_chegada` | Data em que os itens solicitados foram recebidos na ótica. | **Relato:** É informada para acompanhar a compra; seu preenchimento antes da chegada não foi definido. |
| `status_compra` | Situação de acompanhamento da solicitação ao fornecedor no sistema proposto. | **Modelo:** O gerente acompanha o pedido, mas os nomes de estados e a forma de registrá-los não foram confirmados. |
| `valor_total` | Valor total atribuído à compra no desenho. | **DER — proposta:** O custo da solicitação foi confirmado, mas não se sabe se o valor anotado é unitário ou total; não assumir cálculo. |
| `tipo_compra` | Categoria atribuída à solicitação ao fornecedor no desenho. | **DER — proposta:** Valores possíveis e uso pela ótica não foram confirmados. |

**Observação:** Uma compra pode atender um pedido de cliente, mas o DER atual não liga COMPRA a VENDA. Isso impede identificar a qual pedido cada compra pertence apenas pelo desenho.

### ITEM_COMPRA

Linha de produto incluída em uma solicitação ao fornecedor.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_item_compra` | Código interno que distingue uma linha de produto em uma solicitação ao fornecedor. | **Modelo:** Chave técnica proposta para separar produtos e quantidades de uma mesma compra. |
| `quantidade` | Número de unidades do produto solicitadas nesta linha da compra. | **Relato:** A quantidade é registrada; a unidade usada para cada categoria não foi detalhada na entrevista. |
| `custo_unitario` | Valor de custo de uma linha da compra, rotulado como unitário na imagem. | **Relato:** A ótica confirmou o registro de custo, mas não se refere ao valor por unidade ou ao total. O termo unitário do DER permanece sem validação. |

**Observação:** Cada linha pertence a uma compra e identifica um produto no desenho. O significado de custo_unitario é pendência da entrevista.

### TROCA_DEVOLUCAO

Ocorrência de troca ou devolução relacionada a item vendido.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_ocorrencia` | Código interno que distingue cada caso de troca ou devolução no sistema proposto. | **Modelo:** Chave técnica proposta para ligar a ocorrência ao item vendido e a eventuais movimentos de estoque. |
| `data` | Data anotada para o fato que levou o cliente a solicitar troca ou devolução. | **Relato:** O usuário informou que a data do ocorrido é escrita no pedido de papel; não a confundir automaticamente com a data do registro. |
| `tipo` | Classificação da ocorrência como troca ou devolução no sistema proposto. | **Modelo:** Serve para distinguir os dois processos; não foi observado campo impresso com esse nome no pedido. |
| `descricao_dano` | Relato do que quebrou ou foi danificado no produto apresentado pelo cliente. | **Relato:** A descrição é anotada no pedido de papel e ajuda a distinguir peça reaproveitável de peça descartada. |
| `multa_aplicada` | Indicação de que houve cobrança ao cliente relacionada à ocorrência. | **Relato:** Foi relatada cobrança em alguns danos, inclusive por imprudência; valor e critério de decisão não foram confirmados. |
| `status` | Situação da ocorrência de troca ou devolução indicada no desenho. | **DER — proposta:** O registro em papel de data, dano e eventual cobrança foi relatado; categorias de status não foram confirmadas. |

**Observação:** O DER associa uma ocorrência a um item vendido. Não foi confirmado se um único registro de troca pode abranger vários itens; a regra do desenho deve ser tratada como escolha do modelo, não fato da ótica.

### MOVIMENTO_ESTOQUE

Lançamento de entrada ou saída de produto no estoque.

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| `id_movimento` | Código interno que distingue uma entrada ou saída de produto/peça no sistema proposto. | **Modelo:** Chave técnica proposta para rastrear lançamentos separados do mesmo produto no estoque. |
| `data` | Data atribuída ao lançamento de entrada ou saída no controle de estoque. | **Relato e Modelo:** A ótica registra entradas e saídas em planilha; o nome exato dessa coluna e a diferença entre data do fato e do lançamento não foram informados. |
| `quantidade` | Número de unidades ou peças afetadas por um lançamento de estoque. | **Relato e Modelo:** A quantidade deve ser interpretada com o produto e o tipo de movimento; unidade e formato da planilha não foram informados. |
| `tipo` | Classificação do lançamento de estoque, que precisa indicar ao menos entrada ou saída. | **Relato e Modelo:** Entradas e saídas são registradas. O desenho usa um único campo tipo e não distingue a direção do motivo do movimento. |

**Observação:** O tipo da imagem precisa distinguir o efeito no saldo. Se também registrar compra, venda, reaproveitamento ou descarte, o modelo deverá explicar como direção e motivo são codificados no mesmo campo.

---
## 6. Modelagem Conceitual (Entidades, Atributos, Relacionamentos)
*(vale 7,5% na dimensão conceitual)*

O desenho atual tem **13 entidades**. Elas correspondem às tabelas da Seção 5 e do dicionário HTML; essa correspondência de nomes não significa que todos os processos estejam representados corretamente.

**Atributos e classificações:** A Seção 5 lista os 90 atributos visíveis na imagem. Os identificadores internos são propostas técnicas; valores, datas e características descrevem registros operacionais. `quantidade_disponivel` deve ser interpretada como **derivada** dos movimentos de estoque, embora não esteja marcada assim no desenho. O círculo preenchido junto a `ITEM_VENDA.id_venda` repete o código da venda e não identifica unicamente uma linha; `FUNCIONARIO.data_emissao` não tem significado confirmado. `custo_unitario` aparece na imagem, mas o custo por unidade ou por linha não foi confirmado. Os campos identificados como **DER — proposta** no dicionário não foram apresentados como prática atual da ótica.

**Relacionamentos desenhados:** CLIENTE e FUNCIONARIO ligam-se a ATENDIMENTO; ATENDIMENTO liga-se a RECEITA e VENDA; CLIENTE também se liga a VENDA. VENDA liga-se a PAGAMENTO e ITEM_VENDA; ITEM_VENDA liga-se a PRODUTO e TROCA_DEVOLUCAO. FORNECEDOR liga-se a COMPRA, que contém ITEM_COMPRA ligado a PRODUTO. PRODUTO e TROCA_DEVOLUCAO ligam-se a MOVIMENTO_ESTOQUE.

**Restrições ainda não expressas pelo desenho:** Cada venda precisa de sua própria receita, e cada compra feita para um cliente precisa apontar para o pedido correspondente. Essas regras relatadas exigem vínculos VENDA–RECEITA e VENDA–COMPRA, ou solução conceitual equivalente, ausentes na imagem. As medidas da receita repetem-se por olho e por longe/perto; a imagem não indica como guardar cada combinação. As parcelas futuras relatadas na entrevista também não estão modeladas. As cardinalidades problemáticas estão discriminadas na Seção 7.

---
## 7. Diagrama Entidade-Relacionamento (DER)
*(vale 20% — é o item de maior peso da entrega)*

![DER conceitual elaborado pelo grupo no brModelo](https://github.com/jfpiresoficial/Entrega-1-Modelo-Conceitual-DER---otica-kadosh-modelagem-dados/blob/main/DER_conceitual_BRMW_HD.jpg)



---

## 8. Justificativa Técnica
*(vale 7,5% — sozinho, é o subcritério de maior peso dentro da Dimensão Conceitual)*

O modelo separa CLIENTE e FUNCIONARIO de ATENDIMENTO para manter o histórico de visitas e de profissionais responsáveis. VENDA representa o pedido decorrente desse atendimento; ITEM_VENDA separa cada armação ou lente vendida, sua quantidade e seu preço. Do lado dos fornecedores, COMPRA e ITEM_COMPRA separam a solicitação de suas linhas. Essa divisão permite registrar mais de um produto sem repetir os dados gerais do pedido ou da compra.

PAGAMENTO foi mantido como entidade porque o grupo relatou recebimentos parciais. Uma venda pode receber vários valores em momentos diferentes. A imagem, porém, exige pelo menos um pagamento inicial e não representa as parcelas futuras acompanhadas em planilha; por isso ainda não sustenta integralmente o RF-06 e a RN-05. O custo em ITEM_COMPRA não pode ser justificado como unitário antes de resposta da ótica.

PRODUTO concentra a identificação das armações e lentes. MOVIMENTO_ESTOQUE registra entradas e saídas para que o saldo disponível possa ser calculado; manter `quantidade_disponivel` como outro número editado de forma independente criaria divergências. TROCA_DEVOLUCAO foi separada da venda para conservar a data, o dano e a eventual cobrança de cada ocorrência. O reaproveitamento ou descarte pode exigir movimento de estoque, conforme relatado.

RECEITA guarda origem e data para a conferência do prazo relatado de até um ano. O formulário e o laudo mostram medidas diferentes para cada olho e para longe/perto. O DER atual agrupa essas informações em atributos únicos de RECEITA e também coloca nela DNP e Altura, embora estes apareçam no pedido. A imagem não demonstra como preservar todas as combinações sem sobrescrever valores. A garantia relatada começa na montagem/finalização, data mantida em VENDA; seu término após um ano pode ser calculado a partir dela.

As regras mais importantes ainda sem representação suficiente são a receita exclusiva de cada pedido, a compra opcional associada ao pedido e as cardinalidades de atendimento, pagamentos e itens. As escolhas de atributos propostas sem confirmação estão identificadas no dicionário. **Enquanto o JPG não for corrigido, esta justificativa descreve as intenções e limitações do modelo de 13 entidades; não valida o DER como pronto para entrega.**

---

## 9. Uso de Inteligência Artificial
*(documentação do uso de IA na Entrega 1)*

Os registros abaixo foram redigidos a partir do relato do grupo. Nos prompts, a ortografia foi ajustada para leitura, mantendo os pedidos informados. Quando o grupo não identificou um material específico ou uma forma de verificação, isso é indicado sem atribuir uma checagem não comprovada.

### Uso 1 — análise do material inicial

| Item | Registro do grupo |
|------|-------------------|
| **Ferramenta e etapa** | ChatGPT, usado para compreender o projeto, organizar o trabalho e preparar perguntas para o gerente da ótica. |
| **Motivação** | O grupo precisava entender por onde começar e como conduzir a pesquisa necessária à Entrega 1. |
| **Prompt(s) utilizados** | “Baseado no arquivo do Esqueleto 1, atue como professor de modelagem de dados: quais são as perguntas interessantes a fazer para a ótica?” |
| **Resposta recebida** | A IA apresentou um roteiro com 40 perguntas sobre a rotina da ótica e orientou a organização inicial do trabalho. A partir dessa orientação, o grupo começou pelo DER. |
| **Fontes consultadas e verificadas** | O grupo confirmou que, da [pasta de materiais do professor](https://drive.google.com/drive/folders/1QVVdiG4LxFE7L3BSnZDFmHyakaoPX94A), consultou somente o [Esqueleto da Entrega 1](https://drive.google.com/file/d/1Mqoz90sJTxb41z3u9uWA0ZjPIihGC7ql/view). A cópia local foi comparada com os títulos e itens do README. A quantidade e a seleção das perguntas foram relatadas pelo grupo. |
| **Trechos rejeitados ou corrigidos** | Uma proposta anterior continha cerca de 120 perguntas; o grupo a reduziu para respeitar o tempo do gerente. Também descartou uma estrutura de README que não seguia o Esqueleto da Entrega 1. |
| **Justificativa da escolha final** | As 40 perguntas foram consideradas suficientes para investigar a rotina da ótica sem tornar a entrevista excessivamente longa. O README foi reorganizado conforme o esqueleto pedido. |
| **Reflexão crítica** | A IA ajudou a planejar a pesquisa, mas também sugeriu informações e uma estrutura que não correspondiam ao trabalho. O grupo precisou selecionar as perguntas e conferir o material antes de usá-lo. |

### Uso 2 — revisão do DER

| Item | Registro do grupo |
|------|-------------------|
| **Ferramenta e etapa** | ChatGPT (GPT-6 Sol) e Claude como apoio; brModelo para elaborar o DER. Segundo o grupo, Claude também auxiliou na conversão do PDF exportado para JPEG e na melhoria de sua legibilidade. |
| **Motivação** | Criar uma base para compreender o fluxo da ótica e, depois, desenhar e revisar o diagrama no brModelo. |
| **Prompt(s) utilizados** | “Com base nessas respostas, crie um DER no modelo do brModelo”; “aprimore as informações do DER”; “transforme esse arquivo PDF em JPEG e melhore a qualidade da imagem”. |
| **Resposta recebida** | Foi criada uma proposta inicial de DER, posteriormente ampliada com atributos e relações; também foi gerada uma versão da imagem em JPEG. |
| **Fontes consultadas e verificadas** | Da pasta do professor, o grupo informou ter usado somente o [Esqueleto da Entrega 1](https://drive.google.com/file/d/1Mqoz90sJTxb41z3u9uWA0ZjPIihGC7ql/view). A imagem JPG do DER presente neste repositório foi aberta e comparada com as exigências da Seção 7 e com as regras RN-01 a RN-08; a conferência identificou divergências ainda não resolvidas. |
| **Trechos rejeitados ou corrigidos** | O primeiro DER era simples demais, e uma das propostas posteriores representava incorretamente informações já fornecidas. O grupo revisou o desenho no brModelo. |
| **Justificativa da escolha final** | A proposta inicial serviu como ponto de partida; o grupo a ampliou e corrigiu para representar melhor os dados e processos levantados. |
| **Reflexão crítica** | Os primeiros resultados não atenderam às expectativas do grupo. A comparação do JPG atual com o dicionário confirmou as 13 entidades, mas também revelou vínculos e cardinalidades que o texto não consegue corrigir. |

### Uso 3 — dicionário e README

| Item | Registro do grupo |
|------|-------------------|
| **Ferramenta e etapa** | ChatGPT (GPT-6 Sol), usado para criar uma base para o README. |
| **Motivação** | Organizar no GitHub o material já levantado para a Entrega 1. |
| **Prompt(s) utilizados** | “Com o DER criado e as perguntas, analise o Esqueleto 1 e crie um DER base para o GitHub.” Esta é a expressão informada pelo grupo, embora a etapa tenha sido descrita como elaboração do README. |
| **Resposta recebida** | Segundo o grupo, a IA forneceu uma base de DER e o código usado como apoio à organização do trabalho no GitHub. |
| **Fontes consultadas e verificadas** | Não houve fonte adicional informada nesta etapa. O Esqueleto da Entrega 1, mencionado no prompt, foi comparado com a estrutura do README nesta revisão. |
| **Trechos rejeitados ou corrigidos** | Algumas frases foram reescritas porque não expressavam com clareza o que o grupo queria relatar. |
| **Justificativa da escolha final** | O README foi mantido como arquivo principal para apresentar e organizar o trabalho no repositório. |
| **Reflexão crítica** | Nessa etapa, a IA ajudou a estruturar o texto com mais precisão; mesmo assim, o grupo revisou as frases antes de aceitá-las. |

### Uso 4 — alinhamento do DER com o dicionário

| Item | Registro do grupo |
|------|-------------------|
| **Ferramenta e etapa** | ChatGPT (GPT-6 Sol), Codex e Claude, usados para comparar DER e dicionário. O grupo informou que o dicionário em HTML foi criado com auxílio do ChatGPT. |
| **Motivação** | Verificar se as informações do DER e do dicionário se complementavam e identificar diferenças entre os dois arquivos. |
| **Prompt(s) utilizados** | “Atue como especialista em modelagem de dados, analise os dois arquivos anexados, indique o que está divergente e crie um dicionário em HTML com o README e o DER anexados.” |
| **Resposta recebida** | A análise apontou diferenças entre os arquivos, especialmente atributos ausentes no DER, e produziu uma versão do dicionário em HTML. |
| **Fontes consultadas e verificadas** | Da pasta do professor, o grupo informou ter usado somente o [Esqueleto da Entrega 1](https://drive.google.com/file/d/1Mqoz90sJTxb41z3u9uWA0ZjPIihGC7ql/view). Nesta revisão, as tabelas da Seção 5 foram comparadas com o [dicionário HTML](Dicionario_de_Dados_Otica_Kadosh.html), e ambos foram confrontados com o JPG do DER. A diferença de quantidade de entidades foi eliminada dos textos; os vínculos e cardinalidades pendentes estão na Seção 7. |
| **Trechos rejeitados ou corrigidos** | Segundo o grupo, foram acrescentados `ITEM_VENDA` e o registro de devolução, e foi retirada uma ligação direta entre RECEITA e CLIENTE. Esses três pontos aparecem no JPG atual; a comparação também identificou as pendências listadas na Seção 7. |
| **Justificativa da escolha final** | A comparação mostrou que o dicionário descrevia elementos que não apareciam no desenho, permitindo ao grupo revisar os dois artefatos em conjunto. |
| **Reflexão crítica** | A IA tornou as divergências mais visíveis. Alinhar os nomes do dicionário à imagem foi possível; corrigir os relacionamentos e as cardinalidades exige alterar o arquivo do DER, decisão que o grupo optou por adiar. |

### Uso 5 — inclusão do DER do grupo no README

| Item | Registro do grupo |
|------|-------------------|
| **Ferramenta e etapa** | ChatGPT (GPT-6 Sol), Codex e Claude, consultados para orientar a apresentação do DER no README. |
| **Motivação** | O grupo teve dificuldade para inserir no README do GitHub a imagem exportada do diagrama. |
| **Prompt(s) utilizados** | “Atue como professor e me auxilie a organizar a imagem do DER no README.” |
| **Resposta recebida** | A IA explicou o passo a passo e apresentou formas de organizar a imagem no repositório. |
| **Fontes consultadas e verificadas** | O grupo indicou [este vídeo sobre inserção de imagens no GitHub](https://youtu.be/9ygf4hkLVnA?si=iCP3OWCSNehCurkn). A escolha de manter o JPG do DER no mesmo repositório do README foi verificada pela presença dos dois arquivos; o conteúdo do vídeo não foi reavaliado nesta revisão. |
| **Trechos rejeitados ou corrigidos** | O grupo rejeitou a sugestão de manter a imagem em outro repositório. |
| **Justificativa da escolha final** | O grupo decidiu manter a imagem do DER no mesmo repositório do README para facilitar a organização e a visualização do trabalho. |
| **Reflexão crítica** | Entre as soluções sugeridas, a mais simples atendia à necessidade do grupo; a alternativa de usar repositórios diferentes acrescentava trabalho sem benefício para esta entrega. |

---

## Critérios Atitudinais (20%)
**Estes critérios NÃO constam explicitamente como item de entrega no README.** Eles são avaliados por meio de **Avaliação 360º entre os integrantes do grupo** (cada membro avalia os colegas de equipe) e, no caso da Colaboração, também pela **colaboração equilibrada no histórico de commits** do repositório GitHub — não pela leitura do restante do repositório nem pela apresentação:

- **Participação (5%):** envolvimento nas discussões técnicas e nas decisões do grupo.
- **Comprometimento (5%):** cumprimento de prazos e responsabilidades assumidas.
- **Colaboração (5%):** respeito às contribuições dos colegas, cooperação na construção do projeto e colaboração equilibrada no histórico de commits do repositório GitHub.
- **Autonomia (5%):** busca independente de soluções e proposta de melhorias.

---

## Resumo dos Pesos

| Dimensão | Peso total |
|----------|-----------|
| Conceitual (contexto, requisitos/regras, modelagem, justificativa técnica) | 30% |
| Procedimental (requisitos, fluxogramas, dicionário de dados, DER) | 50% |
| Atitudinal (participação, comprometimento, colaboração, autonomia) | 20% |

**Entrega final:** README.md completo + DER + Dicionário de Dados em HTML (com exceção dos cursos GTI) anexado no repositório GitHub do grupo.

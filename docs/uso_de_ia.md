# Transparência do uso de IA — Entrega 2

Ferramenta: ChatGPT (OpenAI), usado como **assistente de organização, modelagem e elaboração de exemplos**, não como entrevistador nem fonte primária.

| Etapa | Motivo / prompt aproximado | Resultado | Verificação e decisão |
|---|---|---|---|
| Leitura da rubrica | “Trabalhe focando na Entrega 2 usando o esqueleto fornecido; estruture a documentação e os artefatos na main” | Checklist de README, DER, modelo lógico, SQL, massa, dicionário, apresentação | Requisitos confrontados com o esqueleto fornecido pelo professor |
| Revisão da E1 | “Confronte os processos da Ótica Kadosh do repositório original com o banco proposto” | Identificou atendimento, receita, medidas ópticas, compra vinculada ao pedido, montagem e troca ausentes no protótipo de 12 tabelas | Usado somente README original do grupo como fonte de campo; quaisquer novas regras são propostas |
| Projeto lógico e SQL | “Estruture PK, FK, CHECK, tabelas normalizadas e consultas gerenciais/auditoria para os problemas identificados” | Proposta SQL de 17 tabelas, G01–G10 e A01–A11 | Emissão e consistência dos scripts revistas textualmente; **teste MySQL pendente** |
| Dados de teste | “Gere massa totalmente fictícia para cerca de quatro semanas, coerente com 100 atendimentos/80 vendas semanais do relato da E1; inclua pedidos sem conclusão e estoque baixo” | 280 clientes fictícios, 400 atendimentos e 320 pedidos simulados, demais tabelas vinculadas por IDs | Dados sintéticos; **não representar os números internos reais** |
| Visualização | “Descreva um DER conceitual com losangos e cardinalidades e modelo lógico com tipos, PK/FK” | Diagramas técnicos para revisão pelo grupo | Conferir visualmente no navegador e, se necessário, reproduzir no brModelo |
| Pitch | “Organize 8 minutos: problemas, solução, modelo, SQL, consultas, BI/IA e benefícios” | Estrutura de apresentação e roteiro | A equipe deve ensaiar, realizar demonstração real e adaptar os slides |

**Trechos corrigidos/rejeitados:** o protótipo anterior de 12 tabelas foi rejeitado como representação integral da empresa; os funcionários e clientes gerados para testes foram rotulados como fictícios; a ausência de acesso ao repositório E1 foi corrigida porque ele está acessível; não foram inventados apontamentos do professor, novas respostas da entrevista nem resultados de testes MySQL.

**Reflexão crítica:** IA pode propor relacionamentos ou supor regras operacionais inexistentes; consultas sintaticamente plausíveis podem falhar na execução, e dados sintéticos não validam previsões. O grupo é responsável por validar junto ao entrevistado e ao professor.
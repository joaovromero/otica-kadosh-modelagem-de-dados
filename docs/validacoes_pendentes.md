# Verificações antes da submissão final da Entrega 2

**A execução no MySQL 8 ainda precisa ser feita pela equipe.** O código SQL foi escrito para MySQL 8.0.16+, mas não foi homologado contra uma instância MySQL real nesta sessão. Não afirmar no seminário que os comandos foram executados se não houver captura de tela/log do Workbench.

1. **Feedback E1:** solicitar a correção individual do professor; preencher a tabela de mudanças no README com cada apontamento real.
2. **Diagrama:** conferir cardinalidades mín/máx dos SVGs e, se solicitado, redesenhar no programa brModelo preservando semântica e versão final.
3. **Fontes:** validar com o grupo a entrevista de 05/09/2026 e os integrantes presentes; a fotografia é da loja, mas não se confirmou que ela retrata a entrevista.
4. **Dados sensíveis:** o SQL só deve conter dados simulados. Medidas ópticas reais e documentos de clientes não devem aparecer no repositório público.
5. **SQL:** executar docs/script.sql do início ao fim em MySQL 8.0.16+; confirmar resultados de G01–G10 e A01–A11, incluindo A01–A11 sem violações inesperadas. Documentar o SGBD e a data.
6. **Regras entre tabelas:** a verificação temporal da receita, saldo não negativo de estoque, soma de pagamentos e obrigatoriedade de itens/receita foram apoiadas por consultas de auditoria; a aplicação deverá usar transações, validações ou triggers, pois CHECK sozinho não cobre essas condições multirregistro.
7. **Massa:** volume de 400 atendimentos e 320 pedidos representa quatro semanas fictícias construídas a partir das estimativas do grupo; não é cadastro ou faturamento observado.
8. **Equipe:** cada integrante deve fazer commits próprios e participar da apresentação e defesa. Não atribuir autoria falsa nem simular histórico.
9. **Pitch:** confirmar que SQL roda ao vivo; ensaiar a apresentação cronometrada de oito minutos.

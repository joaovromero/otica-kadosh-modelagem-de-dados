-- OTICA KADOSH | Modelo acadêmico proposto; confirmar regras e processos em pesquisa de campo.
-- MySQL 8.0.16+; arquivo executável do início ao fim em base vazia.
-- TODO: o nome da empresa não significa que os dados inseridos sejam reais.
CREATE DATABASE IF NOT EXISTS otica_kadosh CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE otica_kadosh;

CREATE TABLE cliente (
 id_cliente INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(120) NOT NULL, telefone VARCHAR(20) NOT NULL,
 email VARCHAR(150), cpf CHAR(11) UNIQUE, ativo BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;
CREATE TABLE funcionario (
 id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(120) NOT NULL, cargo VARCHAR(60) NOT NULL,
 ativo BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;
CREATE TABLE fornecedor (
 id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(120) NOT NULL, cnpj CHAR(14) UNIQUE, telefone VARCHAR(20)
) ENGINE=InnoDB;
CREATE TABLE categoria (
 id_categoria INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(60) NOT NULL UNIQUE
) ENGINE=InnoDB;
CREATE TABLE produto (
 id_produto INT AUTO_INCREMENT PRIMARY KEY, id_categoria INT NOT NULL,
 sku VARCHAR(40) NOT NULL UNIQUE, descricao VARCHAR(160) NOT NULL,
 preco_venda DECIMAL(10,2) NOT NULL CHECK(preco_venda>=0),
 estoque_minimo INT NOT NULL DEFAULT 0 CHECK(estoque_minimo>=0),
 ativo BOOLEAN NOT NULL DEFAULT TRUE,
 FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE compra (
 id_compra INT AUTO_INCREMENT PRIMARY KEY, id_fornecedor INT NOT NULL,
 id_funcionario INT NOT NULL, data_compra DATE NOT NULL,
 status VARCHAR(15) NOT NULL CHECK(status IN ('ABERTA','RECEBIDA','CANCELADA')),
 FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor) ON DELETE RESTRICT,
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE item_compra (
 id_compra INT NOT NULL, id_produto INT NOT NULL,
 quantidade INT NOT NULL CHECK(quantidade>0),
 custo_unitario DECIMAL(10,2) NOT NULL CHECK(custo_unitario>=0),
 PRIMARY KEY(id_compra,id_produto),
 FOREIGN KEY(id_compra) REFERENCES compra(id_compra) ON DELETE RESTRICT,
 FOREIGN KEY(id_produto) REFERENCES produto(id_produto) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE venda (
 id_venda INT AUTO_INCREMENT PRIMARY KEY, id_cliente INT NOT NULL,
 id_funcionario INT NOT NULL, data_venda DATE NOT NULL,
 status VARCHAR(15) NOT NULL CHECK(status IN ('ABERTA','CONCLUIDA','CANCELADA')),
 desconto DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK(desconto>=0),
 FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente) ON DELETE RESTRICT,
 FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE item_venda (
 id_venda INT NOT NULL, id_produto INT NOT NULL,
 quantidade INT NOT NULL CHECK(quantidade>0),
 preco_unitario DECIMAL(10,2) NOT NULL CHECK(preco_unitario>=0),
 PRIMARY KEY (id_venda,id_produto),
 FOREIGN KEY(id_venda) REFERENCES venda(id_venda) ON DELETE RESTRICT,
 FOREIGN KEY(id_produto) REFERENCES produto(id_produto) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE pagamento (
 id_pagamento INT AUTO_INCREMENT PRIMARY KEY, id_venda INT NOT NULL,
 data_pagamento DATE NOT NULL,
 forma VARCHAR(15) NOT NULL CHECK(forma IN ('PIX','DINHEIRO','DEBITO','CREDITO')),
 valor DECIMAL(10,2) NOT NULL CHECK(valor>0),
 status VARCHAR(15) NOT NULL CHECK(status IN ('CONFIRMADO','ESTORNADO')),
 FOREIGN KEY(id_venda) REFERENCES venda(id_venda) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE movimentacao_estoque (
 id_movimentacao INT AUTO_INCREMENT PRIMARY KEY, id_produto INT NOT NULL,
 id_compra INT NULL, id_venda INT NULL,
 data_movimento DATE NOT NULL, tipo VARCHAR(20) NOT NULL,
 quantidade INT NOT NULL CHECK(quantidade>0), observacao VARCHAR(200),
 CONSTRAINT ck_origem_mov CHECK (
  (tipo='ENTRADA_COMPRA' AND id_compra IS NOT NULL AND id_venda IS NULL) OR
  (tipo='SAIDA_VENDA' AND id_venda IS NOT NULL AND id_compra IS NULL) OR
  (tipo IN ('AJUSTE_ENTRADA','AJUSTE_SAIDA') AND id_venda IS NULL AND id_compra IS NULL)
 ),
 FOREIGN KEY(id_produto) REFERENCES produto(id_produto) ON DELETE RESTRICT,
 FOREIGN KEY(id_compra) REFERENCES compra(id_compra) ON DELETE RESTRICT,
 FOREIGN KEY(id_venda) REFERENCES venda(id_venda) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE ordem_montagem (
 id_ordem INT AUTO_INCREMENT PRIMARY KEY,
 id_venda INT NOT NULL UNIQUE, id_funcionario INT NOT NULL,
 data_abertura DATE NOT NULL, data_prevista DATE NOT NULL,
 data_conclusao DATE NULL,
 status VARCHAR(15) NOT NULL CHECK(status IN ('PENDENTE','EM_EXECUCAO','CONCLUIDA','CANCELADA')),
 observacao VARCHAR(200),
 CONSTRAINT ck_ordem_datas CHECK(data_prevista>=data_abertura AND (data_conclusao IS NULL OR data_conclusao>=data_abertura)),
 FOREIGN KEY(id_venda) REFERENCES venda(id_venda) ON DELETE RESTRICT,
 FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE INDEX idx_venda_data ON venda(data_venda);
CREATE INDEX idx_compra_data ON compra(data_compra);
CREATE INDEX idx_mov_produto_data ON movimentacao_estoque(id_produto,data_movimento);

-- MASSA DE DADOS FICTÍCIA, sintética e reproduzível (não corresponde à carteira real).
INSERT INTO cliente (id_cliente, nome, telefone, email, cpf, ativo) VALUES
 (1,'Ana Gomes','11990000001','cliente001@example.org',NULL,1),
 (2,'Bruno Pereira','11990000002','cliente002@example.org',NULL,1),
 (3,'Carla Duarte','11990000003','cliente003@example.org',NULL,1),
 (4,'Diego Oliveira','11990000004',NULL,NULL,1),
 (5,'Elisa Barbosa','11990000005','cliente005@example.org',NULL,1),
 (6,'Felipe Lima','11990000006','cliente006@example.org',NULL,1),
 (7,'Gabriela Ribeiro','11990000007','cliente007@example.org',NULL,1),
 (8,'Henrique Ferreira','11990000008',NULL,NULL,1),
 (9,'Isabela Souza','11990000009','cliente009@example.org',NULL,1),
 (10,'Joana Costa','11990000010','cliente010@example.org',NULL,1),
 (11,'Lucas Martins','11990000011','cliente011@example.org',NULL,1),
 (12,'Marina Almeida','11990000012',NULL,NULL,1),
 (13,'Nicolas Gomes','11990000013','cliente013@example.org',NULL,1),
 (14,'Olivia Pereira','11990000014','cliente014@example.org',NULL,1),
 (15,'Paulo Duarte','11990000015','cliente015@example.org',NULL,1),
 (16,'Renata Oliveira','11990000016',NULL,NULL,1),
 (17,'Sofia Barbosa','11990000017','cliente017@example.org',NULL,1),
 (18,'Tiago Lima','11990000018','cliente018@example.org',NULL,1),
 (19,'Valeria Ribeiro','11990000019','cliente019@example.org',NULL,1),
 (20,'Yuri Ferreira','11990000020',NULL,NULL,1),
 (21,'Ana Souza','11990000021','cliente021@example.org',NULL,1),
 (22,'Bruno Costa','11990000022','cliente022@example.org',NULL,1),
 (23,'Carla Martins','11990000023','cliente023@example.org',NULL,1),
 (24,'Diego Almeida','11990000024',NULL,NULL,1),
 (25,'Elisa Gomes','11990000025','cliente025@example.org',NULL,1),
 (26,'Felipe Pereira','11990000026','cliente026@example.org',NULL,1),
 (27,'Gabriela Duarte','11990000027','cliente027@example.org',NULL,1),
 (28,'Henrique Oliveira','11990000028',NULL,NULL,1),
 (29,'Isabela Barbosa','11990000029','cliente029@example.org',NULL,1),
 (30,'Joana Lima','11990000030','cliente030@example.org',NULL,1),
 (31,'Lucas Ribeiro','11990000031','cliente031@example.org',NULL,1),
 (32,'Marina Ferreira','11990000032',NULL,NULL,1),
 (33,'Nicolas Souza','11990000033','cliente033@example.org',NULL,1),
 (34,'Olivia Costa','11990000034','cliente034@example.org',NULL,1),
 (35,'Paulo Martins','11990000035','cliente035@example.org',NULL,1),
 (36,'Renata Almeida','11990000036',NULL,NULL,1),
 (37,'Sofia Gomes','11990000037','cliente037@example.org',NULL,1),
 (38,'Tiago Pereira','11990000038','cliente038@example.org',NULL,1),
 (39,'Valeria Duarte','11990000039','cliente039@example.org',NULL,1),
 (40,'Yuri Oliveira','11990000040',NULL,NULL,1),
 (41,'Ana Barbosa','11990000041','cliente041@example.org',NULL,1),
 (42,'Bruno Lima','11990000042','cliente042@example.org',NULL,1),
 (43,'Carla Ribeiro','11990000043','cliente043@example.org',NULL,1),
 (44,'Diego Ferreira','11990000044',NULL,NULL,1),
 (45,'Elisa Souza','11990000045','cliente045@example.org',NULL,1),
 (46,'Felipe Costa','11990000046','cliente046@example.org',NULL,1),
 (47,'Gabriela Martins','11990000047','cliente047@example.org',NULL,1),
 (48,'Henrique Almeida','11990000048',NULL,NULL,1),
 (49,'Isabela Gomes','11990000049','cliente049@example.org',NULL,1),
 (50,'Joana Pereira','11990000050','cliente050@example.org',NULL,1),
 (51,'Lucas Duarte','11990000051','cliente051@example.org',NULL,1),
 (52,'Marina Oliveira','11990000052',NULL,NULL,1),
 (53,'Nicolas Barbosa','11990000053','cliente053@example.org',NULL,1),
 (54,'Olivia Lima','11990000054','cliente054@example.org',NULL,1),
 (55,'Paulo Ribeiro','11990000055','cliente055@example.org',NULL,1),
 (56,'Renata Ferreira','11990000056',NULL,NULL,1),
 (57,'Sofia Souza','11990000057','cliente057@example.org',NULL,1),
 (58,'Tiago Costa','11990000058','cliente058@example.org',NULL,1),
 (59,'Valeria Martins','11990000059','cliente059@example.org',NULL,1),
 (60,'Yuri Almeida','11990000060',NULL,NULL,1);

INSERT INTO funcionario (id_funcionario, nome, cargo, ativo) VALUES
 (1,'Atendente Exemplo A','Atendimento',1),
 (2,'Atendente Exemplo B','Vendas',1),
 (3,'Auxiliar Exemplo C','Estoque',1),
 (4,'Colaborador Exemplo D','Montagem',1),
 (5,'Gestor Exemplo E','Gestão',1);

INSERT INTO fornecedor (id_fornecedor, nome, cnpj, telefone) VALUES
 (1,'Fornecedor Fictício 01',NULL,'1130000001'),
 (2,'Fornecedor Fictício 02',NULL,'1130000002'),
 (3,'Fornecedor Fictício 03',NULL,'1130000003'),
 (4,'Fornecedor Fictício 04',NULL,'1130000004'),
 (5,'Fornecedor Fictício 05',NULL,'1130000005'),
 (6,'Fornecedor Fictício 06',NULL,'1130000006');

INSERT INTO categoria (id_categoria, nome) VALUES
 (1,'ARMACAO'),
 (2,'LENTE'),
 (3,'ACESSORIO'),
 (4,'SOLAR');

INSERT INTO produto (id_produto, id_categoria, sku, descricao, preco_venda, estoque_minimo, ativo) VALUES
 (1,1,'OTK-0001','Produto óptico fictício 01',92,3,1),
 (2,1,'OTK-0002','Produto óptico fictício 02',105,3,1),
 (3,1,'OTK-0003','Produto óptico fictício 03',118,3,1),
 (4,1,'OTK-0004','Produto óptico fictício 04',131,3,1),
 (5,1,'OTK-0005','Produto óptico fictício 05',144,3,1),
 (6,1,'OTK-0006','Produto óptico fictício 06',157,3,1),
 (7,1,'OTK-0007','Produto óptico fictício 07',170,3,1),
 (8,1,'OTK-0008','Produto óptico fictício 08',183,3,1),
 (9,2,'OTK-0009','Produto óptico fictício 09',269,3,1),
 (10,2,'OTK-0010','Produto óptico fictício 10',285,3,1),
 (11,2,'OTK-0011','Produto óptico fictício 11',301,3,1),
 (12,2,'OTK-0012','Produto óptico fictício 12',317,3,1),
 (13,2,'OTK-0013','Produto óptico fictício 13',333,3,1),
 (14,2,'OTK-0014','Produto óptico fictício 14',349,3,1),
 (15,2,'OTK-0015','Produto óptico fictício 15',365,3,1),
 (16,3,'OTK-0016','Produto óptico fictício 16',98,3,1),
 (17,3,'OTK-0017','Produto óptico fictício 17',103,7,1),
 (18,3,'OTK-0018','Produto óptico fictício 18',108,3,1),
 (19,3,'OTK-0019','Produto óptico fictício 19',113,3,1),
 (20,3,'OTK-0020','Produto óptico fictício 20',118,3,1),
 (21,4,'OTK-0021','Produto óptico fictício 21',352,3,1),
 (22,4,'OTK-0022','Produto óptico fictício 22',365,80,1),
 (23,4,'OTK-0023','Produto óptico fictício 23',378,80,1),
 (24,4,'OTK-0024','Produto óptico fictício 24',391,3,1),
 (25,4,'OTK-0025','Produto óptico fictício 25',404,7,1);

INSERT INTO compra (id_compra, id_fornecedor, id_funcionario, data_compra, status) VALUES
 (1,2,2,'2026-08-08','RECEBIDA'),
 (2,3,3,'2026-08-11','RECEBIDA'),
 (3,4,4,'2026-08-14','RECEBIDA'),
 (4,5,5,'2026-08-17','RECEBIDA'),
 (5,6,1,'2026-08-20','RECEBIDA'),
 (6,1,2,'2026-08-23','RECEBIDA'),
 (7,2,3,'2026-08-26','RECEBIDA'),
 (8,3,4,'2026-08-29','RECEBIDA'),
 (9,4,5,'2026-09-01','RECEBIDA'),
 (10,5,1,'2026-09-04','RECEBIDA'),
 (11,6,2,'2026-09-07','ABERTA'),
 (12,1,3,'2026-09-10','CANCELADA');

INSERT INTO item_compra (id_compra, id_produto, quantidade, custo_unitario) VALUES
 (1,1,46,53.36),
 (1,2,47,60.9),
 (1,3,48,68.44),
 (2,4,47,75.98),
 (2,5,48,83.52),
 (2,6,49,91.06),
 (3,7,48,98.6),
 (3,8,49,106.14),
 (3,9,50,156.02),
 (4,10,49,165.3),
 (4,11,50,174.58),
 (4,12,51,183.86),
 (5,13,50,193.14),
 (5,14,51,202.42),
 (5,15,52,211.7),
 (6,16,51,56.84),
 (6,17,52,59.74),
 (6,18,53,62.64),
 (7,19,52,65.54),
 (7,20,53,68.44),
 (7,21,45,204.16),
 (8,22,53,211.7),
 (8,23,45,219.24),
 (8,24,46,226.78),
 (9,25,45,234.32),
 (9,1,46,53.36),
 (9,2,47,60.9),
 (10,3,46,68.44),
 (10,4,47,75.98),
 (10,5,48,83.52),
 (11,6,47,91.06),
 (11,7,48,98.6),
 (11,8,49,106.14),
 (12,9,48,156.02),
 (12,10,49,165.3),
 (12,11,50,174.58);

INSERT INTO venda (id_venda, id_cliente, id_funcionario, data_venda, status, desconto) VALUES
 (1,8,2,'2026-09-01','CONCLUIDA',0),
 (2,15,3,'2026-09-02','CONCLUIDA',0),
 (3,22,4,'2026-09-03','CONCLUIDA',0),
 (4,29,5,'2026-09-04','CONCLUIDA',0),
 (5,36,1,'2026-09-05','CONCLUIDA',0),
 (6,43,2,'2026-09-06','CONCLUIDA',0),
 (7,50,3,'2026-09-07','CONCLUIDA',10),
 (8,57,4,'2026-09-08','CONCLUIDA',0),
 (9,4,5,'2026-09-09','CONCLUIDA',0),
 (10,11,1,'2026-09-10','CONCLUIDA',0),
 (11,18,2,'2026-09-11','ABERTA',0),
 (12,25,3,'2026-09-12','CONCLUIDA',0),
 (13,32,4,'2026-09-13','CANCELADA',0),
 (14,39,5,'2026-09-14','CONCLUIDA',10),
 (15,46,1,'2026-09-15','CONCLUIDA',0),
 (16,53,2,'2026-09-16','CONCLUIDA',0),
 (17,60,3,'2026-09-17','CONCLUIDA',0),
 (18,7,4,'2026-09-18','CONCLUIDA',0),
 (19,14,5,'2026-09-19','CONCLUIDA',0),
 (20,21,1,'2026-09-20','CONCLUIDA',0),
 (21,28,2,'2026-09-21','CONCLUIDA',10),
 (22,35,3,'2026-09-22','ABERTA',0),
 (23,42,4,'2026-09-23','CONCLUIDA',0),
 (24,49,5,'2026-09-24','CONCLUIDA',0),
 (25,56,1,'2026-09-25','CONCLUIDA',0),
 (26,3,2,'2026-09-26','CANCELADA',0),
 (27,10,3,'2026-09-27','CONCLUIDA',0),
 (28,17,4,'2026-09-28','CONCLUIDA',10),
 (29,24,5,'2026-09-29','CONCLUIDA',0),
 (30,31,1,'2026-09-30','CONCLUIDA',0),
 (31,38,2,'2026-10-01','CONCLUIDA',0),
 (32,45,3,'2026-10-02','CONCLUIDA',0),
 (33,52,4,'2026-10-03','ABERTA',0),
 (34,59,5,'2026-10-04','CONCLUIDA',0),
 (35,6,1,'2026-10-05','CONCLUIDA',10),
 (36,13,2,'2026-10-06','CONCLUIDA',0),
 (37,20,3,'2026-10-07','CONCLUIDA',0),
 (38,27,4,'2026-10-08','CONCLUIDA',0),
 (39,34,5,'2026-09-01','CANCELADA',0),
 (40,41,1,'2026-09-02','CONCLUIDA',0),
 (41,48,2,'2026-09-03','CONCLUIDA',0),
 (42,55,3,'2026-09-04','CONCLUIDA',10),
 (43,2,4,'2026-09-05','CONCLUIDA',0),
 (44,9,5,'2026-09-06','ABERTA',0),
 (45,16,1,'2026-09-07','CONCLUIDA',0),
 (46,23,2,'2026-09-08','CONCLUIDA',0),
 (47,30,3,'2026-09-09','CONCLUIDA',0),
 (48,37,4,'2026-09-10','CONCLUIDA',0),
 (49,44,5,'2026-09-11','CONCLUIDA',10),
 (50,51,1,'2026-09-12','CONCLUIDA',0),
 (51,58,2,'2026-09-13','CONCLUIDA',0),
 (52,5,3,'2026-09-14','CANCELADA',0),
 (53,12,4,'2026-09-15','CONCLUIDA',0),
 (54,19,5,'2026-09-16','CONCLUIDA',0),
 (55,26,1,'2026-09-17','ABERTA',0),
 (56,33,2,'2026-09-18','CONCLUIDA',10),
 (57,40,3,'2026-09-19','CONCLUIDA',0),
 (58,47,4,'2026-09-20','CONCLUIDA',0),
 (59,54,5,'2026-09-21','CONCLUIDA',0),
 (60,1,1,'2026-09-22','CONCLUIDA',0),
 (61,8,2,'2026-09-23','CONCLUIDA',0),
 (62,15,3,'2026-09-24','CONCLUIDA',0),
 (63,22,4,'2026-09-25','CONCLUIDA',10),
 (64,29,5,'2026-09-26','CONCLUIDA',0),
 (65,36,1,'2026-09-27','CANCELADA',0),
 (66,43,2,'2026-09-28','ABERTA',0),
 (67,50,3,'2026-09-29','CONCLUIDA',0),
 (68,57,4,'2026-09-30','CONCLUIDA',0),
 (69,4,5,'2026-10-01','CONCLUIDA',0),
 (70,11,1,'2026-10-02','CONCLUIDA',10);

INSERT INTO venda (id_venda, id_cliente, id_funcionario, data_venda, status, desconto) VALUES
 (71,18,2,'2026-10-03','CONCLUIDA',0),
 (72,25,3,'2026-10-04','CONCLUIDA',0),
 (73,32,4,'2026-10-05','CONCLUIDA',0),
 (74,39,5,'2026-10-06','CONCLUIDA',0),
 (75,46,1,'2026-10-07','CONCLUIDA',0);

INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES
 (1,4,1,131),
 (1,13,1,333),
 (2,7,1,170),
 (2,16,1,98),
 (3,10,1,285),
 (3,19,1,113),
 (4,13,1,333),
 (4,1,2,92),
 (5,16,1,98),
 (5,4,1,131),
 (6,19,1,113),
 (6,7,1,170),
 (7,1,1,92),
 (7,10,1,285),
 (8,4,1,131),
 (8,13,2,333),
 (9,7,1,170),
 (9,16,1,98),
 (10,10,1,285),
 (10,19,1,113),
 (11,13,1,333),
 (11,1,1,92),
 (12,16,1,98),
 (12,4,2,131),
 (13,19,1,113),
 (13,7,1,170),
 (14,1,1,92),
 (14,10,1,285),
 (15,4,1,131),
 (15,13,1,333),
 (16,7,1,170),
 (16,16,2,98),
 (17,10,1,285),
 (17,19,1,113),
 (18,13,1,333),
 (18,1,1,92),
 (19,16,1,98),
 (19,4,1,131),
 (20,19,1,113),
 (20,7,2,170),
 (21,1,1,92),
 (21,10,1,285),
 (22,4,1,131),
 (22,13,1,333),
 (23,7,1,170),
 (23,16,1,98),
 (24,10,1,285),
 (24,19,2,113),
 (25,13,1,333),
 (25,1,1,92),
 (26,16,1,98),
 (26,4,1,131),
 (27,19,1,113),
 (27,7,1,170),
 (28,1,1,92),
 (28,10,2,285),
 (29,4,1,131),
 (29,13,1,333),
 (30,7,1,170),
 (30,16,1,98),
 (31,10,1,285),
 (31,19,1,113),
 (32,13,1,333),
 (32,1,2,92),
 (33,16,1,98),
 (33,4,1,131),
 (34,19,1,113),
 (34,7,1,170),
 (35,1,1,92),
 (35,10,1,285);

INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES
 (36,4,1,131),
 (36,13,2,333),
 (37,7,1,170),
 (37,16,1,98),
 (38,10,1,285),
 (38,19,1,113),
 (39,13,1,333),
 (39,1,1,92),
 (40,16,1,98),
 (40,4,2,131),
 (41,19,1,113),
 (41,7,1,170),
 (42,1,1,92),
 (42,10,1,285),
 (43,4,1,131),
 (43,13,1,333),
 (44,7,1,170),
 (44,16,2,98),
 (45,10,1,285),
 (45,19,1,113),
 (46,13,1,333),
 (46,1,1,92),
 (47,16,1,98),
 (47,4,1,131),
 (48,19,1,113),
 (48,7,2,170),
 (49,1,1,92),
 (49,10,1,285),
 (50,4,1,131),
 (50,13,1,333),
 (51,7,1,170),
 (51,16,1,98),
 (52,10,1,285),
 (52,19,2,113),
 (53,13,1,333),
 (53,1,1,92),
 (54,16,1,98),
 (54,4,1,131),
 (55,19,1,113),
 (55,7,1,170),
 (56,1,1,92),
 (56,10,2,285),
 (57,4,1,131),
 (57,13,1,333),
 (58,7,1,170),
 (58,16,1,98),
 (59,10,1,285),
 (59,19,1,113),
 (60,13,1,333),
 (60,1,2,92),
 (61,16,1,98),
 (61,4,1,131),
 (62,19,1,113),
 (62,7,1,170),
 (63,1,1,92),
 (63,10,1,285),
 (64,4,1,131),
 (64,13,2,333),
 (65,7,1,170),
 (65,16,1,98),
 (66,10,1,285),
 (66,19,1,113),
 (67,13,1,333),
 (67,1,1,92),
 (68,16,1,98),
 (68,4,2,131),
 (69,19,1,113),
 (69,7,1,170),
 (70,1,1,92),
 (70,10,1,285);

INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES
 (71,4,1,131),
 (71,13,1,333),
 (72,7,1,170),
 (72,16,2,98),
 (73,10,1,285),
 (73,19,1,113),
 (74,13,1,333),
 (74,1,1,92),
 (75,16,1,98),
 (75,4,1,131);

INSERT INTO pagamento (id_pagamento, id_venda, data_pagamento, forma, valor, status) VALUES
 (2,1,'2026-09-01','DINHEIRO',464,'CONFIRMADO'),
 (4,2,'2026-09-02','DEBITO',268,'CONFIRMADO'),
 (6,3,'2026-09-03','CREDITO',398,'CONFIRMADO'),
 (8,4,'2026-09-04','PIX',517,'CONFIRMADO'),
 (9,5,'2026-09-05','PIX',80.15,'CONFIRMADO'),
 (10,5,'2026-09-05','CREDITO',148.85,'CONFIRMADO'),
 (12,6,'2026-09-06','DEBITO',283,'CONFIRMADO'),
 (14,7,'2026-09-07','CREDITO',367,'CONFIRMADO'),
 (16,8,'2026-09-08','PIX',797,'CONFIRMADO'),
 (18,9,'2026-09-09','DINHEIRO',268,'CONFIRMADO'),
 (19,10,'2026-09-10','PIX',139.3,'CONFIRMADO'),
 (20,10,'2026-09-10','CREDITO',258.7,'CONFIRMADO'),
 (24,12,'2026-09-12','PIX',360,'CONFIRMADO'),
 (28,14,'2026-09-14','DEBITO',367,'CONFIRMADO'),
 (29,15,'2026-09-15','PIX',162.4,'CONFIRMADO'),
 (30,15,'2026-09-15','CREDITO',301.6,'CONFIRMADO'),
 (32,16,'2026-09-16','PIX',366,'CONFIRMADO'),
 (34,17,'2026-09-17','DINHEIRO',398,'CONFIRMADO'),
 (36,18,'2026-09-18','DEBITO',425,'CONFIRMADO'),
 (38,19,'2026-09-19','CREDITO',229,'CONFIRMADO'),
 (39,20,'2026-09-20','PIX',158.55,'CONFIRMADO'),
 (40,20,'2026-09-20','CREDITO',294.45,'CONFIRMADO'),
 (42,21,'2026-09-21','DINHEIRO',367,'CONFIRMADO'),
 (46,23,'2026-09-23','CREDITO',268,'CONFIRMADO'),
 (48,24,'2026-09-24','PIX',511,'CONFIRMADO'),
 (49,25,'2026-09-25','PIX',148.75,'CONFIRMADO'),
 (50,25,'2026-09-25','CREDITO',276.25,'CONFIRMADO'),
 (54,27,'2026-09-27','CREDITO',283,'CONFIRMADO'),
 (56,28,'2026-09-28','PIX',652,'CONFIRMADO'),
 (58,29,'2026-09-29','DINHEIRO',464,'CONFIRMADO'),
 (59,30,'2026-09-30','PIX',93.8,'CONFIRMADO'),
 (60,30,'2026-09-30','CREDITO',174.2,'CONFIRMADO'),
 (62,31,'2026-10-01','CREDITO',398,'CONFIRMADO'),
 (64,32,'2026-10-02','PIX',517,'CONFIRMADO'),
 (68,34,'2026-10-04','DEBITO',283,'CONFIRMADO'),
 (69,35,'2026-10-05','PIX',128.45,'CONFIRMADO'),
 (70,35,'2026-10-05','CREDITO',238.55,'CONFIRMADO'),
 (72,36,'2026-10-06','PIX',797,'CONFIRMADO'),
 (74,37,'2026-10-07','DINHEIRO',268,'CONFIRMADO'),
 (76,38,'2026-10-08','DEBITO',398,'CONFIRMADO'),
 (79,40,'2026-09-02','PIX',126.0,'CONFIRMADO'),
 (80,40,'2026-09-02','CREDITO',234.0,'CONFIRMADO'),
 (82,41,'2026-09-03','DINHEIRO',283,'CONFIRMADO'),
 (84,42,'2026-09-04','DEBITO',367,'CONFIRMADO'),
 (86,43,'2026-09-05','CREDITO',464,'CONFIRMADO'),
 (89,45,'2026-09-07','PIX',139.3,'CONFIRMADO'),
 (90,45,'2026-09-07','CREDITO',258.7,'CONFIRMADO'),
 (92,46,'2026-09-08','DEBITO',425,'CONFIRMADO'),
 (94,47,'2026-09-09','CREDITO',229,'CONFIRMADO'),
 (96,48,'2026-09-10','PIX',453,'CONFIRMADO'),
 (98,49,'2026-09-11','DINHEIRO',367,'CONFIRMADO'),
 (99,50,'2026-09-12','PIX',162.4,'CONFIRMADO'),
 (100,50,'2026-09-12','CREDITO',301.6,'CONFIRMADO'),
 (102,51,'2026-09-13','CREDITO',268,'CONFIRMADO'),
 (106,53,'2026-09-15','DINHEIRO',425,'CONFIRMADO'),
 (108,54,'2026-09-16','DEBITO',229,'CONFIRMADO'),
 (112,56,'2026-09-18','PIX',652,'CONFIRMADO'),
 (114,57,'2026-09-19','DINHEIRO',464,'CONFIRMADO'),
 (116,58,'2026-09-20','DEBITO',268,'CONFIRMADO'),
 (118,59,'2026-09-21','CREDITO',398,'CONFIRMADO'),
 (119,60,'2026-09-22','PIX',180.95,'CONFIRMADO'),
 (120,60,'2026-09-22','CREDITO',336.05,'CONFIRMADO'),
 (122,61,'2026-09-23','DINHEIRO',229,'CONFIRMADO'),
 (124,62,'2026-09-24','DEBITO',283,'CONFIRMADO'),
 (126,63,'2026-09-25','CREDITO',367,'CONFIRMADO'),
 (128,64,'2026-09-26','PIX',797,'CONFIRMADO'),
 (134,67,'2026-09-29','CREDITO',425,'CONFIRMADO'),
 (136,68,'2026-09-30','PIX',360,'CONFIRMADO'),
 (138,69,'2026-10-01','DINHEIRO',283,'CONFIRMADO'),
 (139,70,'2026-10-02','PIX',128.45,'CONFIRMADO');

INSERT INTO pagamento (id_pagamento, id_venda, data_pagamento, forma, valor, status) VALUES
 (140,70,'2026-10-02','CREDITO',238.55,'CONFIRMADO'),
 (142,71,'2026-10-03','CREDITO',464,'CONFIRMADO'),
 (144,72,'2026-10-04','PIX',366,'CONFIRMADO'),
 (146,73,'2026-10-05','DINHEIRO',398,'CONFIRMADO'),
 (148,74,'2026-10-06','DEBITO',425,'CONFIRMADO'),
 (149,75,'2026-10-07','PIX',80.15,'CONFIRMADO'),
 (150,75,'2026-10-07','CREDITO',148.85,'CONFIRMADO');

INSERT INTO movimentacao_estoque (id_movimentacao, id_produto, id_compra, id_venda, data_movimento, tipo, quantidade, observacao) VALUES
 (1,1,1,NULL,'2026-08-08','ENTRADA_COMPRA',46,NULL),
 (2,2,1,NULL,'2026-08-08','ENTRADA_COMPRA',47,NULL),
 (3,3,1,NULL,'2026-08-08','ENTRADA_COMPRA',48,NULL),
 (4,4,2,NULL,'2026-08-11','ENTRADA_COMPRA',47,NULL),
 (5,5,2,NULL,'2026-08-11','ENTRADA_COMPRA',48,NULL),
 (6,6,2,NULL,'2026-08-11','ENTRADA_COMPRA',49,NULL),
 (7,7,3,NULL,'2026-08-14','ENTRADA_COMPRA',48,NULL),
 (8,8,3,NULL,'2026-08-14','ENTRADA_COMPRA',49,NULL),
 (9,9,3,NULL,'2026-08-14','ENTRADA_COMPRA',50,NULL),
 (10,10,4,NULL,'2026-08-17','ENTRADA_COMPRA',49,NULL),
 (11,11,4,NULL,'2026-08-17','ENTRADA_COMPRA',50,NULL),
 (12,12,4,NULL,'2026-08-17','ENTRADA_COMPRA',51,NULL),
 (13,13,5,NULL,'2026-08-20','ENTRADA_COMPRA',50,NULL),
 (14,14,5,NULL,'2026-08-20','ENTRADA_COMPRA',51,NULL),
 (15,15,5,NULL,'2026-08-20','ENTRADA_COMPRA',52,NULL),
 (16,16,6,NULL,'2026-08-23','ENTRADA_COMPRA',51,NULL),
 (17,17,6,NULL,'2026-08-23','ENTRADA_COMPRA',52,NULL),
 (18,18,6,NULL,'2026-08-23','ENTRADA_COMPRA',53,NULL),
 (19,19,7,NULL,'2026-08-26','ENTRADA_COMPRA',52,NULL),
 (20,20,7,NULL,'2026-08-26','ENTRADA_COMPRA',53,NULL),
 (21,21,7,NULL,'2026-08-26','ENTRADA_COMPRA',45,NULL),
 (22,22,8,NULL,'2026-08-29','ENTRADA_COMPRA',53,NULL),
 (23,23,8,NULL,'2026-08-29','ENTRADA_COMPRA',45,NULL),
 (24,24,8,NULL,'2026-08-29','ENTRADA_COMPRA',46,NULL),
 (25,25,9,NULL,'2026-09-01','ENTRADA_COMPRA',45,NULL),
 (26,1,9,NULL,'2026-09-01','ENTRADA_COMPRA',46,NULL),
 (27,2,9,NULL,'2026-09-01','ENTRADA_COMPRA',47,NULL),
 (28,3,10,NULL,'2026-09-04','ENTRADA_COMPRA',46,NULL),
 (29,4,10,NULL,'2026-09-04','ENTRADA_COMPRA',47,NULL),
 (30,5,10,NULL,'2026-09-04','ENTRADA_COMPRA',48,NULL),
 (31,4,NULL,1,'2026-09-01','SAIDA_VENDA',1,NULL),
 (32,13,NULL,1,'2026-09-01','SAIDA_VENDA',1,NULL),
 (33,7,NULL,2,'2026-09-02','SAIDA_VENDA',1,NULL),
 (34,16,NULL,2,'2026-09-02','SAIDA_VENDA',1,NULL),
 (35,10,NULL,3,'2026-09-03','SAIDA_VENDA',1,NULL),
 (36,19,NULL,3,'2026-09-03','SAIDA_VENDA',1,NULL),
 (37,13,NULL,4,'2026-09-04','SAIDA_VENDA',1,NULL),
 (38,1,NULL,4,'2026-09-04','SAIDA_VENDA',2,NULL),
 (39,16,NULL,5,'2026-09-05','SAIDA_VENDA',1,NULL),
 (40,4,NULL,5,'2026-09-05','SAIDA_VENDA',1,NULL),
 (41,19,NULL,6,'2026-09-06','SAIDA_VENDA',1,NULL),
 (42,7,NULL,6,'2026-09-06','SAIDA_VENDA',1,NULL),
 (43,1,NULL,7,'2026-09-07','SAIDA_VENDA',1,NULL),
 (44,10,NULL,7,'2026-09-07','SAIDA_VENDA',1,NULL),
 (45,4,NULL,8,'2026-09-08','SAIDA_VENDA',1,NULL),
 (46,13,NULL,8,'2026-09-08','SAIDA_VENDA',2,NULL),
 (47,7,NULL,9,'2026-09-09','SAIDA_VENDA',1,NULL),
 (48,16,NULL,9,'2026-09-09','SAIDA_VENDA',1,NULL),
 (49,10,NULL,10,'2026-09-10','SAIDA_VENDA',1,NULL),
 (50,19,NULL,10,'2026-09-10','SAIDA_VENDA',1,NULL),
 (51,16,NULL,12,'2026-09-12','SAIDA_VENDA',1,NULL),
 (52,4,NULL,12,'2026-09-12','SAIDA_VENDA',2,NULL),
 (53,1,NULL,14,'2026-09-14','SAIDA_VENDA',1,NULL),
 (54,10,NULL,14,'2026-09-14','SAIDA_VENDA',1,NULL),
 (55,4,NULL,15,'2026-09-15','SAIDA_VENDA',1,NULL),
 (56,13,NULL,15,'2026-09-15','SAIDA_VENDA',1,NULL),
 (57,7,NULL,16,'2026-09-16','SAIDA_VENDA',1,NULL),
 (58,16,NULL,16,'2026-09-16','SAIDA_VENDA',2,NULL),
 (59,10,NULL,17,'2026-09-17','SAIDA_VENDA',1,NULL),
 (60,19,NULL,17,'2026-09-17','SAIDA_VENDA',1,NULL),
 (61,13,NULL,18,'2026-09-18','SAIDA_VENDA',1,NULL),
 (62,1,NULL,18,'2026-09-18','SAIDA_VENDA',1,NULL),
 (63,16,NULL,19,'2026-09-19','SAIDA_VENDA',1,NULL),
 (64,4,NULL,19,'2026-09-19','SAIDA_VENDA',1,NULL),
 (65,19,NULL,20,'2026-09-20','SAIDA_VENDA',1,NULL),
 (66,7,NULL,20,'2026-09-20','SAIDA_VENDA',2,NULL),
 (67,1,NULL,21,'2026-09-21','SAIDA_VENDA',1,NULL),
 (68,10,NULL,21,'2026-09-21','SAIDA_VENDA',1,NULL),
 (69,7,NULL,23,'2026-09-23','SAIDA_VENDA',1,NULL),
 (70,16,NULL,23,'2026-09-23','SAIDA_VENDA',1,NULL);

INSERT INTO movimentacao_estoque (id_movimentacao, id_produto, id_compra, id_venda, data_movimento, tipo, quantidade, observacao) VALUES
 (71,10,NULL,24,'2026-09-24','SAIDA_VENDA',1,NULL),
 (72,19,NULL,24,'2026-09-24','SAIDA_VENDA',2,NULL),
 (73,13,NULL,25,'2026-09-25','SAIDA_VENDA',1,NULL),
 (74,1,NULL,25,'2026-09-25','SAIDA_VENDA',1,NULL),
 (75,19,NULL,27,'2026-09-27','SAIDA_VENDA',1,NULL),
 (76,7,NULL,27,'2026-09-27','SAIDA_VENDA',1,NULL),
 (77,1,NULL,28,'2026-09-28','SAIDA_VENDA',1,NULL),
 (78,10,NULL,28,'2026-09-28','SAIDA_VENDA',2,NULL),
 (79,4,NULL,29,'2026-09-29','SAIDA_VENDA',1,NULL),
 (80,13,NULL,29,'2026-09-29','SAIDA_VENDA',1,NULL),
 (81,7,NULL,30,'2026-09-30','SAIDA_VENDA',1,NULL),
 (82,16,NULL,30,'2026-09-30','SAIDA_VENDA',1,NULL),
 (83,10,NULL,31,'2026-10-01','SAIDA_VENDA',1,NULL),
 (84,19,NULL,31,'2026-10-01','SAIDA_VENDA',1,NULL),
 (85,13,NULL,32,'2026-10-02','SAIDA_VENDA',1,NULL),
 (86,1,NULL,32,'2026-10-02','SAIDA_VENDA',2,NULL),
 (87,19,NULL,34,'2026-10-04','SAIDA_VENDA',1,NULL),
 (88,7,NULL,34,'2026-10-04','SAIDA_VENDA',1,NULL),
 (89,1,NULL,35,'2026-10-05','SAIDA_VENDA',1,NULL),
 (90,10,NULL,35,'2026-10-05','SAIDA_VENDA',1,NULL),
 (91,4,NULL,36,'2026-10-06','SAIDA_VENDA',1,NULL),
 (92,13,NULL,36,'2026-10-06','SAIDA_VENDA',2,NULL),
 (93,7,NULL,37,'2026-10-07','SAIDA_VENDA',1,NULL),
 (94,16,NULL,37,'2026-10-07','SAIDA_VENDA',1,NULL),
 (95,10,NULL,38,'2026-10-08','SAIDA_VENDA',1,NULL),
 (96,19,NULL,38,'2026-10-08','SAIDA_VENDA',1,NULL),
 (97,16,NULL,40,'2026-09-02','SAIDA_VENDA',1,NULL),
 (98,4,NULL,40,'2026-09-02','SAIDA_VENDA',2,NULL),
 (99,19,NULL,41,'2026-09-03','SAIDA_VENDA',1,NULL),
 (100,7,NULL,41,'2026-09-03','SAIDA_VENDA',1,NULL),
 (101,1,NULL,42,'2026-09-04','SAIDA_VENDA',1,NULL),
 (102,10,NULL,42,'2026-09-04','SAIDA_VENDA',1,NULL),
 (103,4,NULL,43,'2026-09-05','SAIDA_VENDA',1,NULL),
 (104,13,NULL,43,'2026-09-05','SAIDA_VENDA',1,NULL),
 (105,10,NULL,45,'2026-09-07','SAIDA_VENDA',1,NULL),
 (106,19,NULL,45,'2026-09-07','SAIDA_VENDA',1,NULL),
 (107,13,NULL,46,'2026-09-08','SAIDA_VENDA',1,NULL),
 (108,1,NULL,46,'2026-09-08','SAIDA_VENDA',1,NULL),
 (109,16,NULL,47,'2026-09-09','SAIDA_VENDA',1,NULL),
 (110,4,NULL,47,'2026-09-09','SAIDA_VENDA',1,NULL),
 (111,19,NULL,48,'2026-09-10','SAIDA_VENDA',1,NULL),
 (112,7,NULL,48,'2026-09-10','SAIDA_VENDA',2,NULL),
 (113,1,NULL,49,'2026-09-11','SAIDA_VENDA',1,NULL),
 (114,10,NULL,49,'2026-09-11','SAIDA_VENDA',1,NULL),
 (115,4,NULL,50,'2026-09-12','SAIDA_VENDA',1,NULL),
 (116,13,NULL,50,'2026-09-12','SAIDA_VENDA',1,NULL),
 (117,7,NULL,51,'2026-09-13','SAIDA_VENDA',1,NULL),
 (118,16,NULL,51,'2026-09-13','SAIDA_VENDA',1,NULL),
 (119,13,NULL,53,'2026-09-15','SAIDA_VENDA',1,NULL),
 (120,1,NULL,53,'2026-09-15','SAIDA_VENDA',1,NULL),
 (121,16,NULL,54,'2026-09-16','SAIDA_VENDA',1,NULL),
 (122,4,NULL,54,'2026-09-16','SAIDA_VENDA',1,NULL),
 (123,1,NULL,56,'2026-09-18','SAIDA_VENDA',1,NULL),
 (124,10,NULL,56,'2026-09-18','SAIDA_VENDA',2,NULL),
 (125,4,NULL,57,'2026-09-19','SAIDA_VENDA',1,NULL),
 (126,13,NULL,57,'2026-09-19','SAIDA_VENDA',1,NULL),
 (127,7,NULL,58,'2026-09-20','SAIDA_VENDA',1,NULL),
 (128,16,NULL,58,'2026-09-20','SAIDA_VENDA',1,NULL),
 (129,10,NULL,59,'2026-09-21','SAIDA_VENDA',1,NULL),
 (130,19,NULL,59,'2026-09-21','SAIDA_VENDA',1,NULL),
 (131,13,NULL,60,'2026-09-22','SAIDA_VENDA',1,NULL),
 (132,1,NULL,60,'2026-09-22','SAIDA_VENDA',2,NULL),
 (133,16,NULL,61,'2026-09-23','SAIDA_VENDA',1,NULL),
 (134,4,NULL,61,'2026-09-23','SAIDA_VENDA',1,NULL),
 (135,19,NULL,62,'2026-09-24','SAIDA_VENDA',1,NULL),
 (136,7,NULL,62,'2026-09-24','SAIDA_VENDA',1,NULL),
 (137,1,NULL,63,'2026-09-25','SAIDA_VENDA',1,NULL),
 (138,10,NULL,63,'2026-09-25','SAIDA_VENDA',1,NULL),
 (139,4,NULL,64,'2026-09-26','SAIDA_VENDA',1,NULL),
 (140,13,NULL,64,'2026-09-26','SAIDA_VENDA',2,NULL);

INSERT INTO movimentacao_estoque (id_movimentacao, id_produto, id_compra, id_venda, data_movimento, tipo, quantidade, observacao) VALUES
 (141,13,NULL,67,'2026-09-29','SAIDA_VENDA',1,NULL),
 (142,1,NULL,67,'2026-09-29','SAIDA_VENDA',1,NULL),
 (143,16,NULL,68,'2026-09-30','SAIDA_VENDA',1,NULL),
 (144,4,NULL,68,'2026-09-30','SAIDA_VENDA',2,NULL),
 (145,19,NULL,69,'2026-10-01','SAIDA_VENDA',1,NULL),
 (146,7,NULL,69,'2026-10-01','SAIDA_VENDA',1,NULL),
 (147,1,NULL,70,'2026-10-02','SAIDA_VENDA',1,NULL),
 (148,10,NULL,70,'2026-10-02','SAIDA_VENDA',1,NULL),
 (149,4,NULL,71,'2026-10-03','SAIDA_VENDA',1,NULL),
 (150,13,NULL,71,'2026-10-03','SAIDA_VENDA',1,NULL),
 (151,7,NULL,72,'2026-10-04','SAIDA_VENDA',1,NULL),
 (152,16,NULL,72,'2026-10-04','SAIDA_VENDA',2,NULL),
 (153,10,NULL,73,'2026-10-05','SAIDA_VENDA',1,NULL),
 (154,19,NULL,73,'2026-10-05','SAIDA_VENDA',1,NULL),
 (155,13,NULL,74,'2026-10-06','SAIDA_VENDA',1,NULL),
 (156,1,NULL,74,'2026-10-06','SAIDA_VENDA',1,NULL),
 (157,16,NULL,75,'2026-10-07','SAIDA_VENDA',1,NULL),
 (158,4,NULL,75,'2026-10-07','SAIDA_VENDA',1,NULL);

INSERT INTO ordem_montagem (id_ordem, id_venda, id_funcionario, data_abertura, data_prevista, data_conclusao, status, observacao) VALUES
 (1,1,4,'2026-09-01','2026-09-08',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (2,2,4,'2026-09-02','2026-09-09',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (3,3,4,'2026-09-03','2026-09-10',NULL,'EM_EXECUCAO','Montagem fictícia sem dados de saúde'),
 (4,4,4,'2026-09-04','2026-09-11','2026-09-09','CONCLUIDA','Montagem fictícia sem dados de saúde'),
 (5,5,4,'2026-09-05','2026-09-12',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (6,6,4,'2026-09-06','2026-09-13',NULL,'EM_EXECUCAO','Montagem fictícia sem dados de saúde'),
 (7,7,4,'2026-09-07','2026-09-14',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (8,8,4,'2026-09-08','2026-09-15','2026-09-13','CONCLUIDA','Montagem fictícia sem dados de saúde'),
 (9,9,4,'2026-09-09','2026-09-16',NULL,'EM_EXECUCAO','Montagem fictícia sem dados de saúde'),
 (10,10,4,'2026-09-10','2026-09-17',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (11,11,4,'2026-09-11','2026-09-18',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (12,12,4,'2026-09-12','2026-09-19','2026-09-17','CONCLUIDA','Montagem fictícia sem dados de saúde'),
 (13,14,4,'2026-09-14','2026-09-21',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (14,15,4,'2026-09-15','2026-09-22',NULL,'EM_EXECUCAO','Montagem fictícia sem dados de saúde'),
 (15,16,4,'2026-09-16','2026-09-23','2026-09-21','CONCLUIDA','Montagem fictícia sem dados de saúde'),
 (16,17,4,'2026-09-17','2026-09-24',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (17,18,4,'2026-09-18','2026-09-25',NULL,'EM_EXECUCAO','Montagem fictícia sem dados de saúde'),
 (18,19,4,'2026-09-19','2026-09-26',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (19,20,4,'2026-09-20','2026-09-27','2026-09-25','CONCLUIDA','Montagem fictícia sem dados de saúde'),
 (20,21,4,'2026-09-21','2026-09-28',NULL,'EM_EXECUCAO','Montagem fictícia sem dados de saúde'),
 (21,22,4,'2026-09-22','2026-09-29',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (22,23,4,'2026-09-23','2026-09-30',NULL,'PENDENTE','Montagem fictícia sem dados de saúde'),
 (23,24,4,'2026-09-24','2026-10-01','2026-09-29','CONCLUIDA','Montagem fictícia sem dados de saúde');

-- SELECT com JOIN demonstrativo antes de UPDATE/DELETE.
SELECT v.id_venda, c.nome AS cliente, f.nome AS responsavel
FROM venda v JOIN cliente c ON c.id_cliente=v.id_cliente
JOIN funcionario f ON f.id_funcionario=v.id_funcionario
ORDER BY v.id_venda LIMIT 5;

-- Demonstrações DML em transação revertida: não alteram o resultado da massa.
START TRANSACTION;
UPDATE produto SET preco_venda=preco_venda+1 WHERE id_produto=1;
INSERT INTO fornecedor(id_fornecedor,nome) VALUES (99,'Fornecedor temporário de teste');
DELETE FROM fornecedor WHERE id_fornecedor=99; -- seguro: não vinculado a compras
ROLLBACK;

-- G01 — Qual o faturamento realizado por mês? | Atende P1; KPI faturamento mensal.
SELECT DATE_FORMAT(v.data_venda,'%Y-%m') AS mes,
 ROUND(SUM(iv.quantidade*iv.preco_unitario) - SUM(v.desconto / NULLIF(t.qtd_itens,0)),2) AS receita_bruta_menos_descontos
FROM venda v JOIN item_venda iv ON iv.id_venda=v.id_venda
JOIN (SELECT id_venda,COUNT(*) qtd_itens FROM item_venda GROUP BY id_venda) t ON t.id_venda=v.id_venda
WHERE v.status='CONCLUIDA' GROUP BY DATE_FORMAT(v.data_venda,'%Y-%m') ORDER BY mes;

-- G02 — Qual é o ticket médio das vendas concluídas por mês? | Atende P1; KPI ticket médio.
SELECT DATE_FORMAT(v.data_venda,'%Y-%m') AS mes,
 ROUND(SUM(t.total-v.desconto)/COUNT(*),2) AS ticket_medio,
 COUNT(*) AS vendas_concluidas
FROM venda v JOIN (SELECT id_venda,SUM(quantidade*preco_unitario) total FROM item_venda GROUP BY id_venda) t ON t.id_venda=v.id_venda
WHERE v.status='CONCLUIDA' GROUP BY DATE_FORMAT(v.data_venda,'%Y-%m') ORDER BY mes;

-- G03 — Que produtos estão abaixo do estoque mínimo? | Atende P2; KPI quantidade abaixo do mínimo.
SELECT p.id_produto,p.sku,p.descricao,p.estoque_minimo,
 COALESCE(SUM(CASE WHEN m.tipo IN ('ENTRADA_COMPRA','AJUSTE_ENTRADA') THEN m.quantidade ELSE -m.quantidade END),0) AS estoque_atual
FROM produto p LEFT JOIN movimentacao_estoque m ON m.id_produto=p.id_produto
GROUP BY p.id_produto,p.sku,p.descricao,p.estoque_minimo
HAVING estoque_atual < p.estoque_minimo ORDER BY estoque_atual,p.sku;

-- G04 — Quais são os itens de maior giro nas vendas? | Atende P2; KPI unidades vendidas por produto.
SELECT p.sku,p.descricao,SUM(iv.quantidade) AS unidades_vendidas
FROM item_venda iv JOIN venda v ON v.id_venda=iv.id_venda
JOIN produto p ON p.id_produto=iv.id_produto
WHERE v.status='CONCLUIDA'
GROUP BY p.id_produto,p.sku,p.descricao ORDER BY unidades_vendidas DESC,p.sku LIMIT 10;

-- G05 — Quais compras recebidas foram feitas por fornecedor? | Atende P3; KPI compras recebidas.
SELECT f.nome AS fornecedor,COUNT(DISTINCT c.id_compra) AS compras_recebidas,
 ROUND(SUM(ic.quantidade*ic.custo_unitario),2) AS valor_comprado
FROM fornecedor f JOIN compra c ON c.id_fornecedor=f.id_fornecedor
JOIN item_compra ic ON ic.id_compra=c.id_compra WHERE c.status='RECEBIDA'
GROUP BY f.id_fornecedor,f.nome ORDER BY valor_comprado DESC;

-- G06 — Qual é o percentual de vendas canceladas por mês? | Atende P4; KPI taxa de cancelamento.
SELECT DATE_FORMAT(data_venda,'%Y-%m') AS mes, COUNT(*) AS total_vendas,
 SUM(CASE WHEN status='CANCELADA' THEN 1 ELSE 0 END) AS canceladas,
 ROUND(100.0*SUM(CASE WHEN status='CANCELADA' THEN 1 ELSE 0 END)/COUNT(*),2) AS taxa_cancelamento_pct
FROM venda GROUP BY DATE_FORMAT(data_venda,'%Y-%m') ORDER BY mes;

-- G07 — Quantas montagens estão atrasadas? | Atende P5; KPI ordens atrasadas.
SELECT COUNT(*) AS ordens_atrasadas FROM ordem_montagem
WHERE status IN ('PENDENTE','EM_EXECUCAO') AND data_prevista<CURDATE();

-- G08 — Qual o valor pago versus previsto de cada venda? | Atende P4; KPI conciliação financeira.
SELECT v.id_venda, v.status, ROUND(t.total-v.desconto,2) AS valor_previsto,
 COALESCE(pg.confirmado,0) AS valor_confirmado,
 ROUND(t.total-v.desconto-COALESCE(pg.confirmado,0),2) AS diferenca
FROM venda v JOIN (SELECT id_venda,SUM(quantidade*preco_unitario) total FROM item_venda GROUP BY id_venda) t ON t.id_venda=v.id_venda
LEFT JOIN (SELECT id_venda,SUM(CASE WHEN status='CONFIRMADO' THEN valor ELSE 0 END) confirmado FROM pagamento GROUP BY id_venda) pg ON pg.id_venda=v.id_venda
ORDER BY v.id_venda;

-- A01 — Há vendas concluídas sem item? | Verifica RN09.
SELECT v.id_venda FROM venda v LEFT JOIN item_venda iv ON iv.id_venda=v.id_venda
WHERE v.status='CONCLUIDA' GROUP BY v.id_venda HAVING COUNT(iv.id_produto)=0;

-- A02 — Há compras recebidas sem movimentos de estoque compatíveis? | Verifica RN10.
SELECT ic.id_compra,ic.id_produto,ic.quantidade AS quantidade_comprada,
 COALESCE(SUM(m.quantidade),0) AS entrada_registrada
FROM item_compra ic JOIN compra c ON c.id_compra=ic.id_compra
LEFT JOIN movimentacao_estoque m ON m.id_compra=ic.id_compra AND m.id_produto=ic.id_produto AND m.tipo='ENTRADA_COMPRA'
WHERE c.status='RECEBIDA' GROUP BY ic.id_compra,ic.id_produto,ic.quantidade
HAVING quantidade_comprada<>entrada_registrada;

-- A03 — Há vendas concluídas com saídas de estoque divergentes? | Verifica RN10.
SELECT iv.id_venda,iv.id_produto,iv.quantidade AS qtd_vendida, COALESCE(SUM(m.quantidade),0) AS qtd_saida
FROM item_venda iv JOIN venda v ON v.id_venda=iv.id_venda
LEFT JOIN movimentacao_estoque m ON m.id_venda=iv.id_venda AND m.id_produto=iv.id_produto AND m.tipo='SAIDA_VENDA'
WHERE v.status='CONCLUIDA' GROUP BY iv.id_venda,iv.id_produto,iv.quantidade HAVING qtd_vendida<>qtd_saida;

-- A04 — Há pagamentos de venda cancelada? | Verifica RN11.
SELECT v.id_venda,COUNT(*) AS pagamentos FROM venda v JOIN pagamento p ON p.id_venda=v.id_venda
WHERE v.status='CANCELADA' AND p.status='CONFIRMADO' GROUP BY v.id_venda;

-- A05 — Há ordem concluída sem data ou prazo cronologicamente inconsistente? | Verifica RN12.
SELECT id_ordem FROM ordem_montagem
WHERE (status='CONCLUIDA' AND data_conclusao IS NULL)
 OR data_prevista<data_abertura OR (data_conclusao IS NOT NULL AND data_conclusao<data_abertura);

-- A06 — O saldo de algum produto ficou negativo? | Verifica RN10.
SELECT p.id_produto,p.sku,
 COALESCE(SUM(CASE WHEN m.tipo IN ('ENTRADA_COMPRA','AJUSTE_ENTRADA') THEN m.quantidade ELSE -m.quantidade END),0) AS saldo
FROM produto p LEFT JOIN movimentacao_estoque m ON m.id_produto=p.id_produto
GROUP BY p.id_produto,p.sku HAVING saldo<0;
DROP DATABASE IF EXISTS hospedagem; 
CREATE DATABASE hospedagem;
USE hospedagem;

CREATE TABLE hospedes (
    id_hospede INT AUTO_INCREMENT UNIQUE,
    nome_hospede VARCHAR(40),
    rg VARCHAR(10),
    cpf VARCHAR(11) UNIQUE,
    data_nascimento DATE,
    sexo VARCHAR(20),
    celular VARCHAR(13),
    email VARCHAR(40),
    CEP VARCHAR(9),
    Estado VARCHAR(30),
    cidade VARCHAR(30),
    bairro VARCHAR(30),
    rua VARCHAR(50),
    complemento VARCHAR(50),
    observacoes VARCHAR(500),
    PRIMARY KEY (id_hospede)
);
INSERT INTO hospedes VALUES (1,'Maria Oliveira','1234567','98765432100','1990-06-25','Masculino','27999999999','MariaOliveira@gmail.com','29255-000','Espírito Santo (ES)','São Paulo','Bela Vista','Avenida Paulista','apartamento ','em frente a padaria'),
(2,'Carlos Pereira','1234567','11144477735','2000-06-25','Masculino','339985255655','CarlosPereira@gmail.com','25057-999','Mato Grosso (MT)','Belo Horizonte','Centro','Rua do Comércio','Comércio','.'),
(3,'Ney Schunk','1234567','14319902726','1992-05-28','Masculino','27998402372','NeySchunk@gmail.com','25555-000','Amazonas (AM)','Rio de Janeiro','Centro','das Acácias','casa amarela','proximo ao campo'),
(4,'Mateus Barbosa','1234567','12312312387','2000-06-22','Masculino','27998552626','MateusBarbosa@gmail.com','29255-666','Espírito Santo (ES)','Cariacica','porto Novo','Bela vista','Casa de dois adares','Em frente a padaria');

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT UNIQUE,
    nome_funcionario VARCHAR(40),
    rg VARCHAR(10),
    cpf VARCHAR(11) UNIQUE,
    data_nascimento DATE,
    sexo VARCHAR(20),
    celular VARCHAR(13),
    email VARCHAR(40),
    cep VARCHAR(9),
    Estado VARCHAR(50),
    cidade VARCHAR(50),
    bairro VARCHAR(50),
    rua VARCHAR(50),
    complemento VARCHAR(50),
    cargo VARCHAR(20),
    data_admissao DATE,
    data_emissao_carteira DATE,
    banco VARCHAR(40),
    agencia INTEGER,
    conta INTEGER,
    status_funcionario BOOLEAN,
    observacoes VARCHAR(500),
    PRIMARY KEY (id_funcionario)
);
INSERT INTO funcionarios VALUES (1,'Mateus Santana','1234567','12312312387','2000-12-22','Masculino','279696969696','MateusSantana@gmail.com','29256-000','Espírito Santo (ES)','Cariacica','Centro','Bela Vista','Casa Final da rua','Recepcionista','2024-06-19','2014-06-25','Brasil',1234,4321,1,'Ele é Sinistro'),
                                (2,'Valdineide Schunk','1234567','14319902726','1992-05-28','Masculino','27998402372','valdineideschunk@gmail.com','29255-000','Espírito Santo (ES)','Vitoria','Da Penha','Engenheiro Rubens Blei','Apartamento 101','Gerente','2024-06-19','2010-05-25','Santander',4321,1234,1,'Já merece aumento de salário.');

CREATE TABLE acomodacoes (
    id_acomodacao INT AUTO_INCREMENT UNIQUE,
    tipo_quarto VARCHAR(20),
    capacidade INTEGER,
    nome_acomodacao VARCHAR(40),
    comodidade_wifi BOOLEAN,
    comodidade_arcondicionado BOOLEAN,
    comodidade_tv BOOLEAN,
    comodidade_frigobar BOOLEAN,
    comodidade_acessibilidade BOOLEAN,
    descricao VARCHAR(40),
    bloqueio_acomodacao BOOLEAN,
    periodo_bloqueio_inicio DATE,
    periodo_bloqueio_fim DATE,
    motivo_bloqueio VARCHAR(200),
    status_quarto VARCHAR(20),
    PRIMARY KEY (id_acomodacao)
);
INSERT INTO acomodacoes VALUES (1,'Duplo',2,'ônibus',1,1,0,0,1,'ônibus amarelo',0,NULL,NULL,' ','Ocupado'),
							   (2,'Suite',4,'Cabana',1,1,0,0,0,'cabana por do sol',0,NULL,NULL,' ','Pronto p/ Limpeza'),
							   (3,'Triplo',3,'Cabana ',0,1,0,0,0,'caban nascer do sol',0,NULL,NULL,' ','Em Limpeza'),
							   (4,'Suite',5,'Chalé ',0,0,1,0,0,'Chalé familia',0,NULL,NULL,' ','Disponivel'),
							   (5,'Duplo',2,'Domo',0,0,1,0,0,'domo geodésico',0,NULL,NULL,' ','Reservado'),
							   (6,'Suite',5,'Suite',1,1,1,1,1,'Suite com cozinha',0,NULL,NULL,' ','Disponivel');

CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT UNIQUE,
    fk_hospede INT,
    fk_acomodacao INT,
    data_checkin DATE,
    data_checkout DATE,
    valor_diaria FLOAT,
    numero_adulto INTEGER,
    numero_crianca INTEGER,
    observacoes VARCHAR(200),
    status_reserva VARCHAR(40),
    data_criacao_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_hospede) REFERENCES hospedes(id_hospede),
    FOREIGN KEY (fk_acomodacao) REFERENCES acomodacoes(id_acomodacao)
);
INSERT INTO `reservas` VALUES (1,1,1,'2024-06-21','2024-06-26',1,2,0,' ','Hospedado','2024-06-19 13:39:33'),
							  (2,2,5,'2024-06-21','2024-06-22',100,2,0,' ','Reservado','2024-06-19 13:42:05'),
							  (3,3,2,'2024-06-21','2024-06-21',100,2,0,' ','Finalizada','2024-06-19 13:43:17'),
							  (4,3,3,'2024-06-21','2024-06-26',100,2,0,' ','Hospedado','2024-06-19 13:44:08');

CREATE VIEW view_informacoes_reserva AS
SELECT 
    r.id_reserva,
    r.fk_hospede,
    h.nome_hospede,
    h.cpf,
    r.data_criacao_reserva,
    r.data_checkin,
    r.data_checkout,
    r.valor_diaria,
    r.numero_adulto,
    r.numero_crianca,
    r.observacoes,
    r.status_reserva,
    r.fk_acomodacao,
    a.nome_acomodacao,
    a.tipo_quarto
FROM reservas r
INNER JOIN hospedes h ON r.fk_hospede = h.id_hospede
INNER JOIN acomodacoes a ON r.fk_acomodacao = a.id_acomodacao;

SELECT * FROM hospedes;
SELECT * FROM funcionarios;
SELECT * FROM acomodacoes;
SELECT * FROM reservas;
SELECT * FROM view_informacoes_reserva;





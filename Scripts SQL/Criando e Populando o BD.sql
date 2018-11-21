/* Lógico_1: */
drop schema trabalhobd;
create schema trabalhoBD;
use trabalhoBD;
CREATE TABLE Metro (
    inauguracao DATE NOT NULL,
    quantEstacoes INT NOT NULL DEFAULT 0,
    nome_empresa VARCHAR (50) NOT NULL,
    logo VARCHAR (100),
    ID INT PRIMARY KEY,
    passageiros INT
);

CREATE TABLE BRT (
    passageiros INT,
    quantEstacoes INT NOT NULL DEFAULT 0,
    nomeEmpresa VARCHAR(20) NOT NULL,
    tamanho INT NOT NULL DEFAULT 0,
    logo VARCHAR (100),
    ID INT PRIMARY KEY
);

CREATE TABLE Estacao_Metro (
    Bicicletario BOOLEAN NOT NULL DEFAULT FALSE,
    FlgAtm BOOLEAN NOT NULL DEFAULT FALSE,
    elevador BOOLEAN NOT NULL DEFAULT FALSE,
    IntegraOnibus BOOLEAN,
    IntegraBRT BOOLEAN,
    IntegraVLT BOOLEAN,
    id INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Status VARCHAR(20),
    Ativo BOOLEAN NOT NULL DEFAULT FALSE,
    IntegraTrem BOOLEAN,
    DataInauguracao INT NOT NULL,
    fk_empresa_metro_ID INT NOT NULL 
);

CREATE TABLE Estacao_BRT (
    integraMetro BOOLEAN,
    id INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Status VARCHAR(20),
    Ativo BOOLEAN NOT NULL,
    IntegraTrem BOOLEAN,
    integraAeroporto boolean,
    X DOUBLE NOT NULL,
    Y DOUBLE NOT NULL,
    fk_empresa_brt_ID int NOT NULL
);

CREATE TABLE Linha (
    ID INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    ShapeSTLength DOUBLE
);

CREATE TABLE Corredor (
    Corredor_PK INT NOT NULL,
    Corredor VARCHAR(50) NOT NULL,
    estacaoBRTID INT NOT NULL,
    PRIMARY KEY (Corredor_PK, estacaoBRTID)
);

CREATE TABLE Principal (
    fk_Estacao_Metro_id INT,
    fk_Linha_ID INT,
    Transporta INT,
    ano INT,
    PRIMARY KEY(ano, fk_Estacao_Metro_id, fk_Linha_ID)
);

CREATE TABLE EstacaoPossuiLinha (
	fk_estacao_metro INT,
    fk_Linha INT,
    PRIMARY KEY(fk_estacao_metro, fk_Linha)
);

ALTER TABLE Corredor ADD CONSTRAINT FK_Corredor_2
    FOREIGN KEY (estacaoBRTID)
    REFERENCES Estacao_BRT (id);
 
ALTER TABLE Principal ADD CONSTRAINT FK_principal_2
    FOREIGN KEY (fk_Estacao_Metro_id)
    REFERENCES Estacao_Metro (id)
    ON DELETE RESTRICT;
 
ALTER TABLE Principal ADD CONSTRAINT FK_principal_3
    FOREIGN KEY (fk_Linha_ID)
    REFERENCES Linha (ID)
    ON DELETE RESTRICT;

ALTER TABLE EstacaoPossuiLinha ADD CONSTRAINT FK_EstacaoPossuiLinha_1
	FOREIGN KEY (fk_estacao_metro)
    REFERENCES Estacao_Metro(id)
    ON DELETE RESTRICT;
    
ALTER TABLE EstacaoPossuiLinha ADD CONSTRAINT FK_EstacaoPossuiLinha_2
	FOREIGN KEY (fk_Linha)
    REFERENCES Linha(ID)
    ON DELETE RESTRICT;

alter table estacao_brt add constraint FK_estacao_brt_1
	foreign key (fk_empresa_brt_ID)
    references brt (ID);
    
alter table estacao_metro add constraint FK_estacao_metro_1
	foreign key (fk_empresa_metro_ID)
    references metro (ID);


/* adicionado por joyce */
DELIMITER $$ 
CREATE TRIGGER Tgr_Estacao_Metro_Insert AFTER INSERT ON estacao_metro
FOR EACH ROW BEGIN
UPDATE metro SET quantEstacoes = quantEstacoes  + 1 WHERE ID = NEW.fk_empresa_metro_ID;
END $$
CREATE TRIGGER Tgr_Estacao_Metro_Delete AFTER DELETE ON estacao_metro
FOR EACH ROW BEGIN
UPDATE metro SET quantEstacoes = quantEstacoes  - 1 WHERE ID = OLD.fk_empresa_metro_ID;
END $$
DELIMITER ; 
DELIMITER $$ 
CREATE TRIGGER Tgr_Estacao_Brt_Insert AFTER INSERT ON estacao_brt
FOR EACH ROW BEGIN
UPDATE brt SET quantEstacoes = quantEstacoes  + 1 WHERE ID = NEW.fk_empresa_brt_ID;
END $$
CREATE TRIGGER Tgr_Estacao_Brt_Delete AFTER DELETE ON estacao_brt
FOR EACH ROW BEGIN
UPDATE brt SET quantEstacoes = quantEstacoes  - 1 WHERE ID = OLD.fk_empresa_brt_ID;
END $$
DELIMITER ;

insert into brt values(450000,0,'consorcio BRT',125,'https://bit.ly/2DzQO0M',1);
/*apÃ³s fazer esse insert precisa adicionar a imagem ainda*/

insert into metro values(date("1979-03-01"), 0, 'Metro Rio', 'https://bit.ly/2TxqI4c', 1, 850000);

insert into estacao_metro values(1,true,1,0,0,0,1,'Pavuna',null,1,1,1998,1);
insert into estacao_metro values(1,1,1,0,0,0,2,'Engenheiro Rubens Paiva',null,1,0,1998,1);
insert into estacao_metro values(0,0,0,0,0,0,3,'Acari / Fazenda Botafogo',null,1,0,1998,1);
insert into estacao_metro values(0,1,0,0,0,0,4,'Coelho Neto',null,1,0,1998,1);
insert into estacao_metro values(1,1,0,0,0,0,5,'Colegio',null,1,0,1998,1);
insert into estacao_metro values(1,1,1,0,0,0,6,'Iraja',null,1,0,1998,1);
insert into estacao_metro values(1,1,0,0,1,0,7,'Vicente de Carvalho',null,1,0,1996,1);
insert into estacao_metro values(0,0,1,0,0,0,8,'Tomaz Coelho',null,1,0,1996,1);
insert into estacao_metro values(0,1,0,0,0,0,9,'Engenho da Rainha',null,1,0,1991,1);
insert into estacao_metro values(1,1,1,0,0,0,10,'Inhauma',null,1,0,1983,1);
insert into estacao_metro values(0,1,1,1,0,0,11,'Del Castilho',null,1,0,1983,1);
insert into estacao_metro values(0,1,0,0,0,0,12,'Maria da Graca',null,1,0,1983,1);
insert into estacao_metro values(1,1,0,0,0,0,13,'Triagem',null,1,1,1988,1);
insert into estacao_metro values(0,1,0,0,0,0,14,'Maracana',null,1,1,1981,1);
insert into estacao_metro values(0,1,0,0,0,0,15,'Sao Cristovao',null,1,1,1981,1);
insert into estacao_metro values(1,1,1,1,0,0,16,'Estacio',null,1,0,1980,1);
insert into estacao_metro values(0,1,1,1,0,0,17,'Saens Pena',null,1,0,1982,1);
insert into estacao_metro values(1,1,0,1,0,0,18,'Sao Francisco Xavier',null,1,0,1982,1);
insert into estacao_metro values(0,1,0,0,0,0,19,'Afonso Pena',null,1,0,1982,1);
insert into estacao_metro values(0,1,0,0,0,0,20,'Central',null,1,1,1979,1);
insert into estacao_metro values(0,1,0,0,0,0,21,'Presidente Vargas',null,1,0,1979,1);
insert into estacao_metro values(0,1,0,0,0,0,22,'Uruguaiana',null,1,0,1980,1);
insert into estacao_metro values(0,1,1,0,0,1,23,'Carioca',null,1,0,1981,1);
insert into estacao_metro values(0,1,0,0,0,1,24,'Cinelandia',null,1,0,1979,1);
insert into estacao_metro values(1,1,0,0,0,0,25,'Gloria',null,1,0,1979,1);
insert into estacao_metro values(1,1,0,0,0,0,26,'Catete',null,1,0,1981,1);
insert into estacao_metro values(0,1,1,1,0,0,27,'Largo do Machado',null,1,0,1981,1);
insert into estacao_metro values(0,1,1,0,0,0,28,'Flamengo',null,1,0,1981,1);
insert into estacao_metro values(0,1,1,1,0,0,29,'Botafogo',null,1,0,1981,1);
insert into estacao_metro values(0,1,0,0,0,0,30,'Cardeal Arcoverde',null,1,0,1998,1);
insert into estacao_metro values(1,1,0,0,0,0,31,'Siqueira Campos',null,1,0,2003,1);
insert into estacao_metro values(0,1,0,0,0,0,32,'Praca Onze',null,1,0,1979,1);
insert into estacao_metro values(1,1,1,0,0,0,33,'Cantagalo',null,1,0,2007,1);
insert into estacao_metro values(0,1,1,0,0,0,34,'Cidade Nova',null,1,0,2009,1);
insert into estacao_metro values(1,1,0,0,0,0,35,'Ipanema / General Osorio',null,1,0,2009,1);
insert into estacao_metro values(1,0,0,0,0,0,36,'Uruguai',null,1,0,2014,1);
insert into estacao_metro values(0,1,1,0,0,0,37,'Nossa Senhora da Paz',null,1,0,2016,1);
insert into estacao_metro values(0,1,1,0,0,0,38,'Jardim de Alah',null,1,0,2016,1);
insert into estacao_metro values(0,1,1,0,0,0,39,'Antero de Quental',null,1,0,2016,1);
insert into estacao_metro values(0,1,0,0,0,0,40,'Sao Conrado',null,1,0,2016,1);
insert into estacao_metro values(0,1,1,0,1,0,41,'Jardim Oceanico',null,1,0,2016,1);

insert into estacao_brt values(0,1,'Santa Luzia',1,1,0,0,679342.4694,7471499.5425,1);
insert into estacao_brt values(0,2,'Maré',1,1,0,0,680236.1565,7472379.5698,1);
insert into estacao_brt values(0,3,'Cardoso de Moraes - Viúva Garcia',1,1,0,0,678744056,7471252.0929,1);
insert into estacao_brt values(0,4,'Penha I',1,1,0,0,676833.5642,7473029.3037,1);
insert into estacao_brt values(0,5,'Penha II',1,1,0,0,676873.5062,7472976.5159,1);
insert into estacao_brt values(0,6,'Pastor José Santos',1,1,0,0,676190.5946,7473311.0143,1);
insert into estacao_brt values(0,7,'Guaporé',1,1,0,0,675532.0252,7473471.5235,1);
insert into estacao_brt values(0,8,'Praça do Carmo',1,1,0,0,674988.3298,7473355.5286,1);
insert into estacao_brt values(0,9,'Pedro Taques',1,1,0,0,674611.7594,7473064.8038,1);
insert into estacao_brt values(0,10,'Vila Kosmos - Nossa Senhora do Carmo',1,1,0,0,673654.1417,7472161.2863,1);
insert into estacao_brt values(1,11,'Vicente de Carvalho',1,1,0,0,673149.3342,7471836.7754,1);
insert into estacao_brt values(0,12,'Marambaia',1,1,0,0,672368.9065,7471812.6004,1);
insert into estacao_brt values(0,13,'Vaz Lobo',1,1,0,0,671548.7094,7471424.5497,1);
insert into estacao_brt values(0,14,'Vila Queiroz',1,1,0,0,671336.5613,7470886.1255,1);
insert into estacao_brt values(0,15,'Otaviano',1,1,0,0,670920.1446,7470408.1547,1);
insert into estacao_brt values(0,16,'Santa Efigênia',1,1,0,0,667002.8565,7462616.7949,1);
insert into estacao_brt values(0,17,'Divina Providência',1,1,0,0,666915.8421,7462170.4725,1);
insert into estacao_brt values(0,18,'Merck',1,1,0,0,667001.6034,746273.8861,1);
insert into estacao_brt values(0,19,'Terminal Bandeira Brasil',1,1,0,0,666803.5236,7464012.4314,1);
insert into estacao_brt values(0,20,'Tanque',1,1,0,0,668098.5115,746492.4017,1);
insert into estacao_brt values(0,21,'Madureira-Manaceia',1,1,1,0,670729.4584,7469130.0159,1);
insert into estacao_brt values(0,22,'Rio II',1,1,0,0,665676.8133,7458577.1701,1);
insert into estacao_brt values(0,23,'Pedro Correia',1,1,0,0,665031.6112,7459193.1928,1);
insert into estacao_brt values(0,24,'Hospital Sarah',1,1,0,0,666457.0827,7458550.0606,1);
insert into estacao_brt values(0,25,'Centro Metropolitano',1,1,0,0,667584.2118,745853.0243,1);
insert into estacao_brt values(0,26,'Curicica',1,1,0,0,665234.5159,7460056.1807,1);
insert into estacao_brt values(0,27,'Praça do Bandolim',1,1,0,0,665786.4723,7460195.8042,1);
insert into estacao_brt values(0,28,'Arroio Pavuna',1,1,0,0,666408.4262,746055.6412,1);
insert into estacao_brt values(0,29,'Vila Sapê - IV Centenário',1,1,0,0,666690.3031,7460880.3159,1);
insert into estacao_brt values(0,30,'Recanto das Palmeiras - Jardim São Luiz',1,1,0,0,666923.8079,7461334.6512,1);
insert into estacao_brt values(0,31,'Andre Rocha',1,1,0,0,666845.2945,7463418.5011,1);
insert into estacao_brt values(0,32,'Taquara',1,1,0,0,666804.0446,7464001.1081,1);
insert into estacao_brt values(0,33,'Aracy Cabral',1,1,0,0,667381.3771,7464439.0353,1);
insert into estacao_brt values(0,34,'Terminal Mestre Candeia',1,1,0,0,668106756,7464937.0167,1);
insert into estacao_brt values(0,35,'Ipase',1,1,0,0,668550.6613,7466132.3282,1);
insert into estacao_brt values(0,36,'Praça Seca',1,1,0,0,669052.2098,746690.2913,1);
insert into estacao_brt values(0,37,'Capitão Menezes',1,1,0,0,669428.8869,7467443.1399,1);
insert into estacao_brt values(0,38,'Pinto Teles',1,1,0,0,669720.4656,7467929.1109,1);
insert into estacao_brt values(0,39,'Apóstolo Samuel Joaquim',1,1,0,0,670129928,7468602.2304,1);
insert into estacao_brt values(0,40,'Terminal Paulo da Portela',1,1,0,0,670721.7874,7469116.8522,1);
insert into estacao_brt values(0,41,'Mercadão',1,1,0,0,670776.9484,7469876.8256,1);
insert into estacao_brt values(0,42,'Ibiapina',1,1,1,0,677308.3931,747293.7286,1);
insert into estacao_brt values(0,43,'Olaria - Cacique de Ramos',1,1,0,0,678018.4898,7472237.6761,1);
insert into estacao_brt values(0,44,'Terminal Fundão - Aroldo Melodia',1,1,0,0,680639.5657,7473179.8781,1);
insert into estacao_brt values(0,45,'Via Parque',1,1,0,0,667570.5911,7457367.1485,1);
insert into estacao_brt values(0,46,'Aeroporto de Jacarepaguá',1,1,0,0,667550791,7456808.7301,1);
insert into estacao_brt values(0,47,'Lourenço Jorge',1,1,0,0,667535.8977,7456079.0799,1);
insert into estacao_brt values(0,48,'Tom Jobim 1',1,1,0,1,679502.5562,7476357.8081,1);
insert into estacao_brt values(0,49,'Tom Jobim 2',1,1,0,1,680019.0118,7475997.8294,1);
insert into estacao_brt values(0,50,'Terminal Alvorada',1,1,0,0,667503.4512,745554.6597,1);
insert into estacao_brt values(0,51,'Cesarão II',1,1,0,0,637247.0653,7463270.6287,1);
insert into estacao_brt values(0,52,'Cesarão III',1,1,0,0,637727.3478,7463455.2311,1);
insert into estacao_brt values(0,53,'Vila Paciência',1,1,0,0,638087.5565,7463822.5644,1);
insert into estacao_brt values(0,54,'Três Pontes',1,1,0,0,638483.8907,7464145.4011,1);
insert into estacao_brt values(0,55,'Cesarinho',1,1,0,0,639148985,7464691.2346,1);
insert into estacao_brt values(0,56,'31 de Outubro',1,1,0,0,639611.5726,7464933.1322,1);
insert into estacao_brt values(0,57,'Santa Eugênia',1,1,1,0,640254.7159,7465085.2967,1);
insert into estacao_brt values(0,58,'Júlia Miguel',1,1,0,0,640750.2068,7465210.6361,1);
insert into estacao_brt values(0,59,'Parque São Paulo',1,1,0,0,641323.1236,746513.4089,1);
insert into estacao_brt values(0,60,'Icurana',1,1,0,0,643020.1764,746524.4565,1);
insert into estacao_brt values(0,61,'Vilar Carioca',1,1,0,0,643487.5501,7465342.6929,1);
insert into estacao_brt values(0,62,'Inhoaíba',1,1,0,0,644070.3965,7465434.8176,1);
insert into estacao_brt values(0,63,'Golfe Olímpico',1,1,0,0,662778.8355,7455640.2223,1);
insert into estacao_brt values(0,65,'Ana Gonzaga',1,1,0,0,644674.4701,746564.8462,1);
insert into estacao_brt values(0,66,'São Jorge',1,1,0,0,645246.0738,7465696.3482,1);
insert into estacao_brt values(0,67,'Pina Rangel',1,1,0,0,646112.0026,7466058.5567,1);
insert into estacao_brt values(0,68,'Parque Esperança',1,1,0,0,646536.0498,7466121.1072,1);
insert into estacao_brt values(0,69,'Cândido Magalhães',1,1,0,0,647320.7627,7466032.7958,1);
insert into estacao_brt values(0,70,'Prefeito Alim Pedro',1,1,0,0,647092.9889,7466475.8203,1);
insert into estacao_brt values(0,71,'Gramado',1,1,0,0,647090.1188,7466479.2758,1);
insert into estacao_brt values(0,72,'Santa Verediana',1,1,0,0,636906.7966,7462492.2484,1);
insert into estacao_brt values(0,73,'Gastão Rangel',1,1,0,0,635650.9103,7463935.1495,1);
insert into estacao_brt values(0,74,'Terminal Santa Cruz',1,1,1,0,635035.0111,7465122.3778,1);
insert into estacao_brt values(0,75,'Parque das Rosas',1,1,0,0,668885.3293,7455567.1627,1);
insert into estacao_brt values(0,76,'Cesarão',1,1,0,0,636897.9821,7463146.7256,1);
insert into estacao_brt values(0,77,'Cosmos',1,1,0,0,641970041,7465194.0494,1);
insert into estacao_brt values(0,78,'Recanto das Garças',1,1,0,0,654096.8985,7453408.3407,1);
insert into estacao_brt values(0,79,'Dom Bosco',1,1,0,0,652836.9668,7453729.2847,1);
insert into estacao_brt values(0,80,'CTEx',1,1,0,0,647781.8001,7455219.5104,1);
insert into estacao_brt values(0,81,'Embrapa',1,1,0,0,645326.8216,7455873.6957,1);
insert into estacao_brt values(0,82,'Terminal Campo Grande',1,1,1,0,648252.6075,7466671.6633,1);
insert into estacao_brt values(0,83,'Nova Barra',1,1,0,0,656686.9454,745398.1534,1);
insert into estacao_brt values(0,84,'Vendas de Varanda',1,1,0,0,638370.15,7461329.0543,1);
insert into estacao_brt values(0,85,'Curral Falso',1,1,0,0,636730.4909,7462930.6497,1);
insert into estacao_brt values(0,86,'Cajueiros',1,1,0,0,636064.6766,7463566.9326,1);
insert into estacao_brt values(1,87,'Terminal Jd. Oceânico',1,1,0,0,673068.8522,7454778.4795,1);
insert into estacao_brt values(0,88,'Cittá América',1,1,0,0,671889.6407,7455143.5403,1);
insert into estacao_brt values(0,89,'Porto dos Cabritos',1,1,0,0,671289.3165,7455405.8147,1);
insert into estacao_brt values(0,90,'Freeway',1,1,0,0,670638.4666,7455495.8297,1);
insert into estacao_brt values(0,91,'Riviera',1,1,0,0,669982.4992,7455534.7983,1);
insert into estacao_brt values(0,92,'Ricardo Marinho',1,1,0,0,669518.3111,7455550.5184,1);
insert into estacao_brt values(0,93,'Barra Shopping',1,1,0,0,668060.9803,7455587.6412,1);
insert into estacao_brt values(0,94,'Bosque da Barra',1,1,0,0,666341.5087,7455570.5399,1);
insert into estacao_brt values(0,95,'Novo Leblon',1,1,0,0,665752.0627,7455566.2133,1);
insert into estacao_brt values(0,96,'Américas Park',1,1,0,0,665076.2154,7455572.6405,1);
insert into estacao_brt values(0,97,'Santa Mônica Jardins',1,1,0,0,664184.5856,7455605.0165,1);
insert into estacao_brt values(0,98,'Rio Mar',1,1,0,0,663322.7851,7455644.8619,1);
insert into estacao_brt values(0,99,'Interlagos',1,1,0,0,662238.4136,7455553.2912,1);
insert into estacao_brt values(0,100,'Pedra de Itaúna',1,1,0,0,661562.4112,7455334.9587,1);
insert into estacao_brt values(0,101,'Pontões/Barrasul',1,1,0,0,660748.8158,7455058.1378,1);
insert into estacao_brt values(0,102,'Salvador Allende',1,1,0,0,659643.7292,7454761.1583,1);
insert into estacao_brt values(0,103,'Gelson Fonseca',1,1,0,0,659031.5398,7454602.0193,1);
insert into estacao_brt values(0,104,'Guignard',1,1,0,0,658619.2781,7454495.6601,1);
insert into estacao_brt values(0,105,'Gláucio Gil',1,1,0,0,657971.6558,7454319.7988,1);
insert into estacao_brt values(0,106,'Benvindo de Novaes',1,1,0,0,657177.8991,7454112.5103,1);
insert into estacao_brt values(0,107,'Gilka Machado',1,1,0,0,656110.2474,7453827.0712,1);
insert into estacao_brt values(0,108,'Guiomar Novais',1,1,0,0,655541.2472,745368.0004,1);
insert into estacao_brt values(0,109,'Recreio Shopping ',1,1,0,0,655060.4679,745355.1521,1);
insert into estacao_brt values(0,110,'Notre Dame',1,1,0,0,653727.9158,7453457.8898,1);
insert into estacao_brt values(0,111,'Pontal',1,1,0,0,652118.4719,7453953.3278,1);
insert into estacao_brt values(0,112,'Ilha de Guaratiba',1,1,0,0,649680.9819,7454736.7711,1);
insert into estacao_brt values(0,113,'Mato Alto',1,1,0,0,643868.3822,7456519.7944,1);
insert into estacao_brt values(0,114,'Magarça',1,1,0,0,641302.2234,745933.4162,1);
insert into estacao_brt values(0,115,'Pingo DÁgua',1,1,0,0,638715.5649,7459777.6324,1);
insert into estacao_brt values(0,116,'General Olímpo',1,1,0,0,635441.9484,7464526.4505,1);
insert into estacao_brt values(0,117,'Terminal Deodoro',1,1,1,0,665843.4234,747178.7908,1);
insert into estacao_brt values(null,118,'Carrefour',0,0,null,0,666558.5458,7472762.9123,1);
insert into estacao_brt values(null,119,'Barros Filho',0,0,null,0,667436.8306,7473337.1264,1);
insert into estacao_brt values(null,120,'Coelho Neto',0,0,null,0,669277.6591,7474284.4756,1);
insert into estacao_brt values(null,121,'Irajá',0,0,null,0,671617.1874,7475162.2992,1);
insert into estacao_brt values(null,122,'Correia Andrade',0,0,null,0,673650.1937,7475658.3968,1);
insert into estacao_brt values(null,123,'Ponto Chique',0,0,null,0,675299.3735,7476000.6733,1);
insert into estacao_brt values(null,124,'Terminal Margaridas',0,0,null,0,672129.0956,7475458.0375,1);
insert into estacao_brt values(null,125,'Terminal Missões',0,0,null,0,675515.4976,7476115.9835,1);
insert into estacao_brt values(null,126,'Brás de Pina',0,0,null,0,676152.2776,7475477.6188,1);
insert into estacao_brt values(null,127,'Marinha do Brasil',0,0,null,0,677394.4266,7474403.9889,1);
insert into estacao_brt values(null,128,'Marinha Mercante',0,0,null,0,678789.9309,747352.1051,1);
insert into estacao_brt values(null,129,'Piscinão de Ramos',0,0,null,0,679508147,7472846.4986,1);
insert into estacao_brt values(null,130,'Rubens Vaz',0,0,null,0,679842.4079,747171.9637,1);
insert into estacao_brt values(null,131,'Nova Holanda',0,0,null,0,679813587,7470847.0187,1);
insert into estacao_brt values(null,132,'Joana Nascimento',0,0,null,0,679822.3207,7470221.6801,1);
insert into estacao_brt values(null,133,'Fiocruz',0,0,null,0,680286.4669,746925.1946,1);
insert into estacao_brt values(null,134,'Parque Vitória',0,0,null,0,680969541,7468263.7505,1);
insert into estacao_brt values(null,135,'São Francisco',0,0,null,0,682168254,7467952.7684,1);
insert into estacao_brt values(null,136,'Caju',0,0,null,0,682570.5248,7467664.0082,1);
insert into estacao_brt values(null,137,'I.N.T.O',0,0,null,0,683094.7585,7467130.1047,1);
insert into estacao_brt values(null,138,'Terminal Rodoviária',0,0,null,0,683615824,7466528.7997,1);
insert into estacao_brt values(null,139,'TerminalAmérico Fontenelle',0,0,null,0,685412.4392,7466224.0723,1);
insert into estacao_brt values(null,140,'Cidade Nova',0,0,null,0,684259.1471,7465425.4939,1);
insert into estacao_brt values(null,141,'Sambódromo',0,0,null,0,684862.0985,7465643.4965,1);
insert into estacao_brt values(null,142,'Terminal Presidente Vargas',0,0,null,0,686559.3857,7466207.1893,1);
insert into estacao_brt values(0,143,'Terminal Salvador Allende',1,1,0,0,659823.2512,7454725.5556,1);
insert into estacao_brt values(0,144,'Viva Viver',1,1,0,0,660533.0373,7455240.0876,1);
insert into estacao_brt values(0,145,'Tapebuias',1,1,0,0,661060.2058,7455719.8117,1);
insert into estacao_brt values(0,146,'CNEN',1,1,0,0,662080.1531,7456681.4702,1);
insert into estacao_brt values(0,147,'Olof Palme',1,1,0,0,663014678,7457650.3157,1);
insert into estacao_brt values(0,148,'Riocentro',1,1,0,0,663349.7739,7458125.8697,1);
insert into estacao_brt values(0,149,'Morro do Outeiro',1,1,0,0,663851.6557,7458715.8063,1);
insert into estacao_brt values(0,150,'Terminal Centro Olímpico',1,1,0,0,663896.3756,7458667.0087,1);
insert into estacao_brt values(0,151,'Minha Praia',1,1,0,0,664387.3508,7459316.0632,1);
insert into estacao_brt values(0,152,'Bandeirantes',1,1,0,0,664727006,7459709.5008,1);
insert into estacao_brt values(0,153,'Hospital Raphael de P. S.',1,1,0,0,664944.18,746056.5029,1);
insert into estacao_brt values(0,154,'Curicica',1,1,0,0,664944.9274,746137.5618,1);
insert into estacao_brt values(0,155,'Colonia',1,1,0,0,664648.2995,7462372.2026,1);
insert into estacao_brt values(0,156,'Outeiro Santo',1,1,0,0,664551.8682,7463557.8539,1);
insert into estacao_brt values(0,157,'Boiúna',1,1,0,0,664373.5388,7464876.1409,1);
insert into estacao_brt values(0,158,'Marechal Fontenelle',1,1,0,0,664095.9896,7468251.3602,1);
insert into estacao_brt values(0,159,'Marechal Mallet',1,1,0,0,663615.1812,7469374.1856,1);
insert into estacao_brt values(0,160,'Magalhães Bastos',1,1,0,0,662717.0295,747017.7697,1);
insert into estacao_brt values(0,161,'Vila Militar',1,1,1,0,664022.2312,7470840.7974,1);
insert into estacao_brt values(0,163,'Terminal Sulacap',1,1,0,0,664220.4598,7468441.5413,1);

insert into linha values(1,'Linha 1',17377.6491454839);
insert into linha values(2,'Linha 2',31438.0090390294);
insert into linha values(3,'Linha 4',12129.1343418009);

insert into corredor values(1,'TransCarioca',1);
insert into corredor values(1,'TransCarioca',2);
insert into corredor values(1,'TransCarioca',3);
insert into corredor values(1,'TransCarioca',4);
insert into corredor values(1,'TransCarioca',5);
insert into corredor values(1,'TransCarioca',6);
insert into corredor values(1,'TransCarioca',7);
insert into corredor values(1,'TransCarioca',8);
insert into corredor values(1,'TransCarioca',9);
insert into corredor values(1,'TransCarioca',10);
insert into corredor values(1,'TransCarioca',11);
insert into corredor values(1,'TransCarioca',12);
insert into corredor values(1,'TransCarioca',13);
insert into corredor values(1,'TransCarioca',14);
insert into corredor values(1,'TransCarioca',15);
insert into corredor values(1,'TransCarioca',16);
insert into corredor values(1,'TransCarioca',17);
insert into corredor values(1,'TransCarioca',18);
insert into corredor values(1,'TransCarioca',19);
insert into corredor values(1,'TransCarioca',20);
insert into corredor values(1,'TransCarioca',21);
insert into corredor values(1,'TransCarioca',22);
insert into corredor values(1,'TransCarioca',23);
insert into corredor values(1,'TransCarioca',24);
insert into corredor values(1,'TransCarioca',25);
insert into corredor values(1,'TransCarioca',26);
insert into corredor values(1,'TransCarioca',27);
insert into corredor values(1,'TransCarioca',28);
insert into corredor values(1,'TransCarioca',29);
insert into corredor values(1,'TransCarioca',30);
insert into corredor values(1,'TransCarioca',31);
insert into corredor values(1,'TransCarioca',32);
insert into corredor values(1,'TransCarioca',33);
insert into corredor values(1,'TransCarioca',34);
insert into corredor values(1,'TransCarioca',35);
insert into corredor values(1,'TransCarioca',36);
insert into corredor values(1,'TransCarioca',37);
insert into corredor values(1,'TransCarioca',38);
insert into corredor values(1,'TransCarioca',39);
insert into corredor values(1,'TransCarioca',40);
insert into corredor values(1,'TransCarioca',41);
insert into corredor values(1,'TransCarioca',42);
insert into corredor values(1,'TransCarioca',43);
insert into corredor values(1,'TransCarioca',44);
insert into corredor values(1,'TransCarioca',45);
insert into corredor values(1,'TransCarioca',46);
insert into corredor values(1,'TransCarioca',47);
insert into corredor values(1,'TransCarioca',48);
insert into corredor values(1,'TransCarioca',49);
insert into corredor values(1,'TransCarioca',50);
insert into corredor values(2,'TransBrasil',117);
insert into corredor values(2,'TransBrasil',118);
insert into corredor values(2,'TransBrasil',119);
insert into corredor values(2,'TransBrasil',120);
insert into corredor values(2,'TransBrasil',121);
insert into corredor values(2,'TransBrasil',122);
insert into corredor values(2,'TransBrasil',123);
insert into corredor values(2,'TransBrasil',124);
insert into corredor values(2,'TransBrasil',125);
insert into corredor values(2,'TransBrasil',126);
insert into corredor values(2,'TransBrasil',127);
insert into corredor values(2,'TransBrasil',128);
insert into corredor values(2,'TransBrasil',129);
insert into corredor values(2,'TransBrasil',130);
insert into corredor values(2,'TransBrasil',131);
insert into corredor values(2,'TransBrasil',132);
insert into corredor values(2,'TransBrasil',133);
insert into corredor values(2,'TransBrasil',134);
insert into corredor values(2,'TransBrasil',135);
insert into corredor values(2,'TransBrasil',136);
insert into corredor values(2,'TransBrasil',137);
insert into corredor values(2,'TransBrasil',138);
insert into corredor values(2,'TransBrasil',139);
insert into corredor values(2,'TransBrasil',140);
insert into corredor values(2,'TransBrasil',141);
insert into corredor values(2,'TransBrasil',142);
insert into corredor values(3,'TransOeste',50);
insert into corredor values(3,'TransOeste',51);
insert into corredor values(3,'TransOeste',52);
insert into corredor values(3,'TransOeste',53);
insert into corredor values(3,'TransOeste',54);
insert into corredor values(3,'TransOeste',55);
insert into corredor values(3,'TransOeste',56);
insert into corredor values(3,'TransOeste',57);
insert into corredor values(3,'TransOeste',58);
insert into corredor values(3,'TransOeste',59);
insert into corredor values(3,'TransOeste',60);
insert into corredor values(3,'TransOeste',61);
insert into corredor values(3,'TransOeste',62);
insert into corredor values(3,'TransOeste',63);
insert into corredor values(3,'TransOeste',65);
insert into corredor values(3,'TransOeste',66);
insert into corredor values(3,'TransOeste',67);
insert into corredor values(3,'TransOeste',68);
insert into corredor values(3,'TransOeste',69);
insert into corredor values(3,'TransOeste',70);
insert into corredor values(3,'TransOeste',71);
insert into corredor values(3,'TransOeste',72);
insert into corredor values(3,'TransOeste',73);
insert into corredor values(3,'TransOeste',74);
insert into corredor values(3,'TransOeste',75);
insert into corredor values(3,'TransOeste',76);
insert into corredor values(3,'TransOeste',77);
insert into corredor values(3,'TransOeste',78);
insert into corredor values(3,'TransOeste',79);
insert into corredor values(3,'TransOeste',80);
insert into corredor values(3,'TransOeste',81);
insert into corredor values(3,'TransOeste',82);
insert into corredor values(3,'TransOeste',83);
insert into corredor values(3,'TransOeste',84);
insert into corredor values(3,'TransOeste',85);
insert into corredor values(3,'TransOeste',86);
insert into corredor values(3,'TransOeste',87);
insert into corredor values(3,'TransOeste',88);
insert into corredor values(3,'TransOeste',89);
insert into corredor values(3,'TransOeste',90);
insert into corredor values(3,'TransOeste',91);
insert into corredor values(3,'TransOeste',92);
insert into corredor values(3,'TransOeste',93);
insert into corredor values(3,'TransOeste',94);
insert into corredor values(3,'TransOeste',95);
insert into corredor values(3,'TransOeste',96);
insert into corredor values(3,'TransOeste',97);
insert into corredor values(3,'TransOeste',98);
insert into corredor values(3,'TransOeste',99);
insert into corredor values(3,'TransOeste',100);
insert into corredor values(3,'TransOeste',101);
insert into corredor values(3,'TransOeste',102);
insert into corredor values(3,'TransOeste',103);
insert into corredor values(3,'TransOeste',104);
insert into corredor values(3,'TransOeste',105);
insert into corredor values(3,'TransOeste',106);
insert into corredor values(3,'TransOeste',107);
insert into corredor values(3,'TransOeste',108);
insert into corredor values(3,'TransOeste',109);
insert into corredor values(3,'TransOeste',110);
insert into corredor values(3,'TransOeste',111);
insert into corredor values(3,'TransOeste',112);
insert into corredor values(3,'TransOeste',113);
insert into corredor values(3,'TransOeste',114);
insert into corredor values(3,'TransOeste',115);
insert into corredor values(3,'TransOeste',116);
insert into corredor values(4,'TransOlimpica',117);
insert into corredor values(4,'TransOlimpica',143);
insert into corredor values(4,'TransOlimpica',144);
insert into corredor values(4,'TransOlimpica',145);
insert into corredor values(4,'TransOlimpica',146);
insert into corredor values(4,'TransOlimpica',147);
insert into corredor values(4,'TransOlimpica',148);
insert into corredor values(4,'TransOlimpica',149);
insert into corredor values(4,'TransOlimpica',150);
insert into corredor values(4,'TransOlimpica',151);
insert into corredor values(4,'TransOlimpica',152);
insert into corredor values(4,'TransOlimpica',153);
insert into corredor values(4,'TransOlimpica',154);
insert into corredor values(4,'TransOlimpica',155);
insert into corredor values(4,'TransOlimpica',156);
insert into corredor values(4,'TransOlimpica',157);
insert into corredor values(4,'TransOlimpica',158);
insert into corredor values(4,'TransOlimpica',159);
insert into corredor values(4,'TransOlimpica',160);
insert into corredor values(4,'TransOlimpica',161);
insert into corredor values(4,'TransOlimpica',163);

insert into Principal values(19,1,2796,1995);	insert into Principal values(19,1,3039.249,1996);	insert into Principal values(19,1,2234.187,1997);	insert into Principal values(19,1,2621.218,1998);	insert into Principal values(19,1,2893.83,1999);	insert into Principal values(19,1,3051.289,2000);	insert into Principal values(19,1,2961.188,2001);	insert into Principal values(19,1,2942,2002);	insert into Principal values(19,1,2895.864,2003);	insert into Principal values(19,1,2952.068,2004);	insert into Principal values(19,1,2926.316,2005);	insert into Principal values(19,1,2950.81,2006);	insert into Principal values(19,1,3117,2007);	insert into Principal values(19,1,3059.643,2008);	insert into Principal values(19,1,2959.363,2009);	insert into Principal values(19,1,2805.271,2010);	insert into Principal values(19,1,2956.958,2011);	insert into Principal values(19,1,3031.121,2012);	insert into Principal values(19,1,3218.844,2013);	insert into Principal values(19,1,3706.599,2014);	insert into Principal values(19,1,3732.994,2015);	insert into Principal values(19,1,3849.354,2016);	insert into Principal values(19,1,3564.05110628687,2017);
insert into Principal values(29,1,9280,1995);	insert into Principal values(29,1,10006.451,1996);	insert into Principal values(29,1,7480.049,1997);	insert into Principal values(29,1,8484.474,1998);	insert into Principal values(29,1,9234.753,1999);	insert into Principal values(29,1,9882.302,2000);	insert into Principal values(29,1,9573.236,2001);	insert into Principal values(29,1,9666,2002);	insert into Principal values(29,1,9389.341,2003);	insert into Principal values(29,1,9448.144,2004);	insert into Principal values(29,1,9851.427,2005);	insert into Principal values(29,1,10271.355,2006);	insert into Principal values(29,1,11407,2007);	insert into Principal values(29,1,12368.108,2008);	insert into Principal values(29,1,12399.348,2009);	insert into Principal values(29,1,13487.265,2010);	insert into Principal values(29,1,14615.53,2011);	insert into Principal values(29,1,15055.861,2012);	insert into Principal values(29,1,15693.647,2013);	insert into Principal values(29,1,17390.66,2014);	insert into Principal values(29,1,18350.472,2015);	insert into Principal values(29,1,19394.585,2016);	insert into Principal values(29,1,17858.2788712964,2017);
insert into Principal values(33,1,3967,2007);	insert into Principal values(33,1,5544.464,2008);	insert into Principal values(33,1,5778.904,2009);	insert into Principal values(33,1,3812.781,2010);	insert into Principal values(33,1,3840.025,2011);	insert into Principal values(33,1,4028.922,2012);	insert into Principal values(33,1,3542.384,2013);	insert into Principal values(33,1,4345.147,2014);	insert into Principal values(33,1,4546.151,2015);	insert into Principal values(33,1,5004.061,2016);	insert into Principal values(33,1,4611.98366045639,2017);
insert into Principal values(30,1,2619.52401322645,1998);	insert into Principal values(30,1,6161.651,1999);	insert into Principal values(30,1,6820.896,2000);	insert into Principal values(30,1,6526.541,2001);	insert into Principal values(30,1,6999,2002);	insert into Principal values(30,1,4252.22,2003);	insert into Principal values(30,1,3362.492,2004);	insert into Principal values(30,1,3500.414,2005);	insert into Principal values(30,1,3622.564,2006);	insert into Principal values(30,1,3776,2007);	insert into Principal values(30,1,3665.021,2008);	insert into Principal values(30,1,3673.647,2009);	insert into Principal values(30,1,3634.58,2010);	insert into Principal values(30,1,3869.533,2011);	insert into Principal values(30,1,3974.606,2012);	insert into Principal values(30,1,4289.448,2013);	insert into Principal values(30,1,4901.429,2014);	insert into Principal values(30,1,4756.545,2015);	insert into Principal values(30,1,5433.956,2016);	insert into Principal values(30,1,4798.89748968094,2017);
insert into Principal values(23,1,9970,1995);	insert into Principal values(23,1,10620.768,1996);	insert into Principal values(23,1,8314.866,1997);	insert into Principal values(23,1,9589.351,1998);	insert into Principal values(23,1,10333.087,1999);	insert into Principal values(23,1,10275.13,2000);	insert into Principal values(23,1,10041.441,2001);	insert into Principal values(23,1,10010,2002);	insert into Principal values(23,1,10053.443,2003);	insert into Principal values(23,1,10150.328,2004);	insert into Principal values(23,1,10461.189,2005);	insert into Principal values(23,1,11040.931,2006);	insert into Principal values(23,1,12080,2007);	insert into Principal values(23,1,12235.455,2008);	insert into Principal values(23,1,11814.156,2009);	insert into Principal values(23,1,12845.796,2010);	insert into Principal values(23,1,14166.812,2011);	insert into Principal values(23,1,14954.791,2012);	insert into Principal values(23,1,15660.107,2013);	insert into Principal values(23,1,17566.327,2014);	insert into Principal values(23,1,17959.867,2015);	insert into Principal values(23,1,19285.428,2016);	insert into Principal values(23,1,18223.6498068628,2017);
insert into Principal values(26,1,2457,1995);	insert into Principal values(26,1,2570.577,1996);	insert into Principal values(26,1,1875.652,1997);	insert into Principal values(26,1,2402.838,1998);	insert into Principal values(26,1,2638.074,1999);	insert into Principal values(26,1,2756.135,2000);	insert into Principal values(26,1,2592.057,2001);	insert into Principal values(26,1,2616,2002);	insert into Principal values(26,1,2566.288,2003);	insert into Principal values(26,1,2642.568,2004);	insert into Principal values(26,1,2647.798,2005);	insert into Principal values(26,1,2699.562,2006);	insert into Principal values(26,1,2774,2007);	insert into Principal values(26,1,2817.11,2008);	insert into Principal values(26,1,2765.261,2009);	insert into Principal values(26,1,3005.502,2010);	insert into Principal values(26,1,3198.609,2011);	insert into Principal values(26,1,3270.934,2012);	insert into Principal values(26,1,3215.166,2013);	insert into Principal values(26,1,3699.074,2014);	insert into Principal values(26,1,3814.692,2015);	insert into Principal values(26,1,3845.968,2016);	insert into Principal values(26,1,3670.50469779388,2017);
insert into Principal values(20,1,7931,1995);	insert into Principal values(20,1,8009.909,1996);	insert into Principal values(20,1,4495.763,1997);	insert into Principal values(20,1,4553.874,1998);	insert into Principal values(20,1,5027.8915,1999);	insert into Principal values(20,1,5653.023,2000);	insert into Principal values(20,1,5557.323,2001);	insert into Principal values(20,1,5915,2002);	insert into Principal values(20,1,6241.937,2003);	insert into Principal values(20,1,6824.18,2004);	insert into Principal values(20,1,7381.092,2005);	insert into Principal values(20,1,8655.229,2006);	insert into Principal values(20,1,11087,2007);	insert into Principal values(20,1,12598.91,2008);	insert into Principal values(20,1,12539.23,2009);	insert into Principal values(20,1,14835.941,2010);	insert into Principal values(20,1,16642.107,2011);	insert into Principal values(20,1,16532.8,2012);	insert into Principal values(20,1,17187.073,2013);	insert into Principal values(20,1,20920.761,2014);	insert into Principal values(20,1,21886.886,2015);	insert into Principal values(20,1,23210.152,2016);	insert into Principal values(20,1,20577.6944884648,2017);
insert into Principal values(24,1,7058,1995);	insert into Principal values(24,1,7258.822,1996);	insert into Principal values(24,1,5608.543,1997);	insert into Principal values(24,1,6448.713,1998);	insert into Principal values(24,1,6603.593,1999);	insert into Principal values(24,1,6511.45,2000);	insert into Principal values(24,1,6265.6,2001);	insert into Principal values(24,1,6124,2002);	insert into Principal values(24,1,5980.421,2003);	insert into Principal values(24,1,6172.045,2004);	insert into Principal values(24,1,6518.471,2005);	insert into Principal values(24,1,6985.485,2006);	insert into Principal values(24,1,7569,2007);	insert into Principal values(24,1,7702.257,2008);	insert into Principal values(24,1,7544.177,2009);	insert into Principal values(24,1,8175.716,2010);	insert into Principal values(24,1,8937.719,2011);	insert into Principal values(24,1,9670.652,2012);	insert into Principal values(24,1,9794.566,2013);	insert into Principal values(24,1,11018.933,2014);	insert into Principal values(24,1,11655.546,2015);	insert into Principal values(24,1,12013.769,2016);	insert into Principal values(24,1,11240.1561986477,2017);
insert into Principal values(16,1,2161,1995);	insert into Principal values(16,1,2418.4,1996);	insert into Principal values(16,1,1767.458,1997);	insert into Principal values(16,1,1601.862,1998);	insert into Principal values(16,1,1736.422,1999);	insert into Principal values(16,1,1738.0982725,2000);	insert into Principal values(16,1,1641.289,2001);	insert into Principal values(16,1,1593,2002);	insert into Principal values(16,1,1587.802908,2003);	insert into Principal values(16,1,1840.866,2004);	insert into Principal values(16,1,2034.889,2005);	insert into Principal values(16,1,1882.416,2006);	insert into Principal values(16,1,1866,2007);	 	 	insert into Principal values(16,1,2735.368,2010);	insert into Principal values(16,1,2368.395,2011);	insert into Principal values(16,1,2426.969,2012);	insert into Principal values(16,1,2535.375,2013);	insert into Principal values(16,1,3080.178,2014);	insert into Principal values(16,1,3449.079,2015);	insert into Principal values(16,1,3586.739,2016);	insert into Principal values(16,1,2979.47379209153,2017);
insert into Principal values(28,1,3725,1995);	insert into Principal values(28,1,3809.191,1996);	insert into Principal values(28,1,2848.24,1997);	insert into Principal values(28,1,3423.308,1998);	insert into Principal values(28,1,3771.528,1999);	insert into Principal values(28,1,3864.252,2000);	insert into Principal values(28,1,3714.442,2001);	insert into Principal values(28,1,3832,2002);	insert into Principal values(28,1,3788.228,2003);	insert into Principal values(28,1,3888.693,2004);	insert into Principal values(28,1,4001.951,2005);	insert into Principal values(28,1,4049.053,2006);	insert into Principal values(28,1,4272,2007);	insert into Principal values(28,1,4354.363,2008);	insert into Principal values(28,1,4219.143,2009);	insert into Principal values(28,1,4469.556,2010);	insert into Principal values(28,1,4700.201,2011);	insert into Principal values(28,1,4801.438,2012);	insert into Principal values(28,1,4778.933,2013);	insert into Principal values(28,1,5407.975,2014);	insert into Principal values(28,1,5574.225,2015);	insert into Principal values(28,1,5966.835,2016);	insert into Principal values(28,1,5907.91726476869,2017);
insert into Principal values(25,1,2626,1995);	insert into Principal values(25,1,2627.368,1996);	insert into Principal values(25,1,1925.435,1997);	insert into Principal values(25,1,2372.27,1998);	insert into Principal values(25,1,2497.295,1999);	insert into Principal values(25,1,2528.058,2000);	insert into Principal values(25,1,2390.079,2001);	insert into Principal values(25,1,2399,2002);	insert into Principal values(25,1,2323.202,2003);	insert into Principal values(25,1,2447.27,2004);	insert into Principal values(25,1,2521.386,2005);	insert into Principal values(25,1,2519.53,2006);	insert into Principal values(25,1,2679,2007);	insert into Principal values(25,1,2638.136,2008);	insert into Principal values(25,1,2565.573,2009);	insert into Principal values(25,1,2784.234,2010);	insert into Principal values(25,1,2950.495,2011);	insert into Principal values(25,1,3230.238,2012);	insert into Principal values(25,1,3289.622,2013);	insert into Principal values(25,1,3841.67,2014);	insert into Principal values(25,1,3718.843,2015);	insert into Principal values(25,1,3744.994,2016);	insert into Principal values(25,1,3506.18685820079,2017);
insert into Principal values(35,1,139.676,2009);	insert into Principal values(35,1,8950.679,2010);	insert into Principal values(35,1,10169.057,2011);	insert into Principal values(35,1,10827.739,2012);	insert into Principal values(35,1,2082.436,2013);	insert into Principal values(35,1,11285.181,2014);	insert into Principal values(35,1,12192.476,2015);	insert into Principal values(35,1,12816.639,2016);	insert into Principal values(35,1,7251.10287729122,2017);
insert into Principal values(27,1,4818,1995);	insert into Principal values(27,1,4967.184,1996);	insert into Principal values(27,1,3633.458,1997);	insert into Principal values(27,1,4621.764,1998);	insert into Principal values(27,1,5131.442,1999);	insert into Principal values(27,1,5392.719,2000);	insert into Principal values(27,1,5181.409,2001);	insert into Principal values(27,1,5228,2002);	insert into Principal values(27,1,5337.33,2003);	insert into Principal values(27,1,5557.788,2004);	insert into Principal values(27,1,6026.195,2005);	insert into Principal values(27,1,6072.966,2006);	insert into Principal values(27,1,6420,2007);	insert into Principal values(27,1,6297.525,2008);	insert into Principal values(27,1,6059.251,2009);	insert into Principal values(27,1,6418.012,2010);	insert into Principal values(27,1,6766.016,2011);	insert into Principal values(27,1,6866.52,2012);	insert into Principal values(27,1,7201.672,2013);	insert into Principal values(27,1,8173.958,2014);	insert into Principal values(27,1,8142.068,2015);	insert into Principal values(27,1,8682.768,2016);	insert into Principal values(27,1,8380.18569595179,2017);
insert into Principal values(32,1,2114,1995);	insert into Principal values(32,1,2215.45,1996);	insert into Principal values(32,1,1621.911,1997);	insert into Principal values(32,1,1667.558,1998);	insert into Principal values(32,1,1696.923,1999);	insert into Principal values(32,1,1681.278,2000);	insert into Principal values(32,1,1459.158,2001);	insert into Principal values(32,1,1454,2002);	insert into Principal values(32,1,1402.89,2003);	insert into Principal values(32,1,1432.081,2004);	insert into Principal values(32,1,1574.422,2005);	insert into Principal values(32,1,1645.05,2006);	insert into Principal values(32,1,1728,2007);	insert into Principal values(32,1,1767.544,2008);	insert into Principal values(32,1,1738.688,2009);	insert into Principal values(32,1,1894.818,2010);	insert into Principal values(32,1,1800.365,2011);	insert into Principal values(32,1,1981.207,2012);	insert into Principal values(32,1,2011.875,2013);	insert into Principal values(32,1,2664.691,2014);	insert into Principal values(32,1,2817.91,2015);	insert into Principal values(32,1,2752.798,2016);	insert into Principal values(32,1,2521.1874596466,2017);
insert into Principal values(21,1,2184,1995);	insert into Principal values(21,1,2269.38,1996);	insert into Principal values(21,1,1652.081,1997);	insert into Principal values(21,1,1931,1998);	insert into Principal values(21,1,2057.458,1999);	insert into Principal values(21,1,2115.392,2000);	insert into Principal values(21,1,2118.115,2001);	insert into Principal values(21,1,2083,2002);	insert into Principal values(21,1,2037.518,2003);	insert into Principal values(21,1,2082.349,2004);	insert into Principal values(21,1,2049.53,2005);	insert into Principal values(21,1,2097.579,2006);	insert into Principal values(21,1,2024,2007);	insert into Principal values(21,1,1951.787,2008);	insert into Principal values(21,1,1851.994,2009);	insert into Principal values(21,1,2040.422,2010);	insert into Principal values(21,1,2169.477,2011);	insert into Principal values(21,1,2123.92,2012);	insert into Principal values(21,1,2313.419,2013);	insert into Principal values(21,1,2772.306,2014);	insert into Principal values(21,1,2847.363,2015);	insert into Principal values(21,1,2973.709,2016);	insert into Principal values(21,1,2921.34921343832,2017);
insert into Principal values(17,1,9156,1995);	insert into Principal values(17,1,9984,1996);	insert into Principal values(17,1,7530.229,1997);	insert into Principal values(17,1,9105.143,1998);	insert into Principal values(17,1,10182.198,1999);	insert into Principal values(17,1,10487.459,2000);	insert into Principal values(17,1,10063.969,2001);	insert into Principal values(17,1,9983,2002);	insert into Principal values(17,1,9651.933,2003);	insert into Principal values(17,1,10236.043,2004);	insert into Principal values(17,1,11864.483,2005);	insert into Principal values(17,1,12056.413,2006);	insert into Principal values(17,1,12520,2007);	insert into Principal values(17,1,12214.612,2008);	insert into Principal values(17,1,11977.007,2009);	insert into Principal values(17,1,11350.66,2010);	insert into Principal values(17,1,11843.9,2011);	insert into Principal values(17,1,12054.762,2012);	insert into Principal values(17,1,12637.869,2013);	insert into Principal values(17,1,10394.953,2014);	insert into Principal values(17,1,9130.138,2015);	insert into Principal values(17,1,9089.765,2016);	insert into Principal values(17,1,8368.78743868791,2017);
insert into Principal values(18,1,2171,1995);	insert into Principal values(18,1,2459.802,1996);	insert into Principal values(18,1,1839.892,1997);	insert into Principal values(18,1,2210.651,1998);	insert into Principal values(18,1,2536.799,1999);	insert into Principal values(18,1,2584.684,2000);	insert into Principal values(18,1,2437.491,2001);	insert into Principal values(18,1,2455,2002);	insert into Principal values(18,1,2354.192,2003);	insert into Principal values(18,1,2407.34,2004);	insert into Principal values(18,1,2623.952,2005);	insert into Principal values(18,1,2922.081,2006);	insert into Principal values(18,1,3091,2007);	insert into Principal values(18,1,3101.792,2008);	insert into Principal values(18,1,2950.332,2009);	insert into Principal values(18,1,2833.754,2010);	insert into Principal values(18,1,3014.848,2011);	insert into Principal values(18,1,3037.854,2012);	insert into Principal values(18,1,3063.758,2013);	insert into Principal values(18,1,3446.334,2014);	insert into Principal values(18,1,3344.496,2015);	insert into Principal values(18,1,3419.22,2016);	insert into Principal values(18,1,3009.4535205114,2017);
insert into Principal values(31,1,6270.871,2003);	insert into Principal values(31,1,9288.502,2004);	insert into Principal values(31,1,10370.802,2005);	insert into Principal values(31,1,10974.082,2006);	insert into Principal values(31,1,10573,2007);	insert into Principal values(31,1,9869.539,2008);	insert into Principal values(31,1,9584.55,2009);	insert into Principal values(31,1,6667.661,2010);	insert into Principal values(31,1,6981.736,2011);	insert into Principal values(31,1,7362.261,2012);	insert into Principal values(31,1,11145.758,2013);	insert into Principal values(31,1,8416.731,2014);	insert into Principal values(31,1,8519.544,2015);	insert into Principal values(31,1,9333.73,2016);	insert into Principal values(31,1,9132.64004100754,2017);
insert into Principal values(36,1,5437.874,2014);	insert into Principal values(36,1,7297.128,2015);	insert into Principal values(36,1,7759.343,2016);	insert into Principal values(36,1,7197.77732679554,2017);
insert into Principal values(22,1,7410,1995);	insert into Principal values(22,1,7935.323,1996);	insert into Principal values(22,1,6261.802,1997);	insert into Principal values(22,1,7649.05,1998);	insert into Principal values(22,1,8395.892,1999);	insert into Principal values(22,1,8527.201,2000);	insert into Principal values(22,1,8314.75,2001);	insert into Principal values(22,1,8239,2002);	insert into Principal values(22,1,8090.393,2003);	insert into Principal values(22,1,8299.103,2004);	insert into Principal values(22,1,8659.243,2005);	insert into Principal values(22,1,8970.732,2006);	insert into Principal values(22,1,9457,2007);	insert into Principal values(22,1,9541.052,2008);	insert into Principal values(22,1,9196.667,2009);	insert into Principal values(22,1,9882.416,2010);	insert into Principal values(22,1,10817.862,2011);	insert into Principal values(22,1,11324.749,2012);	insert into Principal values(22,1,12153.47,2013);	insert into Principal values(22,1,13810.658,2014);	insert into Principal values(22,1,13600.733,2015);	insert into Principal values(22,1,15000.13,2016);	insert into Principal values(22,1,13691.0951132286,2017);
insert into Principal values(3,2,135.133,1998);	insert into Principal values(3,2,699.877,1999);	insert into Principal values(3,2,842.006,2000);	insert into Principal values(3,2,885.817,2001);	insert into Principal values(3,2,916,2002);	insert into Principal values(3,2,929.961,2003);	insert into Principal values(3,2,1005.327,2004);	insert into Principal values(3,2,1029.949,2005);	insert into Principal values(3,2,1093.17,2006);	insert into Principal values(3,2,1167,2007);	insert into Principal values(3,2,1216.608,2008);	insert into Principal values(3,2,1271.434,2009);	insert into Principal values(3,2,1365.196,2010);	insert into Principal values(3,2,1468.498,2011);	insert into Principal values(3,2,1572.486,2012);	insert into Principal values(3,2,1574.77,2013);	insert into Principal values(3,2,1770.329,2014);	insert into Principal values(3,2,2030.851,2015);	insert into Principal values(3,2,1760.699,2016);	insert into Principal values(3,2,1661.22865201069,2017);
insert into Principal values(34,2,204.817,2010);	insert into Principal values(34,2,1802.452,2011);	insert into Principal values(34,2,2033.84,2012);	insert into Principal values(34,2,2380.723,2013);	insert into Principal values(34,2,2783.28,2014);	insert into Principal values(34,2,2894.578,2015);	insert into Principal values(34,2,3022.738,2016);	insert into Principal values(34,2,2641.99893527055,2017);
insert into Principal values(4,2,148.162,1998);	insert into Principal values(4,2,923.891,1999);	insert into Principal values(4,2,1130.619,2000);	insert into Principal values(4,2,1233.493,2001);	insert into Principal values(4,2,1272,2002);	insert into Principal values(4,2,1355.936,2003);	insert into Principal values(4,2,1492.005,2004);	insert into Principal values(4,2,2507.913,2005);	insert into Principal values(4,2,2137.02,2006);	insert into Principal values(4,2,2472,2007);	insert into Principal values(4,2,2471.48106796116,2008);	insert into Principal values(4,2,2564.739,2009);	insert into Principal values(4,2,2990.353,2010);	insert into Principal values(4,2,3252.665,2011);	insert into Principal values(4,2,3675.917,2012);	insert into Principal values(4,2,4169.9,2013);	insert into Principal values(4,2,5086.306,2014);	insert into Principal values(4,2,4609.505,2015);	insert into Principal values(4,2,5087.162,2016);	insert into Principal values(4,2,4854.75598623526,2017);
insert into Principal values(5,2,187.471,1998);	insert into Principal values(5,2,996.477,1999);	insert into Principal values(5,2,1199.738,2000);	insert into Principal values(5,2,1247.919,2001);	insert into Principal values(5,2,1291,2002);	insert into Principal values(5,2,1271.494,2003);	insert into Principal values(5,2,1416.263,2004);	insert into Principal values(5,2,1507.861,2005);	insert into Principal values(5,2,1588.416,2006);	insert into Principal values(5,2,1741,2007);	insert into Principal values(5,2,1800.629,2008);	insert into Principal values(5,2,1854.304,2009);	insert into Principal values(5,2,1990.598,2010);	insert into Principal values(5,2,2190.883,2011);	insert into Principal values(5,2,2299.981,2012);	insert into Principal values(5,2,2480.746,2013);	insert into Principal values(5,2,2718.101,2014);	insert into Principal values(5,2,2644.838,2015);	insert into Principal values(5,2,2595.282,2016);	insert into Principal values(5,2,2329.4921921677,2017);
insert into Principal values(11,2,369,1995);	insert into Principal values(11,2,1053.432,1996);	insert into Principal values(11,2,962.939,1997);	insert into Principal values(11,2,1252.313,1998);	insert into Principal values(11,2,1685.037,1999);	insert into Principal values(11,2,1840.189,2000);	insert into Principal values(11,2,1770.584,2001);	insert into Principal values(11,2,1911,2002);	insert into Principal values(11,2,1992.934,2003);	insert into Principal values(11,2,2289.233,2004);	insert into Principal values(11,2,2768.015,2005);	insert into Principal values(11,2,3014.569,2006);	insert into Principal values(11,2,3429,2007);	insert into Principal values(11,2,3795.51,2008);	insert into Principal values(11,2,4018.146,2009);	insert into Principal values(11,2,4259.734,2010);	insert into Principal values(11,2,4988.107,2011);	insert into Principal values(11,2,5309.163,2012);	insert into Principal values(11,2,6625.547,2013);	insert into Principal values(11,2,8002.793,2014);	insert into Principal values(11,2,7782.565,2015);	insert into Principal values(11,2,8180.379,2016);	insert into Principal values(11,2,6910.41861699197,2017);
insert into Principal values(2,2,121.343,1998);	insert into Principal values(2,2,681.7985,1999);	insert into Principal values(2,2,882.542,2000);	insert into Principal values(2,2,992.486,2001);	insert into Principal values(2,2,1078,2002);	insert into Principal values(2,2,1148.92,2003);	insert into Principal values(2,2,1265.825,2004);	insert into Principal values(2,2,1357.983,2005);	insert into Principal values(2,2,1526.303,2006);	insert into Principal values(2,2,1672,2007);	insert into Principal values(2,2,1683.34,2008);	insert into Principal values(2,2,1693.912,2009);	insert into Principal values(2,2,1820.461,2010);	insert into Principal values(2,2,2000.913,2011);	insert into Principal values(2,2,2203.857,2012);	insert into Principal values(2,2,2293.494,2013);	insert into Principal values(2,2,2537.05,2014);	insert into Principal values(2,2,2534.258,2015);	insert into Principal values(2,2,2647.995,2016);	insert into Principal values(2,2,2570.47386580234,2017);
insert into Principal values(9,2,1843,1995);	insert into Principal values(9,2,2397.815,1996);	insert into Principal values(9,2,1153.476,1997);	insert into Principal values(9,2,1200.301,1998);	insert into Principal values(9,2,1335.5445,1999);	insert into Principal values(9,2,1409.564,2000);	insert into Principal values(9,2,1323.407,2001);	insert into Principal values(9,2,1269,2002);	insert into Principal values(9,2,1213.222,2003);	insert into Principal values(9,2,1287.523,2004);	insert into Principal values(9,2,1315.943,2005);	insert into Principal values(9,2,1373.077,2006);	insert into Principal values(9,2,1435,2007);	insert into Principal values(9,2,1434.363,2008);	insert into Principal values(9,2,1458.459,2009);	insert into Principal values(9,2,1465.225,2010);	insert into Principal values(9,2,1555.267,2011);	insert into Principal values(9,2,1595.349,2012);	insert into Principal values(9,2,1716.586,2013);	insert into Principal values(9,2,2013.496,2014);	insert into Principal values(9,2,2059.077,2015);	insert into Principal values(9,2,2055.408,2016);	insert into Principal values(9,2,1891.46038195598,2017);
insert into Principal values(16,2,365,1995);	insert into Principal values(16,2,408.482,1996);	insert into Principal values(16,2,300.555,1997);	insert into Principal values(16,2,718.516,1998);	insert into Principal values(16,2,1003.339,1999);	insert into Principal values(16,2,1016.0087275,2000);	insert into Principal values(16,2,956.376,2001);	insert into Principal values(16,2,928,2002);	insert into Principal values(16,2,892.354092,2003);	insert into Principal values(16,2,745.051,2004);	insert into Principal values(16,2,832.924,2005);	insert into Principal values(16,2,1147.68,2006);	insert into Principal values(16,2,1370,2007);	 	 	 	 	 	 	 	 	 	 
insert into Principal values(10,2,1291,1995);	insert into Principal values(10,2,1584.48,1996);	insert into Principal values(10,2,1163.115,1997);	insert into Principal values(10,2,1161.161,1998);	insert into Principal values(10,2,1322.903,1999);	insert into Principal values(10,2,1382.941,2000);	insert into Principal values(10,2,1251.453,2001);	insert into Principal values(10,2,1190,2002);	insert into Principal values(10,2,1178.292,2003);	insert into Principal values(10,2,1279.558,2004);	insert into Principal values(10,2,1335.014,2005);	insert into Principal values(10,2,1390.032,2006);	insert into Principal values(10,2,1440,2007);	insert into Principal values(10,2,1432.995,2008);	insert into Principal values(10,2,1457.837,2009);	insert into Principal values(10,2,1446.249,2010);	insert into Principal values(10,2,1561.694,2011);	insert into Principal values(10,2,1652.747,2012);	insert into Principal values(10,2,1782.716,2013);	insert into Principal values(10,2,2091.34,2014);	insert into Principal values(10,2,2158.554,2015);	insert into Principal values(10,2,2177.863,2016);	insert into Principal values(10,2,1926.17782515656,2017);
insert into Principal values(6,2,422.601,1998);	insert into Principal values(6,2,1713.007,1999);	insert into Principal values(6,2,2020.118,2000);	insert into Principal values(6,2,2026.349,2001);	insert into Principal values(6,2,2017,2002);	insert into Principal values(6,2,1992.061,2003);	insert into Principal values(6,2,2137.032,2004);	insert into Principal values(6,2,2235.392,2005);	insert into Principal values(6,2,2355.854,2006);	insert into Principal values(6,2,2567,2007);	insert into Principal values(6,2,2602.093819,2008);	insert into Principal values(6,2,2647.561,2009);	insert into Principal values(6,2,2815.542,2010);	insert into Principal values(6,2,3142.171,2011);	insert into Principal values(6,2,3338.067,2012);	insert into Principal values(6,2,3724.213,2013);	insert into Principal values(6,2,4197.014,2014);	insert into Principal values(6,2,4072.989,2015);	insert into Principal values(6,2,4072.129,2016);	insert into Principal values(6,2,3871.77892397868,2017);
insert into Principal values(14,2,578,1995);	insert into Principal values(14,2,731.311,1996);	insert into Principal values(14,2,613.5,1997);	insert into Principal values(14,2,706.899,1998);	insert into Principal values(14,2,1331.979,1999);	insert into Principal values(14,2,1320.256,2000);	insert into Principal values(14,2,1263.959,2001);	insert into Principal values(14,2,1230,2002);	insert into Principal values(14,2,1055.317,2003);	insert into Principal values(14,2,1290.939,2004);	insert into Principal values(14,2,1292.514,2005);	insert into Principal values(14,2,1286.116,2006);	insert into Principal values(14,2,1757,2007);	insert into Principal values(14,2,1570.221,2008);	insert into Principal values(14,2,1675.078,2009);	insert into Principal values(14,2,1532.539,2010);	insert into Principal values(14,2,1374.369,2011);	insert into Principal values(14,2,1403.46,2012);	insert into Principal values(14,2,2149.322,2013);	insert into Principal values(14,2,3097.503,2014);	insert into Principal values(14,2,3817.345,2015);	insert into Principal values(14,2,3644.794,2016);	insert into Principal values(14,2,3197.58959672298,2017);
insert into Principal values(12,2,2832,1995);	insert into Principal values(12,2,2839.416,1996);	insert into Principal values(12,2,1787.66,1997);	insert into Principal values(12,2,1798.807,1998);	insert into Principal values(12,2,2039.03,1999);	insert into Principal values(12,2,2075.84,2000);	insert into Principal values(12,2,1917.694,2001);	insert into Principal values(12,2,1859,2002);	insert into Principal values(12,2,1829.133,2003);	insert into Principal values(12,2,1913.036,2004);	insert into Principal values(12,2,1910.085,2005);	insert into Principal values(12,2,1990.214,2006);	insert into Principal values(12,2,2203,2007);	insert into Principal values(12,2,2095.726,2008);	insert into Principal values(12,2,2044.512,2009);	insert into Principal values(12,2,1983.472,2010);	insert into Principal values(12,2,2128.734,2011);	insert into Principal values(12,2,2193.729,2012);	insert into Principal values(12,2,2507.507,2013);	insert into Principal values(12,2,2980.546,2014);	insert into Principal values(12,2,2949.976,2015);	insert into Principal values(12,2,2868.454,2016);	insert into Principal values(12,2,2571.22269310935,2017);
insert into Principal values(1,2,1703.15589454179,1998);	insert into Principal values(1,2,6342.461,1999);	insert into Principal values(1,2,7382.6865,2000);	insert into Principal values(1,2,7620.237,2001);	insert into Principal values(1,2,7675,2002);	insert into Principal values(1,2,7502.361,2003);	insert into Principal values(1,2,7854.755,2004);	insert into Principal values(1,2,8100.025,2005);	insert into Principal values(1,2,8436.556,2006);	insert into Principal values(1,2,9375,2007);	insert into Principal values(1,2,9852.123,2008);	insert into Principal values(1,2,9937.201,2009);	insert into Principal values(1,2,10774.40225,2010);	insert into Principal values(1,2,12459.342,2011);	insert into Principal values(1,2,13113.615,2012);	insert into Principal values(1,2,13692.589,2013);	insert into Principal values(1,2,14791.445,2014);	insert into Principal values(1,2,14509.391,2015);	insert into Principal values(1,2,14731.755,2016);	insert into Principal values(1,2,13052.8962355954,2017);
insert into Principal values(15,2,1224,1995);	insert into Principal values(15,2,1399.551,1996);	insert into Principal values(15,2,1025.332,1997);	insert into Principal values(15,2,1221.239,1998);	insert into Principal values(15,2,1990.086,1999);	insert into Principal values(15,2,2485.386,2000);	insert into Principal values(15,2,2468.28,2001);	insert into Principal values(15,2,2555,2002);	insert into Principal values(15,2,2646.255,2003);	insert into Principal values(15,2,2853.601,2004);	insert into Principal values(15,2,2939.395,2005);	insert into Principal values(15,2,3219.337,2006);	insert into Principal values(15,2,3453,2007);	insert into Principal values(15,2,3374.628,2008);	insert into Principal values(15,2,3359.173,2009);	insert into Principal values(15,2,3348.396,2010);	insert into Principal values(15,2,3907.231,2011);	insert into Principal values(15,2,4170.769,2012);	insert into Principal values(15,2,4854.298,2013);	insert into Principal values(15,2,5024.692,2014);	insert into Principal values(15,2,4553.454,2015);	insert into Principal values(15,2,4572.398,2016);	insert into Principal values(15,2,4052.21162773255,2017);
insert into Principal values(8,2,160.474,1996);	insert into Principal values(8,2,413.646,1997);	insert into Principal values(8,2,457.143,1998);	insert into Principal values(8,2,514.297,1999);	insert into Principal values(8,2,566.991,2000);	insert into Principal values(8,2,532.816,2001);	insert into Principal values(8,2,516,2002);	insert into Principal values(8,2,515.216,2003);	insert into Principal values(8,2,593.723,2004);	insert into Principal values(8,2,635.632,2005);	insert into Principal values(8,2,653.595,2006);	insert into Principal values(8,2,680,2007);	insert into Principal values(8,2,674.553,2008);	insert into Principal values(8,2,688.28,2009);	insert into Principal values(8,2,675.088,2010);	insert into Principal values(8,2,721.821,2011);	insert into Principal values(8,2,746.402,2012);	insert into Principal values(8,2,764.578,2013);	insert into Principal values(8,2,822.488,2014);	insert into Principal values(8,2,794.612,2015);	insert into Principal values(8,2,778.75,2016);	insert into Principal values(8,2,707.893089464169,2017);
insert into Principal values(13,2,618,1995);	insert into Principal values(13,2,751.093,1996);	insert into Principal values(13,2,507.96,1997);	insert into Principal values(13,2,660.996,1998);	insert into Principal values(13,2,981.701,1999);	insert into Principal values(13,2,1067.175,2000);	insert into Principal values(13,2,1022.633,2001);	insert into Principal values(13,2,988,2002);	insert into Principal values(13,2,998.774,2003);	insert into Principal values(13,2,1066.161,2004);	insert into Principal values(13,2,1101.729,2005);	insert into Principal values(13,2,1205.031,2006);	insert into Principal values(13,2,1264,2007);	insert into Principal values(13,2,1266.91,2008);	insert into Principal values(13,2,1216.836,2009);	insert into Principal values(13,2,1268.439,2010);	insert into Principal values(13,2,1452.258,2011);	insert into Principal values(13,2,1590.424,2012);	insert into Principal values(13,2,1734.318,2013);	insert into Principal values(13,2,2267.76,2014);	insert into Principal values(13,2,2241.587,2015);	insert into Principal values(13,2,2278.642,2016);	insert into Principal values(13,2,1990.0673689365,2017);
insert into Principal values(7,2,997.797,1996);	insert into Principal values(7,2,3241.51,1997);	insert into Principal values(7,2,3227.763,1998);	insert into Principal values(7,2,2430.073,1999);	insert into Principal values(7,2,2529.59,2000);	insert into Principal values(7,2,2566.734,2001);	insert into Principal values(7,2,2608,2002);	insert into Principal values(7,2,2636.485,2003);	insert into Principal values(7,2,2883.34,2004);	insert into Principal values(7,2,3207.177,2005);	insert into Principal values(7,2,3378.797,2006);	insert into Principal values(7,2,3671,2007);	insert into Principal values(7,2,3642.887,2008);	insert into Principal values(7,2,3637.354,2009);	insert into Principal values(7,2,3669.656,2010);	insert into Principal values(7,2,4076.601,2011);	insert into Principal values(7,2,4243.57,2012);	insert into Principal values(7,2,4212.675,2013);	insert into Principal values(7,2,4942.726,2014);	insert into Principal values(7,2,5569.811,2015);	insert into Principal values(7,2,5898.967,2016);	insert into Principal values(7,2,5026.55707321192,2017);
insert into Principal values(37,3,724.54,2016);	insert into Principal values(37,3,4020.49502201533,2017);
insert into Principal values(38,3,702.105,2016);	insert into Principal values(38,3,3310.38510218119,2017);
insert into Principal values(39,3,942.571,2016);	insert into Principal values(39,3,4576.24147975311,2017);
insert into Principal values(40,3,652.257,2016);	insert into Principal values(40,3,3298.73254517411,2017);
insert into Principal values(41,3,2797.793,2016);	insert into Principal values(41,3,10835.478865424,2017);

insert into EstacaoPossuiLinha values(1,2);
insert into EstacaoPossuiLinha values(2,2);
insert into EstacaoPossuiLinha values(3,2);
insert into EstacaoPossuiLinha values(4,2);
insert into EstacaoPossuiLinha values(5,2);
insert into EstacaoPossuiLinha values(6,2);
insert into EstacaoPossuiLinha values(7,2);
insert into EstacaoPossuiLinha values(8,2);
insert into EstacaoPossuiLinha values(9,2);
insert into EstacaoPossuiLinha values(10,2);
insert into EstacaoPossuiLinha values(11,2);
insert into EstacaoPossuiLinha values(12,2);
insert into EstacaoPossuiLinha values(13,2);
insert into EstacaoPossuiLinha values(14,2);
insert into EstacaoPossuiLinha values(15,2);
insert into EstacaoPossuiLinha values(16,1);
insert into EstacaoPossuiLinha values(17,1);
insert into EstacaoPossuiLinha values(18,1);
insert into EstacaoPossuiLinha values(19,1);
insert into EstacaoPossuiLinha values(20,1);
insert into EstacaoPossuiLinha values(20,2);
insert into EstacaoPossuiLinha values(21,1);
insert into EstacaoPossuiLinha values(21,2);
insert into EstacaoPossuiLinha values(22,1);
insert into EstacaoPossuiLinha values(22,2);
insert into EstacaoPossuiLinha values(23,1);
insert into EstacaoPossuiLinha values(23,2);
insert into EstacaoPossuiLinha values(24,1);
insert into EstacaoPossuiLinha values(24,2);
insert into EstacaoPossuiLinha values(25,1);
insert into EstacaoPossuiLinha values(25,2);
insert into EstacaoPossuiLinha values(26,1);
insert into EstacaoPossuiLinha values(26,2);
insert into EstacaoPossuiLinha values(27,1);
insert into EstacaoPossuiLinha values(27,2);
insert into EstacaoPossuiLinha values(28,1);
insert into EstacaoPossuiLinha values(28,2);
insert into EstacaoPossuiLinha values(29,1);
insert into EstacaoPossuiLinha values(29,2);
insert into EstacaoPossuiLinha values(30,1);
insert into EstacaoPossuiLinha values(31,1);
insert into EstacaoPossuiLinha values(32,1);
insert into EstacaoPossuiLinha values(33,1);
insert into EstacaoPossuiLinha values(34,2);
insert into EstacaoPossuiLinha values(35,1);
insert into EstacaoPossuiLinha values(35,3);
insert into EstacaoPossuiLinha values(36,1);
insert into EstacaoPossuiLinha values(37,3);
insert into EstacaoPossuiLinha values(38,3);
insert into EstacaoPossuiLinha values(39,3);
insert into EstacaoPossuiLinha values(40,3);
insert into EstacaoPossuiLinha values(41,3);


SELECT Linha.nome, COUNT(fk_Estacao_Metro_id) AS quant
                                           FROM Linha INNER JOIN (SELECT DISTINCT EstacaoPossuiLinha.fk_Estacao_Metro_id, EstacaoPossuiLinha.fk_Linha_ID, Estacao_Metro.Ativo
                                           FROM EstacaoPossuiLinha INNER JOIN Estacao_Metro ON EstacaoPossuiLinha.fk_Estacao_Metro_id = Estacao_Metro.id) AS RelacaoEstacaoMetro
                                           ON Linha.ID = RelacaoEstacaoMetro.fk_Linha_ID
                                           WHERE RelacaoEstacaoMetro.Ativo = true
                                           GROUP BY RelacaoEstacaoMetro.fk_Linha_ID;
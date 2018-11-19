/* Lógico_1: */
use trabalhoBD;
CREATE TABLE Metro (
    inauguracao DATE,
    quantEstacoes INT,
    nome_empresa VARCHAR (50),
    logo BLOB,
    ID INT PRIMARY KEY,
    passageiros INT
);

CREATE TABLE BRT (
    passageiros INT,
    quatEstacoes INT,
    nomeEmpresa VARCHAR(20),
    tamanho INT,
    logo BLOB,
    ID INT PRIMARY KEY
);

CREATE TABLE Estacao_Metro (
    Bicicletario BOOLEAN,
    FlgAtm BOOLEAN,
    elevador BOOLEAN,
    IntegraOnibus BOOLEAN,
    IntegraBRT BOOLEAN,
    IntegraVLT BOOLEAN,
    id INT PRIMARY KEY,
    Nome VARCHAR(50),
    Status VARCHAR(20),
    Ativo BOOLEAN,
    IntegraTrem BOOLEAN,
    DataInauguracao INT
);

CREATE TABLE Estacao_BRT (
    integraMetro BOOLEAN,
    id INT PRIMARY KEY,
    Nome VARCHAR(50),
    Status VARCHAR(20),
    Ativo BOOLEAN,
    IntegraTrem BOOLEAN,
    integraAeroporto boolean,
    X DOUBLE,
    Y DOUBLE
);

CREATE TABLE Linha (
    flgAtivo BOOLEAN,
    ShapeSTLength DOUBLE,
    ID INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE Corredor (
    Corredor_PK INT NOT NULL,
    Corredor VARCHAR(50),
    estacaoBRTID INT,
    PRIMARY KEY (Corredor_PK, estacaoBRTID)
);

CREATE TABLE coordena (
    fk_Metro_ID INT,
    fk_Estacao_Metro_id INT
);

CREATE TABLE gerencia (
    fk_BRT_ID INT,
    fk_Estacao_BRT_id INT
);

CREATE TABLE possui (
    fk_Estacao_Metro_id INT,
    fk_Linha_ID INT,
    Transporta INT,
    ano INT PRIMARY KEY
);
 
ALTER TABLE Corredor ADD CONSTRAINT FK_Corredor_2
    FOREIGN KEY (estacaoBRTID)
    REFERENCES Estacao_BRT (id);
 
ALTER TABLE coordena ADD CONSTRAINT FK_coordena_1
    FOREIGN KEY (fk_Metro_ID)
    REFERENCES Metro (ID)
    ON DELETE RESTRICT;
 
ALTER TABLE coordena ADD CONSTRAINT FK_coordena_2
    FOREIGN KEY (fk_Estacao_Metro_id)
    REFERENCES Estacao_Metro (id)
    ON DELETE RESTRICT;
 
ALTER TABLE gerencia ADD CONSTRAINT FK_gerencia_1
    FOREIGN KEY (fk_BRT_ID)
    REFERENCES BRT (ID)
    ON DELETE RESTRICT;
 
ALTER TABLE gerencia ADD CONSTRAINT FK_gerencia_2
    FOREIGN KEY (fk_Estacao_BRT_id)
    REFERENCES Estacao_BRT (id)
    ON DELETE RESTRICT;
 
ALTER TABLE possui ADD CONSTRAINT FK_possui_2
    FOREIGN KEY (fk_Estacao_Metro_id)
    REFERENCES Estacao_Metro (id)
    ON DELETE RESTRICT;
 
ALTER TABLE possui ADD CONSTRAINT FK_possui_3
    FOREIGN KEY (fk_Linha_ID)
    REFERENCES Linha (ID)
    ON DELETE RESTRICT;
    

alter table estacao_metro add column DataInauguracao int;


insert into estacao_metro values(1,true,1,0,0,0,1,'Pavuna',null,1,1,1998);
insert into estacao_metro values(1,1,1,0,0,0,2,'Engenheiro Rubens Paiva',null,1,0,1998);
insert into estacao_metro values(0,0,0,0,0,0,3,'Acari / Fazenda Botafogo',null,1,0,1998);
insert into estacao_metro values(0,1,0,0,0,0,4,'Coelho Neto',null,1,0,1998);
insert into estacao_metro values(1,1,0,0,0,0,5,'Colegio',null,1,0,1998);
insert into estacao_metro values(1,1,1,0,0,0,6,'Iraja',null,1,0,1998);
insert into estacao_metro values(1,1,0,0,1,0,7,'Vicente de Carvalho',null,1,0,1996);
insert into estacao_metro values(0,0,1,0,0,0,8,'Tomaz Coelho',null,1,0,1996);
insert into estacao_metro values(0,1,0,0,0,0,9,'Engenho da Rainha',null,1,0,1991);
insert into estacao_metro values(1,1,1,0,0,0,10,'Inhauma',null,1,0,1983);
insert into estacao_metro values(0,1,1,1,0,0,11,'Del Castilho',null,1,0,1983);
insert into estacao_metro values(0,1,0,0,0,0,12,'Maria da Graca',null,1,0,1983);
insert into estacao_metro values(1,1,0,0,0,0,13,'Triagem',null,1,1,1988);
insert into estacao_metro values(0,1,0,0,0,0,14,'Maracana',null,1,1,1981);
insert into estacao_metro values(0,1,0,0,0,0,15,'Sao Cristovao',null,1,1,1981);
insert into estacao_metro values(1,1,1,1,0,0,16,'Estacio',null,1,0,1980);
insert into estacao_metro values(0,1,1,1,0,0,17,'Saens Pena',null,1,0,1982);
insert into estacao_metro values(1,1,0,1,0,0,18,'Sao Francisco Xavier',null,1,0,1982);
insert into estacao_metro values(0,1,0,0,0,0,19,'Afonso Pena',null,1,0,1982);
insert into estacao_metro values(0,1,0,0,0,0,20,'Central',null,1,1,1979);
insert into estacao_metro values(0,1,0,0,0,0,21,'Presidente Vargas',null,1,0,1979);
insert into estacao_metro values(0,1,0,0,0,0,22,'Uruguaiana',null,1,0,1980);
insert into estacao_metro values(0,1,1,0,0,1,23,'Carioca',null,1,0,1981);
insert into estacao_metro values(0,1,0,0,0,1,24,'Cinelandia',null,1,0,1979);
insert into estacao_metro values(1,1,0,0,0,0,25,'Gloria',null,1,0,1979);
insert into estacao_metro values(1,1,0,0,0,0,26,'Catete',null,1,0,1981);
insert into estacao_metro values(0,1,1,1,0,0,27,'Largo do Machado',null,1,0,1981);
insert into estacao_metro values(0,1,1,0,0,0,28,'Flamengo',null,1,0,1981);
insert into estacao_metro values(0,1,1,1,0,0,29,'Botafogo',null,1,0,1981);
insert into estacao_metro values(0,1,0,0,0,0,30,'Cardeal Arcoverde',null,1,0,1998);
insert into estacao_metro values(1,1,0,0,0,0,31,'Siqueira Campos',null,1,0,2003);
insert into estacao_metro values(0,1,0,0,0,0,32,'Praca Onze',null,1,0,1979);
insert into estacao_metro values(1,1,1,0,0,0,33,'Cantagalo',null,1,0,2007);
insert into estacao_metro values(0,1,1,0,0,0,34,'Cidade Nova',null,1,0,2009);
insert into estacao_metro values(1,1,0,0,0,0,35,'Ipanema / General Osorio',null,1,0,2009);
insert into estacao_metro values(1,0,0,0,0,0,36,'Uruguai',null,1,0,2014);
insert into estacao_metro values(0,1,1,0,0,0,37,'Nossa Senhora da Paz',null,1,0,2016);
insert into estacao_metro values(0,1,1,0,0,0,38,'Jardim de Alah',null,1,0,2016);
insert into estacao_metro values(0,1,1,0,0,0,39,'Antero de Quental',null,1,0,2016);
insert into estacao_metro values(0,1,0,0,0,0,40,'Sao Conrado',null,1,0,2016);
insert into estacao_metro values(0,1,1,0,1,0,41,'Jardim Oceanico',null,1,0,2016);
select * from estacao_metro;



insert into estacao_brt values(0,1,'Santa Luzia',1,1,0,0,679342.4694,7471499.5425);
insert into estacao_brt values(0,2,'Maré',1,1,0,0,680236.1565,7472379.5698);
insert into estacao_brt values(0,3,'Cardoso de Moraes - Viúva Garcia',1,1,0,0,678744056,7471252.0929);
insert into estacao_brt values(0,4,'Penha I',1,1,0,0,676833.5642,7473029.3037);
insert into estacao_brt values(0,5,'Penha II',1,1,0,0,676873.5062,7472976.5159);
insert into estacao_brt values(0,6,'Pastor José Santos',1,1,0,0,676190.5946,7473311.0143);
insert into estacao_brt values(0,7,'Guaporé',1,1,0,0,675532.0252,7473471.5235);
insert into estacao_brt values(0,8,'Praça do Carmo',1,1,0,0,674988.3298,7473355.5286);
insert into estacao_brt values(0,9,'Pedro Taques',1,1,0,0,674611.7594,7473064.8038);
insert into estacao_brt values(0,10,'Vila Kosmos - Nossa Senhora do Carmo',1,1,0,0,673654.1417,7472161.2863);
insert into estacao_brt values(1,11,'Vicente de Carvalho',1,1,0,0,673149.3342,7471836.7754);
insert into estacao_brt values(0,12,'Marambaia',1,1,0,0,672368.9065,7471812.6004);
insert into estacao_brt values(0,13,'Vaz Lobo',1,1,0,0,671548.7094,7471424.5497);
insert into estacao_brt values(0,14,'Vila Queiroz',1,1,0,0,671336.5613,7470886.1255);
insert into estacao_brt values(0,15,'Otaviano',1,1,0,0,670920.1446,7470408.1547);
insert into estacao_brt values(0,16,'Santa Efigênia',1,1,0,0,667002.8565,7462616.7949);
insert into estacao_brt values(0,17,'Divina Providência',1,1,0,0,666915.8421,7462170.4725);
insert into estacao_brt values(0,18,'Merck',1,1,0,0,667001.6034,746273.8861);
insert into estacao_brt values(0,19,'Terminal Bandeira Brasil',1,1,0,0,666803.5236,7464012.4314);
insert into estacao_brt values(0,20,'Tanque',1,1,0,0,668098.5115,746492.4017);
insert into estacao_brt values(0,21,'Madureira-Manaceia',1,1,1,0,670729.4584,7469130.0159);
insert into estacao_brt values(0,22,'Rio II',1,1,0,0,665676.8133,7458577.1701);
insert into estacao_brt values(0,23,'Pedro Correia',1,1,0,0,665031.6112,7459193.1928);
insert into estacao_brt values(0,24,'Hospital Sarah',1,1,0,0,666457.0827,7458550.0606);
insert into estacao_brt values(0,25,'Centro Metropolitano',1,1,0,0,667584.2118,745853.0243);
insert into estacao_brt values(0,26,'Curicica',1,1,0,0,665234.5159,7460056.1807);
insert into estacao_brt values(0,27,'Praça do Bandolim',1,1,0,0,665786.4723,7460195.8042);
insert into estacao_brt values(0,28,'Arroio Pavuna',1,1,0,0,666408.4262,746055.6412);
insert into estacao_brt values(0,29,'Vila Sapê - IV Centenário',1,1,0,0,666690.3031,7460880.3159);
insert into estacao_brt values(0,30,'Recanto das Palmeiras - Jardim São Luiz',1,1,0,0,666923.8079,7461334.6512);
insert into estacao_brt values(0,31,'Andre Rocha',1,1,0,0,666845.2945,7463418.5011);
insert into estacao_brt values(0,32,'Taquara',1,1,0,0,666804.0446,7464001.1081);
insert into estacao_brt values(0,33,'Aracy Cabral',1,1,0,0,667381.3771,7464439.0353);
insert into estacao_brt values(0,34,'Terminal Mestre Candeia',1,1,0,0,668106756,7464937.0167);
insert into estacao_brt values(0,35,'Ipase',1,1,0,0,668550.6613,7466132.3282);
insert into estacao_brt values(0,36,'Praça Seca',1,1,0,0,669052.2098,746690.2913);
insert into estacao_brt values(0,37,'Capitão Menezes',1,1,0,0,669428.8869,7467443.1399);
insert into estacao_brt values(0,38,'Pinto Teles',1,1,0,0,669720.4656,7467929.1109);
insert into estacao_brt values(0,39,'Apóstolo Samuel Joaquim',1,1,0,0,670129928,7468602.2304);
insert into estacao_brt values(0,40,'Terminal Paulo da Portela',1,1,0,0,670721.7874,7469116.8522);
insert into estacao_brt values(0,41,'Mercadão',1,1,0,0,670776.9484,7469876.8256);
insert into estacao_brt values(0,42,'Ibiapina',1,1,1,0,677308.3931,747293.7286);
insert into estacao_brt values(0,43,'Olaria - Cacique de Ramos',1,1,0,0,678018.4898,7472237.6761);
insert into estacao_brt values(0,44,'Terminal Fundão - Aroldo Melodia',1,1,0,0,680639.5657,7473179.8781);
insert into estacao_brt values(0,45,'Via Parque',1,1,0,0,667570.5911,7457367.1485);
insert into estacao_brt values(0,46,'Aeroporto de Jacarepaguá',1,1,0,0,667550791,7456808.7301);
insert into estacao_brt values(0,47,'Lourenço Jorge',1,1,0,0,667535.8977,7456079.0799);
insert into estacao_brt values(0,48,'Tom Jobim 1',1,1,0,1,679502.5562,7476357.8081);
insert into estacao_brt values(0,49,'Tom Jobim 2',1,1,0,1,680019.0118,7475997.8294);
insert into estacao_brt values(0,50,'Terminal Alvorada',1,1,0,0,667503.4512,745554.6597);
insert into estacao_brt values(0,51,'Cesarão II',1,1,0,0,637247.0653,7463270.6287);
insert into estacao_brt values(0,52,'Cesarão III',1,1,0,0,637727.3478,7463455.2311);
insert into estacao_brt values(0,53,'Vila Paciência',1,1,0,0,638087.5565,7463822.5644);
insert into estacao_brt values(0,54,'Três Pontes',1,1,0,0,638483.8907,7464145.4011);
insert into estacao_brt values(0,55,'Cesarinho',1,1,0,0,639148985,7464691.2346);
insert into estacao_brt values(0,56,'31 de Outubro',1,1,0,0,639611.5726,7464933.1322);
insert into estacao_brt values(0,57,'Santa Eugênia',1,1,1,0,640254.7159,7465085.2967);
insert into estacao_brt values(0,58,'Júlia Miguel',1,1,0,0,640750.2068,7465210.6361);
insert into estacao_brt values(0,59,'Parque São Paulo',1,1,0,0,641323.1236,746513.4089);
insert into estacao_brt values(0,60,'Icurana',1,1,0,0,643020.1764,746524.4565);
insert into estacao_brt values(0,61,'Vilar Carioca',1,1,0,0,643487.5501,7465342.6929);
insert into estacao_brt values(0,62,'Inhoaíba',1,1,0,0,644070.3965,7465434.8176);
insert into estacao_brt values(0,63,'Golfe Olímpico',1,1,0,0,662778.8355,7455640.2223);
insert into estacao_brt values(0,65,'Ana Gonzaga',1,1,0,0,644674.4701,746564.8462);
insert into estacao_brt values(0,66,'São Jorge',1,1,0,0,645246.0738,7465696.3482);
insert into estacao_brt values(0,67,'Pina Rangel',1,1,0,0,646112.0026,7466058.5567);
insert into estacao_brt values(0,68,'Parque Esperança',1,1,0,0,646536.0498,7466121.1072);
insert into estacao_brt values(0,69,'Cândido Magalhães',1,1,0,0,647320.7627,7466032.7958);
insert into estacao_brt values(0,70,'Prefeito Alim Pedro',1,1,0,0,647092.9889,7466475.8203);
insert into estacao_brt values(0,71,'Gramado',1,1,0,0,647090.1188,7466479.2758);
insert into estacao_brt values(0,72,'Santa Verediana',1,1,0,0,636906.7966,7462492.2484);
insert into estacao_brt values(0,73,'Gastão Rangel',1,1,0,0,635650.9103,7463935.1495);
insert into estacao_brt values(0,74,'Terminal Santa Cruz',1,1,1,0,635035.0111,7465122.3778);
insert into estacao_brt values(0,75,'Parque das Rosas',1,1,0,0,668885.3293,7455567.1627);
insert into estacao_brt values(0,76,'Cesarão',1,1,0,0,636897.9821,7463146.7256);
insert into estacao_brt values(0,77,'Cosmos',1,1,0,0,641970041,7465194.0494);
insert into estacao_brt values(0,78,'Recanto das Garças',1,1,0,0,654096.8985,7453408.3407);
insert into estacao_brt values(0,79,'Dom Bosco',1,1,0,0,652836.9668,7453729.2847);
insert into estacao_brt values(0,80,'CTEx',1,1,0,0,647781.8001,7455219.5104);
insert into estacao_brt values(0,81,'Embrapa',1,1,0,0,645326.8216,7455873.6957);
insert into estacao_brt values(0,82,'Terminal Campo Grande',1,1,1,0,648252.6075,7466671.6633);
insert into estacao_brt values(0,83,'Nova Barra',1,1,0,0,656686.9454,745398.1534);
insert into estacao_brt values(0,84,'Vendas de Varanda',1,1,0,0,638370.15,7461329.0543);
insert into estacao_brt values(0,85,'Curral Falso',1,1,0,0,636730.4909,7462930.6497);
insert into estacao_brt values(0,86,'Cajueiros',1,1,0,0,636064.6766,7463566.9326);
insert into estacao_brt values(1,87,'Terminal Jd. Oceânico',1,1,0,0,673068.8522,7454778.4795);
insert into estacao_brt values(0,88,'Cittá América',1,1,0,0,671889.6407,7455143.5403);
insert into estacao_brt values(0,89,'Porto dos Cabritos',1,1,0,0,671289.3165,7455405.8147);
insert into estacao_brt values(0,90,'Freeway',1,1,0,0,670638.4666,7455495.8297);
insert into estacao_brt values(0,91,'Riviera',1,1,0,0,669982.4992,7455534.7983);
insert into estacao_brt values(0,92,'Ricardo Marinho',1,1,0,0,669518.3111,7455550.5184);
insert into estacao_brt values(0,93,'Barra Shopping',1,1,0,0,668060.9803,7455587.6412);
insert into estacao_brt values(0,94,'Bosque da Barra',1,1,0,0,666341.5087,7455570.5399);
insert into estacao_brt values(0,95,'Novo Leblon',1,1,0,0,665752.0627,7455566.2133);
insert into estacao_brt values(0,96,'Américas Park',1,1,0,0,665076.2154,7455572.6405);
insert into estacao_brt values(0,97,'Santa Mônica Jardins',1,1,0,0,664184.5856,7455605.0165);
insert into estacao_brt values(0,98,'Rio Mar',1,1,0,0,663322.7851,7455644.8619);
insert into estacao_brt values(0,99,'Interlagos',1,1,0,0,662238.4136,7455553.2912);
insert into estacao_brt values(0,100,'Pedra de Itaúna',1,1,0,0,661562.4112,7455334.9587);
insert into estacao_brt values(0,101,'Pontões/Barrasul',1,1,0,0,660748.8158,7455058.1378);
insert into estacao_brt values(0,102,'Salvador Allende',1,1,0,0,659643.7292,7454761.1583);
insert into estacao_brt values(0,103,'Gelson Fonseca',1,1,0,0,659031.5398,7454602.0193);
insert into estacao_brt values(0,104,'Guignard',1,1,0,0,658619.2781,7454495.6601);
insert into estacao_brt values(0,105,'Gláucio Gil',1,1,0,0,657971.6558,7454319.7988);
insert into estacao_brt values(0,106,'Benvindo de Novaes',1,1,0,0,657177.8991,7454112.5103);
insert into estacao_brt values(0,107,'Gilka Machado',1,1,0,0,656110.2474,7453827.0712);
insert into estacao_brt values(0,108,'Guiomar Novais',1,1,0,0,655541.2472,745368.0004);
insert into estacao_brt values(0,109,'Recreio Shopping ',1,1,0,0,655060.4679,745355.1521);
insert into estacao_brt values(0,110,'Notre Dame',1,1,0,0,653727.9158,7453457.8898);
insert into estacao_brt values(0,111,'Pontal',1,1,0,0,652118.4719,7453953.3278);
insert into estacao_brt values(0,112,'Ilha de Guaratiba',1,1,0,0,649680.9819,7454736.7711);
insert into estacao_brt values(0,113,'Mato Alto',1,1,0,0,643868.3822,7456519.7944);
insert into estacao_brt values(0,114,'Magarça',1,1,0,0,641302.2234,745933.4162);
insert into estacao_brt values(0,115,'Pingo DÁgua',1,1,0,0,638715.5649,7459777.6324);
insert into estacao_brt values(0,116,'General Olímpo',1,1,0,0,635441.9484,7464526.4505);
insert into estacao_brt values(0,117,'Terminal Deodoro',1,1,1,0,665843.4234,747178.7908);
insert into estacao_brt values(null,118,'Carrefour',0,0,null,0,666558.5458,7472762.9123);
insert into estacao_brt values(null,119,'Barros Filho',0,0,null,0,667436.8306,7473337.1264);
insert into estacao_brt values(null,120,'Coelho Neto',0,0,null,0,669277.6591,7474284.4756);
insert into estacao_brt values(null,121,'Irajá',0,0,null,0,671617.1874,7475162.2992);
insert into estacao_brt values(null,122,'Correia Andrade',0,0,null,0,673650.1937,7475658.3968);
insert into estacao_brt values(null,123,'Ponto Chique',0,0,null,0,675299.3735,7476000.6733);
insert into estacao_brt values(null,124,'Terminal Margaridas',0,0,null,0,672129.0956,7475458.0375);
insert into estacao_brt values(null,125,'Terminal Missões',0,0,null,0,675515.4976,7476115.9835);
insert into estacao_brt values(null,126,'Brás de Pina',0,0,null,0,676152.2776,7475477.6188);
insert into estacao_brt values(null,127,'Marinha do Brasil',0,0,null,0,677394.4266,7474403.9889);
insert into estacao_brt values(null,128,'Marinha Mercante',0,0,null,0,678789.9309,747352.1051);
insert into estacao_brt values(null,129,'Piscinão de Ramos',0,0,null,0,679508147,7472846.4986);
insert into estacao_brt values(null,130,'Rubens Vaz',0,0,null,0,679842.4079,747171.9637);
insert into estacao_brt values(null,131,'Nova Holanda',0,0,null,0,679813587,7470847.0187);
insert into estacao_brt values(null,132,'Joana Nascimento',0,0,null,0,679822.3207,7470221.6801);
insert into estacao_brt values(null,133,'Fiocruz',0,0,null,0,680286.4669,746925.1946);
insert into estacao_brt values(null,134,'Parque Vitória',0,0,null,0,680969541,7468263.7505);
insert into estacao_brt values(null,135,'São Francisco',0,0,null,0,682168254,7467952.7684);
insert into estacao_brt values(null,136,'Caju',0,0,null,0,682570.5248,7467664.0082);
insert into estacao_brt values(null,137,'I.N.T.O',0,0,null,0,683094.7585,7467130.1047);
insert into estacao_brt values(null,138,'Terminal Rodoviária',0,0,null,0,683615824,7466528.7997);
insert into estacao_brt values(null,139,'TerminalAmérico Fontenelle',0,0,null,0,685412.4392,7466224.0723);
insert into estacao_brt values(null,140,'Cidade Nova',0,0,null,0,684259.1471,7465425.4939);
insert into estacao_brt values(null,141,'Sambódromo',0,0,null,0,684862.0985,7465643.4965);
insert into estacao_brt values(null,142,'Terminal Presidente Vargas',0,0,null,0,686559.3857,7466207.1893);
insert into estacao_brt values(0,143,'Terminal Salvador Allende',1,1,0,0,659823.2512,7454725.5556);
insert into estacao_brt values(0,144,'Viva Viver',1,1,0,0,660533.0373,7455240.0876);
insert into estacao_brt values(0,145,'Tapebuias',1,1,0,0,661060.2058,7455719.8117);
insert into estacao_brt values(0,146,'CNEN',1,1,0,0,662080.1531,7456681.4702);
insert into estacao_brt values(0,147,'Olof Palme',1,1,0,0,663014678,7457650.3157);
insert into estacao_brt values(0,148,'Riocentro',1,1,0,0,663349.7739,7458125.8697);
insert into estacao_brt values(0,149,'Morro do Outeiro',1,1,0,0,663851.6557,7458715.8063);
insert into estacao_brt values(0,150,'Terminal Centro Olímpico',1,1,0,0,663896.3756,7458667.0087);
insert into estacao_brt values(0,151,'Minha Praia',1,1,0,0,664387.3508,7459316.0632);
insert into estacao_brt values(0,152,'Bandeirantes',1,1,0,0,664727006,7459709.5008);
insert into estacao_brt values(0,153,'Hospital Raphael de P. S.',1,1,0,0,664944.18,746056.5029);
insert into estacao_brt values(0,154,'Curicica',1,1,0,0,664944.9274,746137.5618);
insert into estacao_brt values(0,155,'Colonia',1,1,0,0,664648.2995,7462372.2026);
insert into estacao_brt values(0,156,'Outeiro Santo',1,1,0,0,664551.8682,7463557.8539);
insert into estacao_brt values(0,157,'Boiúna',1,1,0,0,664373.5388,7464876.1409);
insert into estacao_brt values(0,158,'Marechal Fontenelle',1,1,0,0,664095.9896,7468251.3602);
insert into estacao_brt values(0,159,'Marechal Mallet',1,1,0,0,663615.1812,7469374.1856);
insert into estacao_brt values(0,160,'Magalhães Bastos',1,1,0,0,662717.0295,747017.7697);
insert into estacao_brt values(0,161,'Vila Militar',1,1,1,0,664022.2312,7470840.7974);
insert into estacao_brt values(0,163,'Terminal Sulacap',1,1,0,0,664220.4598,7468441.5413);
select * from estacao_brt;


insert into linha values(1,'Linha 2',31438.0090390294);
insert into linha values(2,'Linha 1',17377.6491454839);
insert into linha values(3,'Linha 4',12129.1343418009);
select * from linha;


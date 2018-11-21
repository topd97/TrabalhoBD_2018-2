
/* Retornar o nome das estações que não foram construidas no ano de inauguração do metro
 * possui operação sobre conjuntos (diferença)
 */
use trabalhobd;

SELECT Nome, DataInauguracao
FROM Estacao_Metro
WHERE DataInauguracao not in (SELECT DISTINCT DataInauguracao 
FROM Metro INNER JOIN Estacao_Metro ON Metro.ID = Estacao_Metro.fk_empresa_metro_ID
WHERE year(Metro.inauguracao) = Estacao_Metro.DataInauguracao);

/* quantidade de estações ativas por linha de metro
 * Possui junção de três ou mais relações
 */
SELECT Linha.nome, COUNT(fk_Estacao_Metro_id) as quant
FROM Linha INNER JOIN (SELECT DISTINCT possui.fk_Estacao_Metro_id, possui.fk_Linha_ID, Estacao_Metro.Ativo
FROM possui INNER JOIN Estacao_Metro on possui.fk_Estacao_Metro_id = Estacao_Metro.id) as RelacaoEstacaoMetro
ON Linha.ID=RelacaoEstacaoMetro.fk_Linha_ID
WHERE RelacaoEstacaoMetro.Ativo = true
GROUP BY RelacaoEstacaoMetro.fk_Linha_ID;

/* Informa as estações de BRT que possuem Bicicletario
* Inclui apenas seleção e projeção
*/
SELECT Nome
FROM Estacao_Metro
WHERE Bicicletario = true;

/* Informa as estações de BRT que possuem mais de um corredor associado
 * possui função de agregação
 */
CREATE VIEW Estacao_Transferencia_BRT AS
SELECT Estacao_BRT.Nome, Corredor
FROM Estacao_BRT INNER JOIN 
(SELECT corredor.Corredor, corredor.estacaoBRTID FROM corredor INNER JOIN 
(SELECT estacaoBRTID, count(Corredor_PK) as quant FROM corredor GROUP BY estacaoBRTID HAVING quant > 1) AS quantidade
ON corredor.estacaoBRTID = quantidade.estacaoBRTID) AS estacoes
ON Estacao_BRT.id = estacoes.estacaoBRTID ORDER BY Estacao_BRT.Nome;

/*Informa quantas estações ativas cada corredor do BRT possui
* possui junção interna com duas relações
*/
CREATE VIEW BRT_Estacoes_Ativas AS
SELECT Corredor.Corredor, COUNT(Estacao_BRT.id) as QuantAtivas
FROM Corredor INNER JOIN Estacao_BRT ON Corredor.estacaoBRTID=Estacao_BRT.id
WHERE Estacao_BRT.Ativo = true
GROUP BY Corredor.Corredor_PK;

/* Informa o total de pessoas transportadas pelo metro por ano
* possui função de agregação
*/
CREATE VIEW TotalAno_Metro AS
SELECT ano, SUM(Transporta) as TotalPessoas
FROM Principal
GROUP BY ano;

/* Informa as estações de metro com integração com BRT e com qual corredor acontece esta integração
* possui junção de três ou mais relações
*/
SELECT DISTINCT Estacao_Metro_Full.id as estacaoMetroID, BRTcomMetro.estacaoBRTID, Estacao_Metro_Full.Nome, BRTcomMetro.Corredor, Estacao_Metro_Full.Linha
FROM (SELECT * FROM Estacao_Metro INNER JOIN (SELECT DISTINCT Linha.ID as idLinha, nome as Linha, EstacaoPossuiLinha.fk_estacao_metro
											FROM Linha INNER JOIN EstacaoPossuiLinha on Linha.ID = EstacaoPossuiLinha.fk_Linha) 
                                            as LinhaIDMetro on Estacao_Metro.id=LinhaIDMetro.fk_estacao_metro
                                            WHERE IntegraBRT = true) as Estacao_Metro_Full 
NATURAL INNER JOIN (SELECT Corredor.estacaoBRTID, Nome, Corredor.Corredor
						FROM Corredor NATURAL INNER JOIN (SELECT id as estacaoBRTID, Nome, integraMetro
															FROM Estacao_BRT
															WHERE integraMetro = true) AS BRTcomMetro_parcial) AS BRTcomMetro;  
/* Quantidade de estações que possuem pelo menos uma integração, quantas são por onibus, quantas são por BRT e quantas são por VLT
 * Possui função de agregação
 */
select count(*) as TotalDeIntegracao, sum(IntegraOnibus) as BUS,sum(IntegraBRT) as BRT,sum(IntegraVLT) as VLT
from estacao_metro
where IntegraOnibus = 1 or IntegraBRT = 1 or IntegraVLT = 1;

/* Exibe os anos que a quantidade de clientes do metro foi menor que a média
* subconsulta aninhada
*/
SELECT ano, TotalPessoas FROM 
(SELECT ano, SUM(Transporta) as TotalPessoas FROM Principal GROUP BY ano) AS TotalAno_Metro
WHERE TotalPessoas < (SELECT AVG(TotalPessoas)
FROM (SELECT ano, SUM(Transporta) as TotalPessoas FROM Principal GROUP BY ano) AS TotalAno_Metro2);
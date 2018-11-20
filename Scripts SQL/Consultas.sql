
/* Retornar o nome das estações que não foram construidas no ano de inauguração do metro
 * possui subconsulta aninhada
 */
use trabalhobd;

SELECT Nome, DataInauguracao
FROM Estacao_Metro
WHERE DataInauguracao not in (SELECT DISTINCT DataInauguracao 
FROM Metro INNER JOIN Estacao_Metro ON Metro.ID = Estacao_Metro.fk_empresa_metro_ID
WHERE year(Metro.inauguracao) = Estacao_Metro.DataInauguracao);

/* quantidade de estações ativas por linha de metro
 * Possui função de agregação
 */
SELECT Linha.nome, COUNT(fk_Estacao_Metro_id) as quant
FROM Linha INNER JOIN (SELECT possui.fk_Estacao_Metro_id, possui.fk_Linha_ID, Estacao_Metro.Ativo
FROM possui INNER JOIN Estacao_Metro on possui.fk_Estacao_Metro_id = Estacao_Metro.id) as RelacaoEstacaoMetro
ON Linha.ID=RelacaoEstacaoMetro.fk_Linha_ID
WHERE RelacaoEstacaoMetro.Ativo = true
GROUP BY RelacaoEstacaoMetro.fk_Linha_ID;

SELECT Nome
FROM Estacao_BRT
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

CREATE VIEW BRT_Estacoes_Ativas AS
SELECT Corredor.Corredor, COUNT(Estacao_BRT.id)
FROM Corredor INNER JOIN Estacao_BRT ON Corredor.estacaoBRTID=Estacao_BRT.id
GROUP BY Corredor.Corredor_PK
HAVING Estacao._BRT.Ativo = true;
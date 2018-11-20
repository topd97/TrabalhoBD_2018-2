
/* Retornar o nome das estações que não foram construidas no ano de inauguração do metro
 * possui subconsulta aninhada
 */
SELECT Nome, DataInauguracao
FROM Estacao_Metro
WHERE DataInauguracao not in (SELECT DISTINCT DataInauguracao 
FROM Metro INNER JOIN Estacao_Metro ON Metro.ID = Estacao_Metro.fk_empresa_metro_ID
WHERE year(Metro.inauguracao) = Estacao_Metro.DataInauguracao);

/* quantidade de estações ativas por linha de metro */
SELECT Linha.nome, COUNT(fk_Estacao_Metro_id) as quant
FROM Linha INNER JOIN (SELECT possui.fk_Estacao_Metro_id, possui.fk_Linha_ID, Estacao_Metro.Ativo
FROM possui INNER JOIN Estacao_Metro on possui.fk_Estacao_Metro_id = Estacao_Metro.id) as RelacaoEstacaoMetro
ON Linha.ID=RelacaoEstacaoMetro.fk_Linha_ID
WHERE RelacaoEstacaoMetro.Ativo = true
GROUP BY RelacaoEstacaoMetro.fk_Linha_ID;

/* daqui para frente ainda não testei by joyce*/
CREATE VIEW RioEmMovimento AS
SELECT Nome
FROM Estacao_BRT
WHERE Bicicletario = true;

CREATE VIEW Estacao_Transferencia_BRT AS
SELECT Estacao_BRT.Nome
FROM Estacao_BRT INNER JOIN (SELECT * FROM Corredor INNER JOIN Corredor as Segundo WHERE Corredor.Corredor <> Segundo.Corredor) as Tulio
ON Estacao_BRT.id = Tulio.estacaoBRTID;

CREATE VIEW BRT_Estacoes_Ativas AS
SELECT Corredor.Corredor, COUNT(Estacao_BRT.id)
FROM Corredor INNER JOIN Estacao_BRT ON Corredor.estacaoBRTID=Estacao_BRT.id
GROUP BY Corredor.Corredor_PK
HAVING Estacao._BRT.Ativo = true;
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <h3>Estações do metrô com integração com BRT e com qual corredor acontece essa integração:</h3>
        <?php
        $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");
            $estacao = mysqli_query($con, "SELECT DISTINCT Estacao_Metro_Full.id as estacaoMetroID, BRTcomMetro.estacaoBRTID, Estacao_Metro_Full.Nome, BRTcomMetro.Corredor, Estacao_Metro_Full.Linha FROM 
                                           (SELECT * FROM Estacao_Metro INNER JOIN (SELECT Linha.ID AS idLinha, nome AS Linha, EstacaoPossuiLinha.fk_estacao_metro
                                           FROM Linha INNER JOIN EstacaoPossuiLinha ON Linha.ID = EstacaoPossuiLinha.fk_Linha) AS LinhaIDMetro 
                                           ON Estacao_Metro.id=LinhaIDMetro.fk_estacao_metro
                                           WHERE IntegraBRT = true) 
                                           AS Estacao_Metro_Full 
                                           NATURAL JOIN 
                                           (SELECT Corredor.estacaoBRTID, Nome, Corredor.Corredor 
                                           FROM Corredor NATURAL JOIN (SELECT id AS estacaoBRTID, Nome, integraMetro
                                           FROM Estacao_BRT WHERE integraMetro = true) 
                                           AS BRTcomMetro_parcial) AS BRTcomMetro; ");
            
            //$estacao = mysqli_query($con, "SELECT DISTINCT Estacao_Metro_Full.id as estacaoMetroID, BRTcomMetro.estacaoBRTID, Estacao_Metro_Full.Nome, BRTcomMetro.Corredor, Estacao_Metro_Full.Linha
              //                             FROM (SELECT * FROM Estacao_Metro INNER JOIN 
                //                           (SELECT  Linha.ID AS idLinha, nome AS Linha, EstacaoPossuiLinha.fk_estacao_metro
                  //                         FROM Linha INNER JOIN EstacaoPossuiLinha ON Linha.ID = EstacaoPossuiLinha.fk_Linha) AS LinhaIDMetro ON Estacao_Metro.id=LinhaIDMetro.fk_estacao_metro
                    //                       WHERE IntegraBRT = true) AS Estacao_Metro_Full 
                      //                     NATURAL LEFT JOIN 
                        //                   (SELECT Corredor.estacaoBRTID, Nome, Corredor.Corredor
                          //                 FROM Corredor NATURAL JOIN (SELECT id as estacaoBRTID, Nome, integraMetro FROM Estacao_BRT WHERE integraMetro = true) AS BRTcomMetro_parcial) AS BRTcomMetro;  ");
       
        ?>
        <table border="black">
            <tr>
                <th>ID da estação do metro</th>
                <th>ID da estação do BRT</th>
                <th>Nome da estação do metro</th>
                <th>Corredor BRT</th>
                <th>Linha metro</th>
            </tr>
            <?php
                while ($estacaoID = mysqli_fetch_row($estacao))
                {
                    echo "<tr><td>" . htmlentities($estacaoID[0]) . "</td>";
                    echo "<td>" . htmlentities($estacaoID[1]) . "</td>";
                    echo "<td>" . htmlentities($estacaoID[2]) . "</td>";
                    echo "<td>" . htmlentities($estacaoID[3]) . "</td>";
                    echo "<td>" . htmlentities($estacaoID[4]) . "</td></tr>\n";    
                }
                mysqli_free_result($estacao);
                mysqli_close($con);
            
            
            ?>
        </table>
    </body>
</html>

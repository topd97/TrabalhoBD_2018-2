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
        <h3>nome e a quantidade total de estações ativas por cada linha do metrô</h3>
        <?php
        $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");
            $estacao = mysqli_query($con, "SELECT Linha.nome, COUNT(fk_Estacao_Metro_id) AS quant
                                           FROM Linha INNER JOIN (SELECT DISTINCT possui.fk_Estacao_Metro_id, possui.fk_Linha_ID, Estacao_Metro.Ativo
                                           FROM possui INNER JOIN Estacao_Metro ON possui.fk_Estacao_Metro_id = Estacao_Metro.id) AS RelacaoEstacaoMetro
                                           ON Linha.ID = RelacaoEstacaoMetro.fk_Linha_ID
                                           WHERE RelacaoEstacaoMetro.Ativo = true
                                           GROUP BY RelacaoEstacaoMetro.fk_Linha_ID");
        ?>
        <table border="black">
            <tr>
                <th>Linha</th>
                <th>quant</th>
            </tr>
            <?php
                while ($estacaoID = mysqli_fetch_row($estacao))
                {
                    echo "<tr><td>" . htmlentities($estacaoID[0]) . "</td>";
                    echo "<td>" . htmlentities($estacaoID[1]) . "</td></tr>\n";    
                }
                mysqli_free_result($estacao);
                mysqli_close($con);
            
            
            ?>
        </table>
    </body>
</html>

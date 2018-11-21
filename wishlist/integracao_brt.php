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
        <h3>Nome das estações com 2 ou mais corredores, em ordem alfabética
            com seus respectivos corredores listados</h3>
        <?php
        $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");
            $estacao = mysqli_query($con, "SELECT distinct Estacao_BRT.Nome, Corredor
                                           FROM Estacao_BRT INNER JOIN 
                                           (SELECT corredor.Corredor, corredor.estacaoBRTID FROM corredor INNER JOIN 
                                           (SELECT estacaoBRTID, count(Corredor_PK) as quant FROM corredor GROUP BY estacaoBRTID HAVING quant > 1) AS quantidade
                                           ON corredor.estacaoBRTID = quantidade.estacaoBRTID) AS estacoes
                                           ON Estacao_BRT.id = estacoes.estacaoBRTID ORDER BY Estacao_BRT.Nome;");
        ?>
        <table border="black">
            <tr>
                <th>Estação</th>
                <th>Corredor</th>
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

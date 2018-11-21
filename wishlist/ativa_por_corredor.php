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
            $estacao = mysqli_query($con, "SELECT corredor.Corredor, COUNT(Estacao_BRT.id)
                                           FROM corredor INNER JOIN Estacao_BRT ON Corredor.estacaoBRTID=Estacao_BRT.id
                                           WHERE Estacao_BRT.Ativo = true
                                           GROUP BY corredor.Corredor_PK;");
        ?>
        <table border="black">
            <tr>
                <th>Corredor</th>
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

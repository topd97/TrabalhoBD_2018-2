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
        <h3>Quantidade de estações do metrô que possuem pelo menos uma integração,
                    quantas são por ônibus, quantas por BRT e quantas por VLT.</h3>
        <?php
        $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");
            $estacao = mysqli_query($con, "SELECT count(*) AS TotalDeIntegracao, SUM(IntegraOnibus) AS BUS, SUM(IntegraBRT) AS BRT, SUM(IntegraVLT) AS VLT
                                           FROM estacao_metro
                                           WHERE IntegraOnibus = 1 OR IntegraBRT = 1 OR IntegraVLT = 1;");
        ?>
        <table border="black">
            <tr>
                <th>Total de Integrações</th>
                <th>Onibus</th>
                <th>BRT</th>
                <th>VLT</th>
            </tr>
            <?php
                while ($estacaoID = mysqli_fetch_row($estacao))
                {
                    echo "<tr><td>" . htmlentities($estacaoID[0]) . "</td>";
                    echo "<td>" . htmlentities($estacaoID[1]) . "</td>";
                    echo "<td>" . htmlentities($estacaoID[2]) . "</td>";
                    echo "<td>" . htmlentities($estacaoID[3]) . "</td></tr>\n";    
                }
                mysqli_free_result($estacao);
                mysqli_close($con);
            
            
            ?>
        </table>
    </body>
</html>

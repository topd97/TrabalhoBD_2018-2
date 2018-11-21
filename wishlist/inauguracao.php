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
        <h3>Ver estações do Metro inauguradas <?php echo htmlentities($_GET["quando"]);?> do metro:</h3>
        <?php
            $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");
            if($_GET["quando"]=="Junto")
            {
                $estacao = mysqli_query($con, "SELECT Nome, DataInauguracao
                                           FROM Estacao_Metro
                                           WHERE DataInauguracao in (SELECT DISTINCT DataInauguracao 
                                           FROM Metro INNER JOIN Estacao_Metro ON Metro.ID = Estacao_Metro.fk_empresa_metro_ID
                                           WHERE year(Metro.inauguracao) = Estacao_Metro.DataInauguracao);");
            }
            else
            {
                $estacao = mysqli_query($con, "SELECT Nome, DataInauguracao
                                           FROM Estacao_Metro
                                           WHERE DataInauguracao not in (SELECT DISTINCT DataInauguracao 
                                           FROM Metro INNER JOIN Estacao_Metro ON Metro.ID = Estacao_Metro.fk_empresa_metro_ID
                                           WHERE year(Metro.inauguracao) = Estacao_Metro.DataInauguracao);");
            }
            
            
            


        ?>
        <table border="black">
            <tr>
                <th>Estação</th>
                <th>Data de Inauguração</th>
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

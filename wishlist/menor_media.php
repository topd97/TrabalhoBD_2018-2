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
        <h3>Exibe os anos em que a quantidade de clientes foi <?php echo htmlentities($_GET["maior_menor"]);?> 
            do que a média</h3>
        <?php
            $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");
            if($_GET["maior_menor"]=="Menor")
            {
                $estacao = mysqli_query($con, "SELECT ano, TotalPessoas FROM 
                                               (SELECT ano, SUM(Transporta) AS TotalPessoas FROM Principal GROUP BY ano) AS TotalAno_Metro
                                               WHERE TotalPessoas < (SELECT AVG(TotalPessoas)
                                               FROM (SELECT ano, SUM(Transporta) AS TotalPessoas FROM Principal 
                                               GROUP BY ano) AS TotalAno_Metro2);");
            }
            else
            {
                $estacao = mysqli_query($con, "SELECT ano, TotalPessoas FROM 
                                               (SELECT ano, SUM(Transporta) AS TotalPessoas FROM Principal GROUP BY ano) AS TotalAno_Metro
                                               WHERE TotalPessoas > (SELECT AVG(TotalPessoas)
                                               FROM (SELECT ano, SUM(Transporta) AS TotalPessoas FROM Principal 
                                               GROUP BY ano) AS TotalAno_Metro2);");
            }
            
            
            


        ?>
        <table border="black">
            <tr>
                <th>Ano</th>
                <th>Total de pessoas</th>
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

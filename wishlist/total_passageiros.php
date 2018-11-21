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
        <h3>Quantidade de passageiros transportados do ano de <?php echo htmlentities($_GET["ano"]);?>
            , em todas as estações e linhas.</h3>
        
        <?php
            $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");



            $ano = mysqli_real_escape_string($con, htmlentities($_GET["ano"]));

            $estacao = mysqli_query($con, "SELECT ano, SUM(Transporta) AS TotalPessoas
                                           FROM possui
                                           where ano =" . $ano . "
                                           GROUP BY ano;");
            if (mysqli_num_rows($estacao) < 1) {
                exit("Não há dados sobre o ano de  " . htmlentities($_GET["ano"]));
            }
        ?>
        
        <table border="black">
            <tr>
                <th>Ano</th>
                <th>Quantidade de passageiros</th>
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

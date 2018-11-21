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
        <h3>Estações do metrô cuja estação principal não está na Linha <?php echo htmlentities($_GET["linha"])."<br/>";?></h3>
        
        <?php
            $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");


            $linha = mysqli_real_escape_string($con, htmlentities($_GET["linha"]));

            $estacao = mysqli_query($con, "SELECT Nome FROM Estacao_Metro LEFT JOIN 
                                           (SELECT fk_Estacao_Metro_id FROM Principal 
                                           WHERE Principal.fk_Linha_ID = ". $linha . ") AS Linha 
                                           ON Estacao_Metro.id = Linha.fk_Estacao_Metro_id 
                                           WHERE Linha.fk_Estacao_Metro_id IS NULL;");
        ?>
        
        <table border="black">
            <tr>
                <th>Nome</th>
            </tr>
            <?php
                while ($estacaoID = mysqli_fetch_row($estacao))
                {
                    echo "<tr><td>" . htmlentities($estacaoID[0]) . "</td></tr>";
                }
                mysqli_free_result($estacao);
                mysqli_close($con);
            
            
            ?>
        </table>
    </body>
</html>

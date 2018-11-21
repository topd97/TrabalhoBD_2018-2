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
        <h3>Estações com a utilidade <?php echo htmlentities($_GET["utilidade"])."<br/>";?></h3>
        
        <?php
            $con = mysqli_connect("localhost", "root", "nbuser");
            if (!$con) {
                exit('Connect Error (' . mysqli_connect_errno() . ') '
                       . mysqli_connect_error());
            }
            //set the default client character set 
            mysqli_set_charset($con, 'utf-8');

            mysqli_select_db($con, "trabalhobd");



            $utilidade = mysqli_real_escape_string($con, htmlentities($_GET["utilidade"]));

            $estacao = mysqli_query($con, "SELECT Nome,id FROM estacao_metro WHERE " . $utilidade. " = 1");
            if (mysqli_num_rows($estacao) < 1) {
                exit("não existem estações de metro com  " . htmlentities($_GET["utilidade"]) . ", ou o nome da utilidade foi digitada errado");
            }
        ?>
        
        <table border="black">
            <tr>
                <th>Estação</th>
                <th>Id</th>
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
    
    <script>
        console.log("oi")
    </script>
</html>

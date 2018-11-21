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
        <h2> Uma consulta envolvendo apenas as operações de seleção e projeção </h2>
        <form name="utilidade" action="wishlist.php">
            Pesquisar estações do metro com utilidade:<select name="utilidade">
                                                            <option>Bicicletario</option>
                                                            <option>FlgAtm</option>
                                                            <option>elevador</option>
                                                            <option></option>
                                                        </select>
            <input type="submit" value="Go" />
        </form>
        <br>
        <h2>Duas consultas envolvendo a junção de apenas duas relações, sendo que uma deve conter junção externa</h2>
        
        <ul>
            <li>
                
                <h4>Total de Estações Ativas por Corredor</h4>
                <form name="ativa_por_corredor" action="ativa_por_corredor.php">
                    a consulta retorna o nome do corredor 
                    e a quantidade de estações ativas por onde cada uma passa.
                    <br>
                    <input name="" type= "submit" value="Ver" />
                </form>
                
            </li>
            <li>
                <h4>Estações do metrô cuja estação principal não está na Linha X</h4>
                <form name="nao_linha" action="nao_linha.php">
                    Retorna os nomes das estações do metrô cuja estação principal não é a Linha .
                    <br>
                    <select name="linha">
                        <option value='1'>1</option>
                        <option value='2'>2</option>
                        <option value='3'>4</option>
                    </select>
                    <input name="" type= "submit" value="Ver" />
                </form>
            </li>
        </ul>
        
        <h2>Duas consultas envolvendo a junção de três ou mais relações</h2>
        
        <ul>
            <li>
                <h4>Quantidade Estações Ativas por Linha:</h4>
                <form name="ativa_por_linha" action="ativa_por_linha.php">
                    A consulta retorna o nome e a quantidade total de estações ativas por cada linha do metrô
                    <br>
                    <input name="" type= "submit" value="Ver" />
                </form>
                
            
            </li>
            <li>
                <h4> Estação do metro com integração com brt e qual corredor </h4>
                <form name="integracao_metro_brt" action="integracao_metro_brt.php">
                    Informa as estações do metrô com integração com BRT e com qual corredor acontece essa integração
                    <br>
                    <input name="" type= "submit" value="Ver" />
                </form>
            </li>
        </ul>

        
        <h2>Uma consulta envolvendo uma das operações sobre conjuntos (união, diferença ou intersecção)</h2>
        
        <form name="inauguracao" action="inauguracao.php">
            Ver estações do Metro inauguradas 
            <select name="quando">
                <option>Junto</option>
                <option>Separado</option>
            </select>
            do metro:
            <br>
            <input name="inicial" type= "submit" value="Ver" />
        </form>
        
        <h2>Três consultas envolvendo funções de agregação</h2>
        <ul>
            <li>
                <h4>Estações de Integração BRT</h4>
                <form name="integracao_brt" action="integracao_brt.php">
                    Nome das estações com 2 ou mais corredores, em ordem alfabética
                    com seus respectivos corredores listados
                    <br>
                    <input name="" type= "submit" value="Ver" />
                </form>
            </li>
            <li>
                <h4>Total de passageiros por ano</h4>
                
                <form name="total_passageiros" action="total_passageiros.php">
                    Calcula o total de passageiros transportados do ano de <input type="text" name="ano" value="" size = "3"/>
                    , em todas as estações e linhas.
                    <br>
                    
                    <input name="" type= "submit" value="Ver" />
                </form>
            </li>
            <li>
                <h4> Quantidade de integrações </h4>
                <form name="quant_integracoes" action="quant_integracoes.php">
                    Quantidade de estações do metrô que possuem pelo menos uma integração,
                    quantas são por ônibus, quantas por BRT e quantas por VLT.
                    <br>
                    
                    <input name="" type= "submit" value="Ver" />
                </form>
            </li>
        </ul>
        <h2>Uma consulta envolvendo subconsultas aninhadas </h2>
            <form name="menor_media" action="menor_media.php">
                Exibe os anos em que a quantidade de clientes foi 
                <select name="maior_menor">
                    <option>Maior</option>
                    <option>Menor</option>
                </select> do que a média
                <br>
                
                <input name="" type= "submit" value="Ver" />
            </form>

        
    </body>
</html>

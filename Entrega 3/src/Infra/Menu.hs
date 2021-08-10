module Infra.Menu where

menu :: IO ()
menu = do
putStrLn"--------------Champions League--------------"
putStrLn"Selecione uma das opções abaixo:"
putStrLn""
putStrLn"1. Listar estatísticas de um time"
putStrLn"2. Classificação de um time"
putStrLn"3. Aproveitamento"
putStrLn"4. Saldo de gols"
putStrLn"5. Resultado por rodada do time"
putStrLn"6. Número de pontos"
putStrLn"7. Três primeiros colocados"
putStrLn"8. Times rebaixados"
putStrLn"9. Classificação do campeonato"
putStrLn"0. Sair"
putStrLn ("")
putStrLn ("Digite a opção a ser escolhida: ")
option <- getLine
select option

--função que recebe a opção digitada pelo usuário e retorna de acordo com a opção escolhida
select :: Int -> Function
select option = do
    case option of
        1 -> getStatistics
        2 -> getRanking
        3 -> getPerformance
        4 -> getGoals
        5 -> getResult
        6 -> getPoints
        7 -> getTopTree
        8 -> getRelegateds
        9 -> getGeneralRanking
        0 -> exit
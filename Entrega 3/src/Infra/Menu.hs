module Infra.Menu where

import System.IO ()

putStrLn"--------------Campeonato de Várzea--------------"
putStrLn"Digite a opção desejada:"
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
option <- getLine
select option

--função que recebe a opção digitada pelo usuário e retorna de acordo com a opção escolhida
select :: Int -> IO Function
select option = do
    case option of
        "1" -> do getStatistics
        "2" -> do getRanking
        "3" -> do getPerformance
        "4" -> do getGoals
        "5" -> do getResult
        "6" -> do getPoints
        "7" -> do getTopTree
        "8" -> do getRelegateds
        "9" -> do getGeneralRanking
        "0" -> exit :: IO ()
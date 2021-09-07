module Presentation.Menu where

import Business.MatchHandler
import Domain.Match
import Domain.TeamResults
import Text.Read

menu :: IO ()
menu = do
    putStrLn "--------------Champions League--------------"
    putStrLn "Selecione uma das opções abaixo:"
    putStrLn ""
    putStrLn "1. Listar estatísticas de um time"
    putStrLn "2. Classificação de um time"
    putStrLn "3. Aproveitamento"
    putStrLn "4. Saldo de gols"
    putStrLn "5. Resultado por rodada do time"
    putStrLn "6. Número de pontos"
    putStrLn "7. Três primeiros colocados"
    putStrLn "8. Times rebaixados"
    putStrLn "9. Classificação do campeonato"
    putStrLn "0. Sair"
    putStrLn ""
    putStrLn "Digite a opção a ser escolhida: "
    option <- getLine
    selectOption option

selectOption :: String -> IO ()
selectOption option = do
    case option of
        "1" -> do 
            listTeamStatistics
            menu
        "2" -> do
            showTeamClassification
            menu
        "3" -> do
            showTeamEnjoyment
            menu
        "4" -> do
            showGoalsBalance
            menu
        "5" -> do
            showTeamResultByRound
            menu
        "6" -> do
            showPointsNumber
            menu
        "7" -> do
            showTopThreeInChampionship
            menu
        "8" -> do
            showDowsGradedTeams
            menu
        "9" -> do
            showOverAllClassification
            menu
        "0" -> putStrLn "Até mais!"
        _ -> menu


listTeamStatistics :: IO ()
listTeamStatistics = do
    putStrLn "Digite o nome do time"
    team <- getLine
    (win, draw, loss) <- getMatchesResultsByTeamInChampionship team
    putStrLn ""
    putStrLn ("Vitórias: " ++ show win)
    putStrLn ("Empates: " ++ show draw)
    putStrLn ("Derrotas: " ++ show loss)

showTeamClassification :: IO ()
showTeamClassification = do
    putStrLn "Digite o nome do time"
    team <- getLine
    classfication <- getClassificationByTeamInChampionship team
    putStrLn ""

    putStrLn ("O " ++ team ++" ficou na posição " ++ (show classfication))

showTeamEnjoyment :: IO ()
showTeamEnjoyment = do
    putStrLn "Digite o nome do time"
    team <- getLine
    enjoyment <- getEnjoymentByTeamInChampionship team
    putStrLn ""

    if isNaN enjoyment
    then putStrLn ("O time " ++ team ++ " não está no campeonato!")
    else putStrLn ("O aproveitamento do " ++ team ++ " é de " ++ (show enjoyment) ++ "%")

showGoalsBalance :: IO ()
showGoalsBalance = do
    putStrLn "Digite o nome do time"
    team <- getLine
    balance <- getGoalBalanceByTeamInChampionship team
    putStrLn ""

    putStrLn ("O saldo de gols do " ++ team ++ " é de " ++ (show balance))

showTeamResultByRound :: IO ()
showTeamResultByRound = do
    putStrLn "Digite o nome do time"
    team <- getLine
    putStrLn "Digite a rodada"
    strRound <- getLine
    let round = readMaybe strRound :: Maybe Int

    case round of
        Just r -> do
            results <- getMatchesResultsByRoundAndByTeamInChampionship r team
            putStrLn ""

            putStrLn ("As partidas da rodada " ++ (show r) ++ " foram:")
            putStrLn ""
            showMatchList (reverse results)
        Nothing -> putStrLn "Número inválido"

showMatchList :: [Match] -> IO ()
showMatchList [] = do
    putStr ""
showMatchList (h:t) = do
    showMatchList t

    putStrLn ("rodada: " ++ (show (currentRound h)) ++ " - " ++ principalTeam h ++ " " ++ (show (principalGoals h)) ++ ":" ++ (show (strangerGoals h)) ++ " " ++ strangerTeam h)

showPointsNumber :: IO ()
showPointsNumber = do
    putStrLn "Digite o nome do time"
    team <- getLine
    points <- getTotalPointsByTeamInChampionship team
    putStrLn ""

    putStrLn ("O " ++ team ++ " fez " ++ (show points) ++ " pontos no campeonato")

showTopThreeInChampionship :: IO ()
showTopThreeInChampionship = do
    winers <- getTopClassificationInChampionship 3

    putStrLn "Os três primeiros times no campeonato são: "
    putStrLn ""
    showTeamResultsList (reverse winers)

showDowsGradedTeams :: IO ()
showDowsGradedTeams = do
    downGraded <- getTeamRelegatedsInChampionship

    putStrLn "Os times rebaixados foram"
    putStrLn ""
    showTeamResultsList downGraded

showTeamResultsList :: [TeamResults] -> IO ()
showTeamResultsList [] = do
    putStr ""
showTeamResultsList (h:t) = do
    showTeamResultsList t

    putStr ((show (classification h)) ++ ", " ++ name h ++ ", pontos: ")
    putStr ((show (totalPoints h)) ++ ", vitórias: " ++ (show (victories h)))
    putStr (", empates: " ++ (show (draws h)) ++ ", derrotas: " ++ (show (loss h)))
    putStr (", gols pro: " ++ (show (goalsFor h)) ++ ", gols contra: " ++ (show (goalsAgainst h)))
    putStr (", saldo de gols: " ++ (show (goalsDifference h)))
    putStrLn ""

showOverAllClassification :: IO ()
showOverAllClassification = do
    classification <- getClassification

    putStrLn "A classificação geral é"
    putStrLn ""
    showTeamResultsList (reverse classification)
module Presentation.Menu where

import Business.MatchHandler
import Domain.Match
import Domain.TeamResults

main = do
    menu

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
    putStrLn ""
    putStrLn ("Digite a opção a ser escolhida: ")
    option <- getLine
    putStrLn ""

    if option == "1" 
    then do
        listTeamStatistics
        menu
    else if option == "2"
    then do 
        showTeamClassification
        menu
    else if option == "3"
    then do 
        showTeamEnjoyment
        menu
    else if option == "4"
    then do 
        showGoalsBalance
        menu
    else if option == "5"
    then do 
        showTeamResultByRound
        menu
    else if option == "6"
    then do 
        showPointsNumber
        menu
    else if option == "7"
    then do 
        menu
    else if option == "8"
    then do
        showDowsGradedTeams
        menu
    else if option == "9"
    then do 
        showOverAllClassification
        menu
    else if option == "0"
    then putStrLn "Até mais"
    else menu


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
    let round = read strRound
    results <- getMatchesResultsByRoundAndByTeamInChampionship round team
    putStrLn ""

    putStrLn ("As partidas da rodada " ++ (show round) ++ " foram...")
    putStrLn ""
    showMatchList (reverse results)

showMatchList :: [Match] -> IO ()
showMatchList [] = do
    putStrLn ""
showMatchList (h:t) = do
    showMatchList t

    putStrLn (principalTeam h ++ " " ++ (show (principalGoals h)) ++ ":" ++ (show (strangerGoals h)) ++ " " ++ strangerTeam h)

showPointsNumber :: IO ()
showPointsNumber = do
    putStrLn "Digite o nome do time"
    team <- getLine
    points <- getTotalPointsByTeamInChampionship team
    putStrLn ""

    putStrLn ("O " ++ team ++ " fez " ++ (show points) ++ " pontos no campeonato")

showDowsGradedTeams :: IO ()
showDowsGradedTeams = do
    downGraded <- getTeamRelegatedsInChampionship

    putStrLn "Os times rebaixados foram"
    putStrLn ""

    showTeamResultsList (reverse downGraded)

showTeamResultsList :: [TeamResults] -> IO ()
showTeamResultsList [] = do
    putStrLn ""
showTeamResultsList (h:t) = do
    showTeamResultsList t

    putStrLn ((show (classification h)) ++ ", " ++ name h ++ ", pontos - " ++ (show (totalPoints h)) ++ ", vitórias: " ++ (show (victories h)) ++ ", empates: " ++ (show (draws h)) ++ ", derrotas: " ++ (show (loss h)))

showOverAllClassification :: IO ()
showOverAllClassification = do
    classification <- getClassification

    putStrLn "A classificação geral é"
    putStrLn ""

    showTeamResultsList (reverse classification)
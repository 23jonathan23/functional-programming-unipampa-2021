module Business.Utils.SuportFunctions where

import Domain.Match
import Domain.TeamResults

--Retornar o saldo de gols da partida de um determinado time
getGoalsOfMatchByTeam :: String -> Match -> Int
getGoalsOfMatchByTeam teamName teamMatch
    | principalTeam teamMatch == teamName = principalGoals teamMatch
    | strangerTeam teamMatch == teamName = strangerGoals teamMatch
    | otherwise = 0

--Soma o total de gols de um determinado time
sumGoalsByTeam :: String -> [Match] -> Int
sumGoalsByTeam teamName teamMatches = 
    foldl (\accumulator match -> accumulator + getGoalsOfMatchByTeam teamName match) 0 teamMatches

--Retorna somente as partidas de um determinado time
filterMatchesByTeam :: String -> [Match] -> [Match]
filterMatchesByTeam teamName [] = []
filterMatchesByTeam teamName matches = filter (\match -> principalTeam match == teamName || strangerTeam match == teamName) matches

--Retorna somente as partidas de um determinado time
filterMatchesByRound :: Int -> [Match] -> [Match]
filterMatchesByRound round [] = []
filterMatchesByRound round matches = filter (\match -> currentRound match == round || currentRound match == round) matches

--Retonar as partidas de um determinado time
getTeamResultsByTeam :: String -> [Match] -> TeamResults
getTeamResultsByTeam teamName matches = do
    let teamMatches = filterMatchesByTeam teamName matches
    
    let goalBalance = sumGoalsByTeam teamName teamMatches

    --let classification
    --let victories
    --let loss
    --let draws

    TeamResults teamName goalBalance 0 0 0 0


updateWin :: (Int, Int, Int) -> (Int, Int, Int)
updateWin (win, a, b) = (win + 1, a, b)

updateDraw :: (Int, Int, Int) -> (Int, Int, Int)
updateDraw (a, draw, b) = (a, draw + 1, b)

updateLoss :: (Int, Int, Int) -> (Int, Int, Int)
updateLoss (a, b, loss) = (a, b, loss + 1)
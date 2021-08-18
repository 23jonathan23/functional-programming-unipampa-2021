module Business.Utils.SuportFunctions where

import Domain.Match
import Domain.TeamResults

--Retorna o apriveitamento de um determinado time no campeonato
getTotalEnjoyment :: (Int, Int, Int) -> Float
getTotalEnjoyment (win, draw, loss) = 100 * fromIntegral (win * 3 + draw) / fromIntegral (getTotalMatches (win, draw, loss) * 3)

--Retorna a soma dos três valores da tupla
getTotalMatches :: (Int, Int, Int) -> Int
getTotalMatches (a, b, c) = a + b + c

--Retorna as vitórias, espates e derrotas de um determinado time
getMatchesResultsByTeam :: String -> [Match] -> (Int, Int, Int)
getMatchesResultsByTeam teamName [] = (0, 0, 0)
getMatchesResultsByTeam teamName (match:t)
    | principalTeam match == teamName && principalGoals match > strangerGoals match = updateWin (getMatchesResultsByTeam teamName t)
    | principalTeam match == teamName && principalGoals match < strangerGoals match = updateLoss (getMatchesResultsByTeam teamName t)
    | principalTeam match == teamName = updateDraw (getMatchesResultsByTeam teamName t)
    | strangerTeam match == teamName && strangerGoals match > principalGoals match = updateWin (getMatchesResultsByTeam teamName t)
    | strangerTeam match == teamName && strangerGoals match < principalGoals match = updateLoss (getMatchesResultsByTeam teamName t)
    | strangerTeam match == teamName = updateDraw (getMatchesResultsByTeam teamName t)
    | otherwise = getMatchesResultsByTeam teamName t

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

--Retorna somente as partidas de uma determinada rodada
filterMatchesByRound :: Int -> [Match] -> [Match]
filterMatchesByRound round [] = []
filterMatchesByRound round matches = filter (\match -> currentRound match == round || currentRound match == round) matches

--Retonar os resultados de um determinado time
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
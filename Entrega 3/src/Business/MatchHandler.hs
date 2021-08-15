module Business.MatchHandler where

import Business.Utils.SuportFunctions
import Domain.Match
import Domain.TeamResults

import Infra.Repositories.MatchRepository

dataByTeam :: [Match] -> String -> (Int, Int, Int)
dataByTeam [] name = (0, 0, 0)
dataByTeam (match:t) name
    | principalTeam match == name && principalGoals match > strangerGoals match = updateWin (dataByTeam t name)
    | principalTeam match == name && principalGoals match < strangerGoals match = updateLoss (dataByTeam t name)
    | principalTeam match == name = updateDraw (dataByTeam t name)
    | strangerTeam match == name && strangerGoals match > principalGoals match = updateWin (dataByTeam t name)
    | strangerTeam match == name && strangerGoals match < principalGoals match = updateLoss (dataByTeam t name)
    | strangerTeam match == name = updateDraw (dataByTeam t name)
    | otherwise = (dataByTeam t name)

--Retorna o saldo de gols de um determinado time // Requisito 4
getGoalBalanceByTeam :: String -> IO Int
getGoalBalanceByTeam teamName = do
    matches <- getMatches

    let teamResults = getTeamResultsByTeam teamName matches

    return (goals teamResults)


--Retorna os resultados das partidas de uma determinada rodada 
-- e de um determinado time // Requisito 5
getMatchesResultsByRoundAndByTeam :: Int -> String -> IO [Match]
getMatchesResultsByRoundAndByTeam round teamName = do
    matches <- getMatches

    let teamMatches = filterMatchesByTeam teamName matches

    let teamMatchesByRound = filterMatchesByRound round teamMatches

    return teamMatchesByRound

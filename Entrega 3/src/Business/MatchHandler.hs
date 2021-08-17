module Business.MatchHandler where

import Business.Utils.SuportFunctions
import Domain.Match
import Domain.TeamResults

import Infra.Repositories.MatchRepository

--Retorna as vitórias, espates e derrotas de um determinado time // requisito 1
getTeamResultsInChampionship :: String -> IO (Int, Int, Int)
getTeamResultsInChampionship team = do
    matches <- getMatches

    let teamData = dataByTeam matches team

    return teamData

--Retorna o apriveitamento de um determinado time no campeonato // requisito 3
getEnjoyment :: String -> IO Float
getEnjoyment team = do
    results <- getTeamResultsInChampionship team

    let enjoyment = getTotalEnjoyment results

    return enjoyment

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

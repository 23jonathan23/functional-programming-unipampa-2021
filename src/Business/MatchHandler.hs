module Business.MatchHandler where

import Business.Utils.SuportFunctions
import Domain.Match
import Domain.TeamResults

import Infra.Repositories.MatchRepository

--Retorna as vitórias, espates e derrotas de um determinado time // requisito 1
getMatchesResultsByTeamInChampionship :: String -> IO (Int, Int, Int)
getMatchesResultsByTeamInChampionship teamName = do
    matches <- getMatches

    let teamResults = getTeamResultsByTeam teamName matches

    return (victories teamResults, draws teamResults, loss teamResults)

--Retorna o saldo a classificação de um determinado time no campeonato // requisito 2
getClassificationByTeamInChampionship :: String -> IO Int
getClassificationByTeamInChampionship teamName = do
    matches <- getMatches

    let teamResults = getTeamResultsWithClassification matches

    let teamResultsByTeam = filterTeamResultsByTeam teamName teamResults

    return (classification teamResultsByTeam)

--Retorna o aproveitamento de um determinado time no campeonato // requisito 3
getEnjoymentByTeamInChampionship :: String -> IO Float
getEnjoymentByTeamInChampionship teamName = do
    results <- getMatchesResultsByTeamInChampionship teamName

    let enjoyment = getTotalEnjoyment results

    return enjoyment

--Retorna o saldo de gols de um determinado time // requisito 4
getGoalBalanceByTeamInChampionship :: String -> IO Int
getGoalBalanceByTeamInChampionship teamName = do
    matches <- getMatches

    let teamResults = getTeamResultsByTeam teamName matches

    return (goalsDifference teamResults)


--Retorna os resultados das partidas de uma determinada rodada 
-- e de um determinado time // requisito 5
getMatchesResultsByRoundAndByTeamInChampionship :: Int -> String -> IO [Match]
getMatchesResultsByRoundAndByTeamInChampionship round teamName = do
    matches <- getMatches

    let teamMatches = filterMatchesByTeam teamName matches

    let teamMatchesByRound = filterMatchesByRound round teamMatches

    return teamMatchesByRound

--Retorna o total de pontos de um determinado time no campeonato // requisito 6
getTotalPointsByTeamInChampionship :: String -> IO Int
getTotalPointsByTeamInChampionship teamName = do
    matches <- getMatches

    let teamResults = getTeamResultsByTeam teamName matches

    return (totalPoints teamResults)

-- Retorna a classificação até o "top" passado como parametro // requisito 7
getTopClassificationInChampionship :: Int -> IO [TeamResults]
getTopClassificationInChampionship top = do
    matches <- getMatches

    let teamResults = getTeamResultsWithClassification matches

    let topClassificationInChampionship = filterTeamByTop top teamResults

    return topClassificationInChampionship

--Retorna os times rebaixados // requisito 8
getTeamRelegatedsInChampionship :: IO [TeamResults]
getTeamRelegatedsInChampionship = do
    matches <- getMatches

    let teamResults = getTeamResultsWithClassification matches

    let relegateds = getTeamRelegateds teamResults

    return relegateds

--Retorna a classificação geral dos times // requisito 9
getClassification :: IO [TeamResults]
getClassification = do

    matches <- getMatches

    let results = getTeamResultsWithClassification matches

    return results

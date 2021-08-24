{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Business.Utils.SuportFunctions where

import Domain.Match
import Domain.TeamResults

import Infra.Repositories.MatchRepository

import Data.List
import Data.Ord
import Data.Maybe

import qualified GHC.Real as Maybe

--Ordena a lista em ordem asc com base no total de pontos
sortAscTeamResultsByPoints :: [TeamResults] -> [TeamResults]
sortAscTeamResultsByPoints = sortBy (comparing totalPoints)

--Ordena a lista em ordem desc com base no total de pontos
sortDescTeamResultsByPoints :: [TeamResults] -> [TeamResults]
sortDescTeamResultsByPoints teamResults = do
    let sortedAscTeamResults = sortAscTeamResultsByPoints teamResults

    let sortedDescTeamResults = reverse sortedAscTeamResults

    sortedDescTeamResults

--Retorna a posição que os resulstados de um time se encontram dentro da lista
getTeamResultsIndex :: Int -> TeamResults -> [TeamResults] -> Int
getTeamResultsIndex index singleTeamResults (head:tail)
    | name singleTeamResults == name head = index
    | otherwise = getTeamResultsIndex (index + 1) singleTeamResults tail

--Remove elementos duplicados da lista
removeDuplicateElementsInList :: (Eq dataType) => [dataType] -> [dataType]
removeDuplicateElementsInList [] = []
removeDuplicateElementsInList (head:tail)
    | head `elem` tail = nub tail
    | otherwise = head : nub tail

--Retorna os resultados com a nova classification
changeClassificationFieldFromTeamResults:: Int -> TeamResults -> TeamResults
changeClassificationFieldFromTeamResults newClassification  
    (TeamResults classification name totalPoints victories draws loss goalsFor goalsAgainst goalsDifference) = 
        TeamResults newClassification name totalPoints victories draws loss goalsFor goalsAgainst goalsDifference

--Retorna o total de pontos com base nas vitórias e empates de um time
getTotalPointsInChampionship :: (Int, Int) -> Int
getTotalPointsInChampionship (victories, draws) = do
    let totalPoints = (victories * 3) + draws

    totalPoints

--Retorna os nomes dos times que estão participando no campeonato
getTeamNames:: [Match] -> [String]
getTeamNames matches = do 
   let duplicateTeamNames = foldl (\accumulator match -> accumulator ++ [principalTeam match, strangerTeam match]) [] matches
   
   let teamNames = removeDuplicateElementsInList duplicateTeamNames

   teamNames

--Retorna o aproveitamento de um determinado time no campeonato
getTotalEnjoyment :: (Int, Int, Int) -> Float
getTotalEnjoyment (win, draw, loss) = 100 * fromIntegral (win * 3 + draw) / fromIntegral (getTotalMatches (win, draw, loss) * 3)

--Retorna a soma dos três valores da tupla
getTotalMatches :: (Int, Int, Int) -> Int
getTotalMatches (a, b, c) = a + b + c

--Retorna as vitórias, empates e derrotas de um determinado time
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
getGoalsForByTeam :: String -> Match -> Int
getGoalsForByTeam teamName teamMatch
    | principalTeam teamMatch == teamName = principalGoals teamMatch
    | strangerTeam teamMatch == teamName = strangerGoals teamMatch
    | otherwise = 0

getGoalsAgainstByTeam :: String -> Match -> Int
getGoalsAgainstByTeam teamName teamMatch = do
    let goalAgainst = principalGoals teamMatch - strangerGoals teamMatch

    goalAgainst

sumGoalsAgainstByTeam :: String -> [Match] -> Int
sumGoalsAgainstByTeam teamName teamMatches =
    foldl (\accumulator match -> accumulator + getGoalsAgainstByTeam teamName match) 0 teamMatches

--Soma o total de gols de um determinado time Int
sumGoalsForByTeam :: String -> [Match] -> Int
sumGoalsForByTeam teamName teamMatches = 
    foldl (\accumulator match -> accumulator + getGoalsForByTeam teamName match) 0 teamMatches

--Retorna somente as partidas de um determinado time
filterMatchesByTeam :: String -> [Match] -> [Match]
filterMatchesByTeam teamName [] = []
filterMatchesByTeam teamName matches = filter (\match -> principalTeam match == teamName || strangerTeam match == teamName) matches

--Retorna somente as partidas de uma determinada rodada
filterMatchesByRound :: Int -> [Match] -> [Match]
filterMatchesByRound round [] = []
filterMatchesByRound round matches = filter (\match -> currentRound match == round || currentRound match == round) matches

--Retorna somente os resultados de um determinado time
filterTeamResultsByTeam :: String -> [TeamResults] -> TeamResults
filterTeamResultsByTeam teamName teamResults = head (filter (\teamResults -> teamName == name teamResults) teamResults)

--Retorna a classificação até o "top" especificado como parametro
filterTeamByTop :: Int -> [TeamResults] -> [TeamResults]
filterTeamByTop top [] = []
filterTeamByTop top teamResults = filter (\teamResults -> classification teamResults <= top) teamResults

--Retonar os resultados de um determinado time
getTeamResultsByTeam :: String -> [Match] -> TeamResults
getTeamResultsByTeam teamName matches = do
    let teamMatches = filterMatchesByTeam teamName matches
    
    let (victories, draws, loss) = getMatchesResultsByTeam teamName teamMatches
   
    let totalPoints = getTotalPointsInChampionship (victories, draws)
    
    let goalsFor = sumGoalsForByTeam teamName teamMatches

    let goalsAgainst = sumGoalsAgainstByTeam teamName teamMatches

    let goalsDifference = goalsFor - goalsAgainst

    TeamResults 0 teamName totalPoints victories draws loss goalsFor goalsAgainst goalsDifference

--Retorna os resultados de todos os times com a classificação
getTeamResultsWithClassification :: [Match] -> [TeamResults]
getTeamResultsWithClassification [] = []
getTeamResultsWithClassification matches = do
    let teamNames = getTeamNames matches

    let teamResults = foldl (\accumulator teamName -> accumulator ++ [getTeamResultsByTeam teamName matches]) [] teamNames

    let sortedTeamResults = sortDescTeamResultsByPoints teamResults

    let teamResultsWithClassification = map (\teamResults -> changeClassificationFieldFromTeamResults (getTeamResultsIndex 1 teamResults sortedTeamResults) teamResults) sortedTeamResults
    
    teamResultsWithClassification

updateWin :: (Int, Int, Int) -> (Int, Int, Int)
updateWin (win, a, b) = (win + 1, a, b)

updateDraw :: (Int, Int, Int) -> (Int, Int, Int)
updateDraw (a, draw, b) = (a, draw + 1, b)

updateLoss :: (Int, Int, Int) -> (Int, Int, Int)
updateLoss (a, b, loss) = (a, b, loss + 1)
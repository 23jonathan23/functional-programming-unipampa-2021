module Infra.Repositories.MatchRepository where

import System.IO ()
import Domain.Match

--Responsével por fazer a leitura dos dados do arquivo
readDataBase :: IO [String]
readDataBase = do
                contents <- readFile "/home/evandro/Documentos/GitHub/grupo-2/Entrega 3/src/Infra/DataBase/database.txt"
                
                let fileLines = lines contents

                return fileLines

--Separa os dados contidos na linha pelo delimitador
splitByDelimiter :: Char -> String -> [String]
splitByDelimiter _ "" = []
splitByDelimiter delimiter str = 
    let (start, rest) = break (== delimiter) str
        (_, remain) = span (== delimiter) rest
     in start : splitByDelimiter delimiter remain

--Converte as linhas do arquivo para a estrutura personalizada "Partida"
parseToMatch :: [String] -> [Match]
parseToMatch [] = []
parseToMatch fileLines = map (\line -> parseLineToMatch (splitByDelimiter ';' line)) fileLines

parseLineToMatch :: [String] -> Match
parseLineToMatch line = Match (read (head line)) (line !! 1) (read (line !! 2)) (line !! 3) (read (line !! 4))

--Orquestra a operação e retorna a lista de "Partidas"
getMatches :: IO [Match]
getMatches = do
    fileLines <- readDataBase
    
    let matches = parseToMatch fileLines

    return matches
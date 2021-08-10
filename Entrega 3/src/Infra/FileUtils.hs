module Infra.FileUtils where

import System.IO ()
import Domain.Match

readDataBase :: IO [Match]
readDataBase = do
                contents <- readFile "Infra\\DataBase\\database.txt"
                
                let linesFile = lines contents
                
                return (parseToMatch linesFile)

splitByDelimiter :: Char -> String -> [String]
splitByDelimiter _ "" = []
splitByDelimiter delimiter str = 
    let (start, rest) = break (== delimiter) str
        (_, remain) = span (== delimiter) rest
     in start : splitByDelimiter delimiter remain

parseToMatch :: [String] -> [Match]
parseToMatch [] = []
parseToMatch (h:t) = parseLineToMatch (splitByDelimiter ';' h) : parseToMatch t

parseLineToMatch :: [String] -> Match
parseLineToMatch line = Match (read (line !! 0)) (line !! 1) (read (line !! 2)) (line !! 3) (read (line !! 4))
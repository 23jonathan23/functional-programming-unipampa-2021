module Infra.FileUtils where

import System.IO ()
import Domain.Match

readDataBase :: IO [String]
readDataBase = do
                contents <- readFile "src\\Infra\\DataBase\\database.txt"
                
                let linesFile = lines contents
                
                return  linesFile

splitByDelimiter :: Char -> String -> [String]
splitByDelimiter _ "" = []
splitByDelimiter delimiter str = 
    let (start, rest) = break (== delimiter) str
        (_, remain) = span (== delimiter) rest
     in start : splitByDelimiter delimiter remain

-- parseToMatch :: [String] -> [Match]
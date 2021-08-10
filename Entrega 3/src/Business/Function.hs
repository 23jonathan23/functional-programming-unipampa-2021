module Business.Function where

import Domain.Match
import Infra.FileUtils

dataByTeam :: [Match] -> String -> (Int, Int, Int)

dataByTeam [] name = (0, 0, 0)
dataByTeam (h:t) name
    | principalTeam h == name && principalGoals h > strangerGoals h = updateWin (dataByTeam t name)
    | principalTeam h == name && principalGoals h < strangerGoals h = updateLoss (dataByTeam t name)
    | principalTeam h == name = updateDraw (dataByTeam t name)
    | strangerTeam h == name && strangerGoals h > principalGoals h = updateWin (dataByTeam t name)
    | strangerTeam h == name && strangerGoals h < principalGoals h = updateLoss (dataByTeam t name)
    | strangerTeam h == name = updateDraw (dataByTeam t name)
    | otherwise = (dataByTeam t name)

updateWin :: (Int, Int, Int) -> (Int, Int, Int)
updateWin (win, a, b) = (win + 1, a, b)

updateDraw :: (Int, Int, Int) -> (Int, Int, Int)
updateDraw (a, draw, b) = (a, draw + 1, b)

updateLoss :: (Int, Int, Int) -> (Int, Int, Int)
updateLoss (a, b, loss) = (a, b, loss + 1)
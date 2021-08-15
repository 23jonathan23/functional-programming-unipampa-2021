module Domain.Match where

data Match = Match {
    currentRound::Int,
    principalTeam::String,
    principalGoals::Int,
    strangerTeam::String,
    strangerGoals::Int
} deriving Show
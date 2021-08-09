module Domain.Match where

data Match = Match { 
    currentMatch::Int,
    principalTeam::String,
    principalGoals::Int,
    strangerTeam::String,
    strangerGoals::Int
} deriving Show
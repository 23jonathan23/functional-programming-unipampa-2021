module Domain.TeamResults where

data TeamResults = TeamResults { 
    classification::Int,
    name::String,
    totalPoints::Int,
    victories::Int,
    draws::Int,
    loss::Int,
    goalsFor::Int,
    goalsAgainst::Int,
    goalsDifference::Int
} deriving Show
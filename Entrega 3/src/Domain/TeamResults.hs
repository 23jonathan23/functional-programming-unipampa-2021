module Domain.TeamResults where

data TeamResults = TeamResults { 
    name::String,
    goals::Int,
    classification::Int,
    victories::Int,
    loss::Int,
    draws::Int,
    totalPoints::Int
} deriving Show
module Main where

import qualified Nim  

type Board = [Int]

initial :: Board
initial = [5,4,3,2,1]

main :: IO ()
main = Nim.play initial 1 

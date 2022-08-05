module Nim (startNim) where
import Board 
import Text.Read


data Player =  PLAYER_1 | PLAYER_2 deriving Show

next :: Player -> Player
next PLAYER_1 = PLAYER_2
next PLAYER_2 = PLAYER_1
 
finished:: Board -> Bool
finished = all (==0)

valid :: Board -> Row -> Int -> Bool
valid board row num =  board !! (row -1) >= num  

move :: Board -> Row -> Int -> Board 
move board row num = [if row == r then n - num else n |(r,n) <- zip [1..] board]

                                                        
--  MAIN GAME LOGIC
play :: Row -> Board -> Player -> IO ()
play mRows board player = do putBoard board
                             newline 
                             if finished board then
                              putStrLn (show (next player) ++ " WINS!!!")
                             else 
                                do print ( "PLAYING now  - " ++ show player)
                                   newline
                                   row <- getNumber mRows "Enter row number: " 
                                   newline   
                                   num <- getNumber mRows "Enter number of stars to remove: "
                                   newline  
                                   if valid board row num then
                                        play mRows (move board row num) (next player)
                                    else
                                        do putStrLn "ERROR: INVALID MOVE!!! Please try again"
                                           play mRows board player                 

startNim :: IO ()
startNim = do newline  
              putStrLn "**************************************************************************************** Welcome to the game of NIM ***************************************************************************************" 
              newline
              putStrLn "Enter the total number of rows in the board: "
              x <- getLine
              case (readMaybe x :: Maybe Int) of
                  Nothing -> do putStrLn "Please enter a valid number and try again."
                                newline
                                startNim
                  Just nRows  -> do  newline  
                                     putStrLn "Constructing the Nim game board"  
                                     let iBoard = reverse [1..nRows] in 
                                      play nRows iBoard PLAYER_1  

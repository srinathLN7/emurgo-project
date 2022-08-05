module Nim (startNim) where
import Board 
import Text.Read
                                                        
--  MAIN GAME LOGIC
play :: Row -> Board -> Player -> IO ()
play mRows board player = do putBoard board
                             newline 
                             if finished board then
                                renderWinMsg player
                             else 
                                do renderPlayerMsg player
                                   newline
                                   row <- getNumber mRows "Enter row number: " 
                                   newline   
                                   num <- getNumber mRows "Enter number of stars to remove: "
                                   newline  
                                   if valid board row num then
                                        play mRows (move board row num) (next player)
                                    else
                                        do renderErrMsg
                                           play mRows board player                 


finished:: Board -> Bool
finished = all (==0)

valid :: Board -> Row -> Int -> Bool
valid board row num =  board !! (row -1) >= num  

move :: Board -> Row -> Int -> Board 
move board row num = [if row == r then n - num else n |(r,n) <- zip [1..] board]


startNim :: IO ()
startNim = do newline  
              renderWelcome 
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

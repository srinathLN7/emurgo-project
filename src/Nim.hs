module Nim (startNim) where
import Board 
import Text.Read
                                                        
-- play :: MAIN GAME LOGIC 
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
                                        do renderErrMsg "ERROR: INVALID MOVE!!! Please try again"
                                           play mRows board player                 


-- finished :: returns true if the board is empty
finished:: Board -> Bool
finished = all (==0)

-- valid :: returns if the move made by a player is valid or not
valid :: Board -> Row -> Int -> Bool
valid board row num =  board !! (row -1) >= num  

-- move :: returns a new board after the current player has finished playing
move :: Board -> Row -> Int -> Board 
move board row num = [if row == r then n - num else n |(r,n) <- zip [1..] board]

-- startNim :: starts the variant Nim game
startNim :: IO ()
startNim = do newline  
              renderWelcome 
              newline
              newline
              putStrLn "Enter the total number of rows you want in the board: "
              x <- getLine 
              case (readMaybe x :: Maybe Int) of
                  Nothing -> do renderErrMsg "ERROR: Invalid number input !!! Please try again."
                                newline
                                startNim
                  Just nRows  -> if nRows >=5 then  
                                    do  newline  
                                        putStrLn "Constructing the Nim game board"  
                                        let iBoard = reverse [1..nRows] in 
                                         play nRows iBoard PLAYER_1  
                                 else 
                                    do  newline 
                                        renderErrMsg "ERROR: Invalid Input!!! Number of rows must be greater than or equal to 5 (Standard Nim board). Please try again"
                                        newline 
                                        startNim

module Nim (startNim) where

-- import Text.Read
import Board 

data GameState = GameState {_nRows :: Row, _board :: Board, _currentPlayer :: Player} deriving Show
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

                                                        
--  MAIN GAME FUNCTION
play :: Board -> Player -> IO ()
play board player = do putBoard board
                       newline 
                       if finished board then
                           putStrLn (show (next player) ++ " WINS!!!")
                       else 
                           do print ( "PLAYING now  - " ++ show player)
                              newline
                              row <- getNumber "Enter row number: " 
                              newline   
                              num <- getNumber "Enter number of stars to remove: "
                              newline  
                              if valid board row num then
                                play (move board row num) (next player)
                              else
                                  do putStrLn "ERROR: INVALID MOVE!!! Please try again"
                                     play board player                 


startNim :: IO ()
startNim = do newline  
              putStrLn "**************************************************************************************** Welcome to the game of NIM ***************************************************************************************"
              play initialB PLAYER_1 
              --  newline
              --  putStrLn "Enter the total number of rows in the board: "
              --  x <- getLine
              --  case (readMaybe x :: Maybe Int) of
              --     Nothing -> do putStrLn "Please enter a valid number and try again."
              --                   newline
              --                   startNim
              --     Just nRows  -> do putStrLn "Constructing the Nim game board"
              --                       let initial = [nRows .. 1] in play initial Player_1  

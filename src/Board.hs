module Board where

import Text.Read
import System.Console.ANSI
import Control.Monad

-- BOARD UTILITIES
type Row = Int 
type Board = [Row] 

data Player =  PLAYER_1 | PLAYER_2 deriving Show

-- next: returns the player who has to play next
next :: Player -> Player
next PLAYER_1 = PLAYER_2
next PLAYER_2 = PLAYER_1

-- renderPoint :: displays *** on the screen 
renderPoint :: (Int, Int) -> IO ()
renderPoint (r, c) = setCursorPosition r c >> putChar '*'

-- renderWelcome :: displays Welcome msg at the start of the game
renderWelcome :: IO () 
renderWelcome = do setSGR [SetColor Foreground Vivid Blue]
                   Just (_, mcol) <- getTerminalSize
                   Just (crow, _) <- getCursorPosition
                   forM_ (zip (repeat crow) [0 .. mcol]) renderPoint                             
                   setCursorPosition (crow + 1) (mcol `div` 3) >> putStrLn "Welcome to the Variant NIM game" 
                   forM_ (zip (repeat (crow+2)) [0 .. mcol]) renderPoint
                   setSGR [Reset]


-- renderErrMsg :: displays the error msg incase of invalid inputs 
renderErrMsg :: String -> IO ()
renderErrMsg err = do setSGR [SetColor Foreground Vivid Red]
                      putStrLn err      
                      setSGR [Reset]      

-- renderPlayerMsg :: displays the player who has to play next
renderPlayerMsg :: Player -> IO ()
renderPlayerMsg player = do setSGR [SetColor Foreground Vivid Yellow]
                            Just (_, mcol) <- getTerminalSize
                            setCursorColumn (mcol `div` 3)    
                            print ( "PLAYING now  - " ++ show player)
                            setSGR[Reset]

-- renderWinMsg :: displays who won the game at the end
renderWinMsg :: Player -> IO ()
renderWinMsg player = do setSGR [SetColor Foreground Vivid Green]
                         Just (_, mcol) <- getTerminalSize
                         setCursorColumn (mcol `div` 3)         
                         putStrLn (show (next player) ++ " WINS !!!")
                         newline 
                         setSGR[Reset]

-- putRow :: displays the number of stars in a given row
putRow :: Row -> Int -> IO ()
putRow row num = do setSGR [SetColor Foreground Vivid Blue]
                    newline
                    putStr (show row ++ ": ")
                    print ( concat $ replicate num " * ")
                    setSGR [Reset]    


-- putBoard :: displays the Nim board at a given instance
putBoard :: Board -> IO ()
putBoard board = sequence_ [ putRow r b | (r,b) <- zip [1..] board]
-- sequence_ :: [IO a] -> IO ()

-- newline :: inserts a new line
newline :: IO ()
newline = putChar '\n'
                        
-- getNumber : get the player's input - the row number and the number of stars to be removed at each turn                         
getNumber :: Row -> String -> IO Int
getNumber mRows prompt       = do putStrLn prompt
                                  x <- getLine                                           
                                  case (readMaybe x :: Maybe Int) of
                                    Nothing -> do newline
                                                  renderErrMsg "ERROR: Invalid number input !!! Please try again"
                                                  newline     
                                                  getNumber mRows prompt 
                                    Just y  -> case prompt of  
                                                "Enter row number: " -> let initBoard = reverse[1..mRows] in 
                                                                        if y `elem` initBoard then
                                                                        return y        
                                                                        else do newline
                                                                                renderErrMsg "ERROR: Invalid row number!!! Please try again."
                                                                                newline   
                                                                                getNumber mRows "Enter row number: " 
                                                _ -> return y   
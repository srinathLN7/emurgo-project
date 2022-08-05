module Board where

import Text.Read
import System.Console.ANSI


-- GAME UTILITIES
type Row = Int 
type Board = [Row] 

data Player =  PLAYER_1 | PLAYER_2 deriving Show

next :: Player -> Player
next PLAYER_1 = PLAYER_2
next PLAYER_2 = PLAYER_1

renderWelcome :: IO () 
renderWelcome = do setSGR [SetColor Foreground Vivid Blue]
                   Just (_, mcol) <- getTerminalSize     
                   setCursorColumn (mcol `div` 4) >> putStrLn "*********************************** Welcome to the Variant NIM ***********************************" 
                   setSGR [Reset]
                           
renderErrMsg :: IO ()
renderErrMsg = do setSGR [SetColor Foreground Vivid Red]
                  putStrLn "ERROR: INVALID MOVE!!! Please try again"      
                  setSGR [Reset]      

renderPlayerMsg :: Player -> IO ()
renderPlayerMsg player = do setSGR [SetColor Foreground Vivid Yellow]    
                            print ( "PLAYING now  - " ++ show player)
                            setSGR[Reset]


renderWinMsg :: Player -> IO ()
renderWinMsg player = do setSGR [SetColor Foreground Vivid Green]
                         putStrLn (show (next player) ++ " WINS!!!")
                         newline 
                         setSGR[Reset]

putRow :: Row -> Int -> IO ()
putRow row num = do setSGR [SetColor Foreground Vivid Blue]
                    newline
                    putStr (show row ++ ": ")
                    print ( concat $ replicate num " * ")
                    setSGR [Reset]    


-- sequence_ :: [IO a] -> IO ()
putBoard :: Board -> IO ()
putBoard board = do Just (_, mcol) <- getTerminalSize
                    setCursorColumn (mcol `div` 2) 
                    sequence_ [ putRow r b | (r,b) <- zip [1..] board]


newline :: IO ()
newline = putChar '\n'
                        
getNumber :: Row -> String -> IO Int
getNumber mRows prompt       = do putStrLn prompt
                                  x <- getLine                                           
                                  case (readMaybe x :: Maybe Int) of
                                    Nothing -> do putStrLn "Invalid input. Only numbers accepted. Please try again"
                                                  newline     
                                                  getNumber mRows prompt 
                                    Just y  -> case prompt of  
                                                "Enter row number: " -> let initBoard = reverse[1..mRows] in 
                                                                        if y `elem` initBoard then
                                                                        return y        
                                                                        else do putStrLn "Invalid row number. Please try again."
                                                                                newline   
                                                                                getNumber mRows "Enter row number: " 
                                                _ -> return y   
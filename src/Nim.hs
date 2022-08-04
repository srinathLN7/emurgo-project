module Nim (play) where

-- import Data.Char 
import Data.Maybe (fromJust)
import Text.Read

-- GAME UTILITIES

type Row = Int
type Number = Int 
type Board = [Row]

initial :: Board
initial = [5,4,3,2,1]

next :: Int -> Maybe Int
next 1 = Just 2
next 2 = Just 1
next _ = Nothing 


finished:: Board -> Bool
finished = all (==0)

valid :: Board -> Row -> Number -> Bool
valid board row num =  board !! (row -1) >= num  

move :: Board -> Row -> Number -> Board 
move board row num = [if row == r then n - num else n |(r,n) <- zip [1..] board]


-- SCREEN UTILITIES
putRow :: Row -> Number -> IO ()
putRow row num = do putChar '\n'
                    putStr (show row ++ ": ")
                    print ( concat $ replicate num "*")


-- sequence_ :: [IO a] -> IO ()
putBoard :: Board -> IO ()
putBoard board = sequence_ [ putRow r b | (r,b) <- zip [1..] board]


rowPrompt :: String
rowPrompt = "Enter row number: "

numPrompt :: String
numPrompt = "Enter number of stars to remove: "

newline :: IO ()
newline = putChar '\n'


getNumber :: String -> IO Int
getNumber prompt       = do putStrLn prompt
                            x <- getLine
                            case (readMaybe x :: Maybe Int) of
                             Nothing -> do putStrLn "Invalid input. Only numbers accepted. Please try again"
                                           newline     
                                           getNumber prompt 
                             Just y  -> case prompt of  
                                            "Enter row number: " -> if y `elem` initial then
                                                         return y
                                                         else do putStrLn "Invalid row number. Please try again."
                                                                 newline   
                                                                 getNumber rowPrompt 
                                            _ -> return y   
                                                           

--  MAIN GAME FUNCTION
play :: Board -> Int -> IO ()
play board player = do putBoard board
                       newline 
                       if finished board then
                           putStrLn ("Player " ++ show (fromJust $ next player) ++ " wins!!!")
                       else 
                           do print ("Playing now --> Player " ++ show player)
                              newline
                              row <- getNumber rowPrompt 
                              newline   
                              num <- getNumber numPrompt
                              newline  
                              if valid board row num then
                                play (move board row num) (fromJust $ next player)
                              else
                                  do putStrLn "ERROR: INVALID MOVE!!! Please try again"
                                     play board player                 

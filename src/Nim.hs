module Nim (startNim) where
import Text.Read

-- GAME UTILITIES
type Row = Int 
type Board = [Row]

initialB :: Board
initialB = [5,4,3,2,1]

data GameState = GameState {_nRows :: Row, _board :: Board, _currentPlayer :: Player} deriving Show
data Player =  Player_1 | Player_2 deriving Show

next :: Player -> Player
next Player_1 = Player_2
next Player_2 = Player_1
 
finished:: Board -> Bool
finished = all (==0)

valid :: Board -> Row -> Int -> Bool
valid board row num =  board !! (row -1) >= num  

move :: Board -> Row -> Int -> Board 
move board row num = [if row == r then n - num else n |(r,n) <- zip [1..] board]


-- SCREEN UTILITIES
putRow :: Row -> Int -> IO ()
putRow row num = do putChar '\n'
                    putStr (show row ++ ": ")
                    print ( concat $ replicate num "*")


-- sequence_ :: [IO a] -> IO ()
putBoard :: Board -> IO ()
putBoard board = sequence_ [ putRow r b | (r,b) <- zip [1..] board]


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
                                            "Enter row number: " -> if y `elem` initialB then
                                                         return y
                                                         else do putStrLn "Invalid row number. Please try again."
                                                                 newline   
                                                                 getNumber "Enter row number: " 
                                            _ -> return y   
                                                           

--  MAIN GAME FUNCTION
play :: Board -> Player -> IO ()
play board player = do putBoard board
                       newline 
                       if finished board then
                           putStrLn (show (next player) ++ " wins!!!")
                       else 
                           do print (show player ++ " ----------------> Turn")
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
              putStrLn "*************************************************************************** Welcome to the game of Nim ***************************************************************************"
              play initialB Player_1 
              --  newline
              --  putStrLn "Enter the total number of rows in the board: "
              --  x <- getLine
              --  case (readMaybe x :: Maybe Int) of
              --     Nothing -> do putStrLn "Please enter a valid number and try again."
              --                   newline
              --                   startNim
              --     Just nRows  -> do putStrLn "Constructing the Nim game board"
              --                       let initial = [nRows .. 1] in play initial Player_1  

module Board where

import Text.Read

-- GAME UTILITIES
type Row = Int 
type Board = [Row]    


initialB :: Board
initialB = [5,4,3,2,1]

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
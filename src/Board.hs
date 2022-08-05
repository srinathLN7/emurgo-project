module Board where

import Text.Read


-- GAME UTILITIES
type Row = Int 
type Board = [Row] 

-- newtype Config = Config {_iBoard :: Board} 
-- newtype Reader config a = Reader {runReader :: config -> a}
-- newtype StateT s m a = StateT { runStateT :: s -> m (a, s) }
-- mkIBoard :: Row -> StateT Config IO Config
-- mkIBoard mRows = return $ Config {_iBoard = reverse[1..mRows]}

-- SCREEN UTILITIES
putRow :: Row -> Int -> IO ()
putRow row num = do putChar '\n'
                    putStr (show row ++ ": ")
                    print ( concat $ replicate num " * ")


-- sequence_ :: [IO a] -> IO ()
putBoard :: Board -> IO ()
putBoard board = sequence_ [ putRow r b | (r,b) <- zip [1..] board]


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
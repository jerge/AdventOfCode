import Data.Binary

main = do 
  x <- readFile "./5"
  putStr$show$maximum$f$lines x

f :: [String] -> [Int]
f [] = []
f (s:ss) = ((g (take 7 s) 6)*8 + g (drop 7 s) 2):f ss

g :: String -> Int -> Int
g _ (-1) = 0
g (c:s) i = case c of
    'B' -> 2^i+r
    'R' -> 2^i+r
    _ -> r
    where r = g s (i-1)
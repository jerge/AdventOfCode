import qualified Data.Text as T
import Data.List

main = do 
  x <- readFile "./6"
  let a = map T.unpack (T.splitOn (T.pack "\n\n") (T.pack x))
  putStr$show$f a

f :: [String] -> Int
f [] = 0
f (s:ss) = length (g (lines s)) + f ss

g :: [String] -> String
g (s:[]) = s
g (s:ss) = intersect s (g ss)
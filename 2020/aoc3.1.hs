import Data.List

main = do 
  x <- readFile "./3"
  putStr$show$f (3,1) $lines x
-- 31 width
f :: (Int,Int) -> [String] -> Int
f (x,y) (a:[]) = if a !! (mod x 31) == '#' then 1 else 0
f (x,y) (a:(b:cs)) = if b !! (mod x 31) == '#' then 1+ f (x+3,y+1) (b:cs) else f (x+3,y+1) (b:cs)
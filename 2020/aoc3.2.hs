import Data.List

main = do 
  x <- readFile "./3"
  putStr$show$g$lines x

g :: [String] -> Int
g x = (f (1,1) 1 x) * (f (3,1) 3 x) * (f (5,1) 5 x) * (f (7,1) 7 x) * (f (1,2) 1 x)

f :: (Int,Int) -> Int -> [String] -> Int
f (i,j) x (a:[]) = if a !! (mod x 31) == '#' then 1 else 0
f (i,1) x (a:(b:cs)) = if b !! (mod x 31) == '#' then 1+ f (i,1) (x+i) (b:cs) else f (i,1) (x+i) (b:cs)
f (i,2) x (a:(b:(c:ds))) = if c !! (mod x 31) == '#' then 1 + f (i,2) (x+i) (c:ds) else f (i,2) (x+i) (c:ds)
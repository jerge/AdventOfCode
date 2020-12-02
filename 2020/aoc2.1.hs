import Data.List

main = do 
  x <- readFile "./2"
  putStr$show$g$f$lines x

spl c s = case elemIndex c s of
    Just i -> i
    Nothing -> 0

f :: [String] -> [(Int,Int,Char,String)]
f [] = []
f (s:ss) = (read a, read (takeWhile (/=' ') (tail w)), last w, drop 2 r):(f ss)
    where (l,r) = splitAt (spl ':' s) s
          (a,w) = splitAt (spl '-' l) l

g :: [(Int,Int,Char,String)] -> Int
g [] = 0
g ((a,b,c,d):l) = if o <= b && o >= a then 1 + g l else g l
    where o = length(filter (== c) d)
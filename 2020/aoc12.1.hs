main = do 
  x <- readFile "./12"
  let a = map (readInst) (lines x)
  putStr$show$f a 0 (0,0)

readInst :: String -> (Char,Int)
readInst (c:s) = (c,read s :: Int)

-- [0=E,1=S,2=W,3=N]
-- (X/E,Y/N)
f :: [(Char,Int)] -> Int -> (Int,Int) -> (Int,Int)
f [] _ l = l
f ((c,n):inp) dir loc@(l,r) = case c of
    'R' -> f inp (mod (dir + div n 90) 4) loc
    'L' -> f inp (mod (dir - div n 90) 4) loc
    'F' -> f inp dir (add (g dir n) loc)
    'E' -> f inp dir (l+n,r)
    'S' -> f inp dir (l,r-n)
    'W' -> f inp dir (l-n,r)
    'N' -> f inp dir (l,r+n)
    _ -> error $ "invalid char " ++ [c]

g :: Int -> Int -> (Int,Int)
g d n = case d of
    0 -> (1*n,0)
    1 -> (0,-1*n)
    2 -> (-1*n,0)
    3 -> (0,1*n)
    _ -> error $ "invalid dir " ++ show d

add :: (Int,Int) -> (Int,Int) -> (Int,Int)
add (a,b) (c,d) = (a+c,b+d)
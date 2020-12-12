main = do 
  x <- readFile "./12"
  let a = map (readInst) (lines x)
  let (l,r) = f a (0,0) (10,1)
  putStr$show$abs(l) + abs(r)

readInst :: String -> (Char,Int)
readInst (c:s) = (c,read s :: Int)

-- [0=E,1=S,2=W,3=N]
-- (X/E,Y/N)
f :: [(Char,Int)] -> (Int,Int) -> (Int,Int) -> (Int,Int)
f [] l _ = l
f ((c,n):i) loc@(l,r) wp@(wl,wr) = case c of
    'R' -> f i loc (rotR n wp)
    'L' -> f i loc (rotR (360-n) wp)
    'F' -> f i (wl*n+l,wr*n+r) wp
    'E' -> f i loc (wl+n,wr)
    'S' -> f i loc (wl,wr-n)
    'W' -> f i loc (wl-n,wr)
    'N' -> f i loc (wl,wr+n)
    _ -> error $ "invalid char " ++ [c]

g :: Int -> Int -> (Int,Int)
g d n = case d of
    0 -> (1*n,0)
    1 -> (0,-1*n)
    2 -> (-1*n,0)
    3 -> (0,1*n)
    _ -> error $ "invalid dir " ++ show d

rotR :: Int -> (Int,Int) -> (Int,Int)
rotR n (l,r) = do
    let n' = mod n 360
    case n' of
        0 -> (l,r)
        90 -> (r,-l)
        180 -> (-l,-r)
        270 -> (-r,l)
        _ -> error $ "invalid degree: " ++ show n
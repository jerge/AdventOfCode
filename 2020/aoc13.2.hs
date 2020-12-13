import qualified Data.Text as T

main = do 
  x <- readFile "./13"
  let a = lines x
  let n = readInt (head a)
  let t = T.split (==',') (T.pack (head (tail a)))
  let t' = map T.unpack t
  let t'' = map readInt t'
  let t''' = filter ((/=0) . snd) $ zip [0,-1..] t''
  print t'''
  putStr$show$crt t'''

readInt :: String -> Int
readInt "x" = 0
readInt s = read s :: Int

-- From Stackoverflow, I solved via online calculator
crt :: (Integral a, Foldable t) => t (a, a) -> (a, a)
crt = foldr go (0, 1)
    where
    go (r1, m1) (r2, m2) = (r `mod` m, m)
        where
        r = r2 + m2 * (r1 - r2) * (m2 `inv` m1)
        m = m2 * m1

    -- Modular Inverse
    a `inv` m = let (_, i, _) = gcd a m in i `mod` m

    -- Extended Euclidean Algorithm
    gcd 0 b = (b, 0, 1)
    gcd a b = (g, t - (b `div` a) * s, s)
        where (g, s, t) = gcd (b `mod` a) a
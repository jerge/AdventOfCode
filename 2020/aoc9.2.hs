main = do 
  x <- readFile "./9"
  let a = map (readInt) (lines x)
  let n = f a
  putStr$show$g a n

readInt :: String -> Int
readInt s = read s :: Int

sums :: [Int] -> [Int]
sums [] = []
sums (i:is) = map (+i) is ++ sums is

f :: [Int] -> Int
f [] = -1
f inp = if elem (inp !! 25) (sums (take 25 (inp))) then f (tail inp) else (inp !! 25)

g :: [Int] -> Int -> Int
g inp n = case sumUntil inp n 0 [] of
    Just x -> minimum x + maximum x
    Nothing -> g (tail inp) n

sumUntil :: [Int] -> Int -> Int -> [Int] -> Maybe [Int]
sumUntil [] _ c l = Nothing
sumUntil (i:inp) n c l = if i + c < n then sumUntil inp n (i+c) (i:l) else if i+c == n then return (i:l) else Nothing
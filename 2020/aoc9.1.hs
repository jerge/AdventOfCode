main = do 
  x <- readFile "./9"
  let a = map (readInt) (lines x)
  putStr$show$f a

readInt :: String -> Int
readInt s = read s :: Int

sums :: [Int] -> [Int]
sums [] = []
sums (i:is) = map (+i) is ++ sums is

f :: [Int] -> Int
f [] = -1
f inp = if elem (inp !! 25) (sums (take 25 (inp))) then f (tail inp) else (inp !! 25)
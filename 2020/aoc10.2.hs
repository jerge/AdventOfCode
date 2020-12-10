import Data.List
import Data.Map

main = do 
  x <- readFile "./10"
  let a = Data.List.map (readInt) (lines x)
  putStr$show$g$toList$f (sort a) 0 0

readInt :: String -> Int
readInt s = read s :: Int

f :: [Int] -> Int -> Int -> Map Int Int
f [] _ c = Data.Map.adjust (+1) c (fromList [(0,0),(1,0),(2,0),(3,0),(4,0)])
f (i:is) v c = case i-v of
    1 -> f is i (c+1)
    3 -> Data.Map.adjust (+1) c (f is i 0)
    _ -> error $ "invalid voltage " ++ show v ++ " -> " ++ show i

g :: [(Int,Int)] -> Int
g [] = 1
g ((k,v):xs) = case k of
  4 -> 7^v * g xs
  3 -> 4^v * g xs
  2 -> 2^v * g xs
  _ -> g xs
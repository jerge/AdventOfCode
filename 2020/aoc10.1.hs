import Data.List

main = do 
  x <- readFile "./10"
  let a = map (readInt) (lines x)
  let (l,r) = f (sort a) 0
  print (l,r)
  putStr$show$l*r

readInt :: String -> Int
readInt s = read s :: Int

f :: [Int] -> Int -> (Int,Int)
f [] _ = (0,1)
f (i:is) v = case i-v of
    1 -> (l + 1,r)
    3 -> (l, r + 1)
    _ -> error $ "invalid voltage " ++ show v ++ " -> " ++ show i
    where (l,r) = f is i
import qualified Data.Text as T

main = do 
  x <- readFile "./13"
  let a = lines x
  let n = readInt (head a)
  let t = T.split (==',') (T.pack (head (tail a)))
  let t' = map readInt $ map T.unpack $ filter (/=(T.pack "x")) t
  print n
  print t'
  putStr$show$diffs n t'

readInt :: String -> Int
readInt s = read s :: Int

diffs :: Int -> [Int] -> [Int]
diffs _ [] = []
diffs n (x:xs) = (x - (mod n x)) : diffs n xs
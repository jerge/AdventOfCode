import qualified Data.Map as M
import Data.List

main = do 
  x <- readFile "./7"
  a <- f $ lines x
  print $ h a "1 shiny gold"
  putStr$"asd"

--a c -> [1 a c]
f :: [String] -> IO (M.Map String [String])
f [] = return M.empty
f (s:ss) = do
    m <- f ss
    return $ M.insert k (g v) m
    where
        k = unwords $ take 2 $ words s
        (_,v) = partition (\x -> x =="bags." || x =="bags," || x=="bag."|| x=="bag,") $ drop 4 $ words s

g :: [String] -> [String]
g [] = []
g (_:[]) = error "invalid 1"
g ("no":("other"):[]) = ["no"]
g (_:(_:[])) = error "invalid 2"
g s@(_:(_:(_:cs))) = unwords (take 3 s) : g cs

h :: M.Map String [String] -> String -> Int
h m "no" = 0
h m s = sum (map count children) + mu (map (h m) children) (map count children)
  where children = m M.! (drop 2 s)

mu :: [Int] -> [Int] -> Int
mu [] [] = 0
mu (a:as) [] = error "too many a"
mu [] (b:bs) = error "too many b"
mu (a:as) (b:bs) = a*b + mu as bs

count :: String -> Int
count "no" = 0
count s = (read (take 2 s) :: Int)

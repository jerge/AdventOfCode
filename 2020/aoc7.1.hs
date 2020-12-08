import qualified Data.Map as M
import Data.List

main = do 
  x <- readFile "./7"
  a <- f $ lines x
  putStr$show$length$nub$i a ["shiny gold"]

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
g s@(_:(_:(_:cs))) = unwords (drop 1 (take 3 s)) : g cs

h :: M.Map String [String] -> [String] -> String -> [String]
h _ [] _ = []
h m (k:ks) v = if elem v (m M.! k) then k:(h m ks v) else h m ks v

i :: M.Map String [String] -> [String] -> [String]
i m vs = case length x of
    0 -> x
    _ -> x ++ (i m x)
    where x = nub $ concat $ map (h m (M.keys m)) vs
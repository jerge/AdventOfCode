import qualified Data.Text as T
import Data.List ((\\))
import qualified Data.Map as M

main = do 
  x <- readFile "./16"
  let a = T.splitOn (T.pack "\n\n") (T.pack x)
  let rs = T.lines $ head a
  let yt = head $ tail $ T.lines (head (tail a))
  let nt = tail $ T.lines (last a)
  let rs' = concat $ map parseRs rs
  let nt' = map ((map readInt) . (T.splitOn (T.pack ","))) nt
  let yt' = map ((map readInt) . (T.splitOn (T.pack ","))) [yt]
  let nt'' = map snd $ filter ((==0) . length . fst) $ zip (map (filter (not . inRanges rs')) nt') nt'
  let yt'' = head $ map snd $ filter ((==0) . length . fst) $ zip (map (filter (not . inRanges rs')) yt') yt'
  asdf <- f rs' nt'' [0..div (length (rs')) 2-1]
  asdfg <- g asdf $ length asdf
  let m = M.fromList asdfg
  print $ (sug m rs' yt'') * (sug m (drop 2 rs') yt'') * (sug m (drop 4 rs') yt'') * (sug m (drop 6 rs') yt'') * (sug m (drop 8 rs') yt'') * (sug m (drop 10 rs') yt'')

sug m rs' yt'' = yt'' !! ((M.!) m (head rs',(head (tail rs'))))

f ::  [(Int,Int)] -> [[Int]] -> [Int] -> IO [[((Int,Int),(Int,Int))]]
f rs nt [] = return []
f rs nt (n:ns) = do
  x <- allInRs (map (!! n) nt) rs
  --print x
  xs <- (f rs nt ns)
  return (x:xs)

g :: [[((Int,Int),(Int,Int))]] -> Int -> IO [(((Int,Int),(Int,Int)),Int)]
g xs 0 = return []
g xs n = do
  let (rep,i) = uniques xs 0
  let xs' = map (filter (/= rep)) xs
  xs'' <- g xs' (n-1)
  return ((rep,i):xs'')

uniques :: Eq a => [[a]] -> Int -> (a,Int)
uniques [] i = error "no "
uniques (x:xs) i = if length x == 1 then (head x, i) else uniques xs (i+1)

allInRs :: [Int] -> [(Int,Int)] -> IO [((Int,Int),(Int,Int))]
allInRs _ [] = return []
allInRs _ (r1:[]) = error "invalid rs"
allInRs nt (r1:(r2:rs)) = do
  b <- in2Range r1 r2 nt
  x <- (allInRs nt rs)
  if b then return ((r1,r2):x) else return x
  where 
    in2Range :: (Int,Int) -> (Int,Int) -> [Int] -> IO Bool
    in2Range r' r'' nt' = do
      --print $ map (inRange r') nt'
      --print $ map (inRange r'') nt'
      return $ (and  [inRange r' x || inRange r'' x | x <- nt])
readInt :: T.Text -> Int
readInt t = read (T.unpack t) :: Int

parseRs :: T.Text -> ([(Int,Int)])
parseRs t = do
    let (l,r) = T.breakOn (T.pack "or") $ T.dropWhile (/=':') t
    let l' = T.dropEnd 1 $ T.drop 2 l
    let l'' = T.splitOn (T.pack "-") l'
    let r' = T.drop 3 r
    let r'' = T.splitOn (T.pack "-") r'
    let (a:(b:(c:(d:_)))) = map readInt (l'' ++ r'')
    [(a,b),(c,d)]

inRanges :: [(Int,Int)] -> Int -> Bool
inRanges [] _ = False
inRanges ((l,r):xs) n = if inRange (l,r) n then True else inRanges xs n

inRange :: (Int,Int) -> Int -> Bool
inRange (l,r) n = n <= r && n >= l
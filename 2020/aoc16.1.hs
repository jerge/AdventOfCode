import qualified Data.Text as T

main = do 
  x <- readFile "./16"
  let a = T.splitOn (T.pack "\n\n") (T.pack x)
  let rs = T.lines $ head a
  let yt = tail $ T.lines (head (tail a))
  let nt = tail $ T.lines (last a)
  let rs' = concat $ map parseRs rs
  let nt' = map ((map readInt) . (T.splitOn (T.pack ","))) nt
  print $sum . concat $ map (filter (not . inRanges rs')) nt'

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
inRanges ((l,r):xs) n = if n <= r && n >= l then True else inRanges xs n
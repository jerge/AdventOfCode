import qualified Data.Text as T
import Data.List

main = do 
  x <- readFile "./6"
  let a = map T.unpack (T.splitOn (T.pack "\n\n") (T.pack x))
  putStr$show$sum (map (length . (delete '\n') . nub) a)
import Data.List
import Data.Map (Map, member)
import qualified Data.Map as Map
import Data.Text


main = do 
  x <- readFile "./4"
  let a = form (splitOn (pack "\n\n") (pack x))
  putStr$show$validDict a

form :: [Text] -> [Map Text [Text]]
form [] = []
form (t:ts) = do
    let x = split (=='\n') t
    let x' = Data.List.concat (Data.List.map (split (==' ')) x)
    (toDict x'):(form(ts))
    
toDict :: [Text] -> Map Text [Text]
toDict [] = Map.empty
toDict (t:ts) = Map.insert (Data.Text.take 3 t) ([Data.Text.drop 4 t]) (toDict ts)

validDict :: [Map Text [Text]] -> Int
validDict [] = 0
validDict (m:ms) = if kx m ["hgt","pid","eyr","iyr","ecl","hcl","byr"] then 1 + validDict ms else validDict ms

kx :: Map Text [Text] -> [String] -> Bool
kx _ [] = True
kx m (s:ss) = Data.Map.member (pack s) m && kx m ss

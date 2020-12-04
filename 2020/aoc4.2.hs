import Data.List
import Data.Map (Map, member, lookup)
import qualified Data.Map as Map
import Data.Text
import Data.Char


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
kx m ("byr":ss) = case Data.Map.lookup (pack "byr") m of
    Just (x:xs) -> (rr x >= 1920 && rr x <= 2002) && kx m ss
    _ -> False
kx m ("iyr":ss) = case Data.Map.lookup (pack "iyr") m of
    Just (x:xs) -> (rr x >= 2010 && rr x <= 2020) && kx m ss
    _ -> False
kx m ("eyr":ss) = case Data.Map.lookup (pack "eyr") m of
    Just (x:xs) -> (rr x >= 2020 && rr x <= 2030) && kx m ss
    _ -> False
kx m ("hgt":ss) = case Data.Map.lookup (pack "hgt") m of
    Just (x:xs) -> if Data.Text.isSuffixOf (pack "cm") x 
        then rr (dropEnd 2 x) >= 150 && rr (dropEnd 2 x) <= 193 && kx m ss 
        else if Data.Text.isSuffixOf (pack "in") x then rr (dropEnd 2 x) >= 59 && rr (dropEnd 2 x) <= 76 && kx m ss else False
    _ -> False
kx m ("hcl":ss) = case Data.Map.lookup (pack "hcl") m of
    Just (x:xs) -> if Data.Text.isPrefixOf (pack "#") x
        then Data.Text.filter isHexDigit (Data.Text.tail x) == Data.Text.tail x && kx m ss
        else False
    _ -> False
kx m ("ecl":ss) = case Data.Map.lookup (pack "ecl") m of
    Just (x:xs) -> elem x [(pack "amb"), (pack "blu"), (pack "brn"), (pack "gry"), (pack "grn"), (pack "hzl"), (pack "oth")] && kx m ss
    _ -> False
kx m ("pid":ss) = case Data.Map.lookup (pack "pid") m of
    Just (x:xs) -> Data.Text.filter isDigit x == x && Data.Text.length x == 9 && kx m ss
    _ -> False

rr t = read (unpack t) :: Integer
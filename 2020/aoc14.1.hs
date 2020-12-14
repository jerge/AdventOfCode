import qualified Data.Map as Map

main = do 
  x <- readFile "./14"
  let a = lines x
  let b = f a ""
  print b
  putStrLn$show$Map.foldl' (+) 0 $ b

f :: [String] -> [Char] -> Map.Map Int Int
f [] _ = Map.empty
f (s:ss) m = case take 3 s of
    "mas" -> f ss $ drop 7 s
    "mem" -> do 
        let k = readInt $ drop 4 $ init . init $ takeWhile (/='=') s
        let v = readInt $ drop 2 $ dropWhile (/='=') s
        let v' = binToDec $ maskBin m (extendBin 36 $ decToBin v)
        Map.insertWith (f') k v' (f ss m) -- Insert if not present since we loop backwards in list
    _ -> error $ "invalid input " ++ s
    where f' _ b = b


readInt :: String -> Int
readInt s = read s :: Int

decToBin :: Int -> [Int]
decToBin 0 = [0]
decToBin d = decToBin (div d 2) ++ [mod d 2]

-- 0,1,0,0,1,0,0,1 => 73
binToDec :: [Int] -> Int
binToDec [] = 0
binToDec (0:bs) = binToDec bs
binToDec (1:bs) = 2^(length bs) + binToDec bs

maskBin :: [Char] -> [Int] -> [Int]
maskBin [] [] = []
maskBin [] _ = error "too long bin number"
maskBin _ [] = error "too short bin number"
maskBin ('0':mask) (b:bs) = 0: maskBin mask bs
maskBin ('1':mask) (b:bs) = 1: maskBin mask bs
maskBin ('X':mask) (b:bs) = b : maskBin mask bs

extendBin :: Int -> [Int] -> [Int]
extendBin n b = replicate (n - (length b)) 0 ++ b
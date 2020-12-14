import qualified Data.Map as Map

main = do 
  x <- readFile "./14"
  let a = lines x
  let b = f a ""
  putStrLn$show$Map.foldl' (+) 0 $ b

f :: [String] -> [Char] -> Map.Map Int Int
f [] _ = Map.empty
f (s:ss) m = case take 3 s of
    "mas" -> f ss $ drop 7 s
    "mem" -> do 
        let k = readInt $ drop 4 $ init . init $ takeWhile (/='=') s
        let v = readInt $ drop 2 $ dropWhile (/='=') s
        let ks = map init $ maskToKeys $ maskBin m (extendBin 36 (decToBin k))
        insertOnAll ks v (f ss m)
    _ -> error $ "invalid input " ++ s

insertOnAll :: [[Int]] -> Int -> Map.Map Int Int -> Map.Map Int Int
insertOnAll [] _ m = m
insertOnAll (k:ks) v m = Map.insertWith (f') (binToDec k) v (insertOnAll ks v m)
    where f' _ b = b

-- IMPORTANT: MAP INIT OVER OUTPUT
maskToKeys :: [Char] -> [[Int]]
maskToKeys [] = [[(-1)]]
maskToKeys ('0':mask) = map (0:) $maskToKeys mask
maskToKeys ('1':mask) = map (1:) $maskToKeys mask
maskToKeys ('X':mask) = map (0:) (maskToKeys mask) ++ map (1:) (maskToKeys mask)
maskToKeys (c:_) = error $ "invalid mask char " ++ [c]

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

maskBin :: [Char] -> [Int] -> [Char]
maskBin [] [] = []
maskBin [] _ = error "too long bin number"
maskBin _ [] = error "too short bin number"
maskBin ('0':mask) (b:bs) = (head (show b)): maskBin mask bs
maskBin ('1':mask) (b:bs) = '1': maskBin mask bs
maskBin ('X':mask) (b:bs) = 'X': maskBin mask bs
maskBin (c:_) _ = error $ "invalid mask char " ++ [c]

extendBin :: Int -> [Int] -> [Int]
extendBin n b = replicate (n - (length b)) 0 ++ b
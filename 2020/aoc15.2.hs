import qualified Data.Map as Map
import qualified Data.Text as T

main = do 
  x <- readFile "./15"
  let a = zip (map (readInt . T.unpack) $ T.split (==',') (T.pack x)) [1..]
  let b = Map.fromList $ a
  print b
  let (l,t) = last a
  speak l t b

readInt :: String -> Int
readInt s = read s :: Int

speak :: Int -> Int -> Map.Map Int Int -> IO Int
speak l 30000000 _ = do 
    return l
speak l t m = case Map.lookup l m of
    Just x -> do
        let n = t-x
        let m' = Map.insert l (t) m
        --print (t+1,n)
        --print m'
        speak n (t+1) m'
    Nothing -> do
        let n = 0
        let m' = Map.insert l (t) m
        --print (t+1,n)
        --print m'
        speak n (t+1) m'

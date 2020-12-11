main = do 
  x <- readFile "./11"
  let a = lines x
  b <- update a
  putStr$show$length$ filter (=='#') (concat b)

update :: [String] -> IO [String]
update a = do
    let (l,r) = f a
    let a' = g (length (init a)+1)$l
    --print r
    --print a'
    if r then return a' else update a'

f :: [String] -> ([Char],Bool)
f inp@(s:_) = (map fst x, all (==False) (map snd x))
    where x = map (newState inp) [ (x,y) | y<-[0..(length inp-1)], x<-[0..(length s-1)] ]

g :: Int -> [Char]-> [String]
g _ [] = []
g i c = take i c : g i (drop i c)

newState :: [String] -> (Int,Int) -> (Char,Bool)
newState ss (x,y) = case atLoc ss (x,y) of
    '#' -> if nOcc > 4 then ('L',True) else ('#',False)
    'L' -> if nOcc  == 0 then ('#',True) else ('L',False)
    c -> (c,False)
    where
        dirs = [(1,1),(1,0),(1,-1),(0,1),(0,-1),(-1,1),(-1,0),(-1,-1)]
        nOcc = sum $ map (seesChair ss (length (init ss),length ss) (x,y)) dirs

seesChair :: [String] -> (Int,Int) -> (Int,Int) -> (Int,Int) -> Int
seesChair inp m loc dir = do
    if isOOB m loc' then 0 else case atLoc inp loc' of
        '#' -> 1
        'L' -> 0
        _ -> seesChair inp m loc' dir
    where loc' = (fst loc + fst dir,snd loc + snd dir)

isOOB :: (Int,Int) -> (Int,Int) -> Bool
isOOB (mx,my) (x,y) = x < 0 || y < 0 || x > mx || y >= my

atLoc :: [String] -> (Int,Int) -> Char
atLoc s (x,y) = s !! y !! x
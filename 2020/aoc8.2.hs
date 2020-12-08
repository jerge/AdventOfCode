main = do 
  x <- readFile "./8"
  let a = lines x
  b <- p a
  putStr$show$b

p :: [String] -> IO Int
p i = do
    let addrs = f i [] 0 0
    let addrs' = findNAcc i addrs
    let i' = map (changeAddr i) addrs'
    runUntilGood i'

runUntilGood :: [[String]] -> IO Int
runUntilGood [] = return 0
runUntilGood (i:is) = do 
    let a = f i [] 0 0
    if length a == 1 
        then do
            return (head a) 
        else runUntilGood is

changeAddr :: [String] -> Int -> [String]
changeAddr instrs addr = case take 3 i of
    "jmp" -> (take (addr) instrs) ++ ("nop" ++ drop 3 i): drop (addr+1) instrs
    "nop" -> (take (addr) instrs) ++ ("jmp" ++ drop 3 i): drop (addr+1) instrs
    _ -> instrs
    where i = instrs !! addr

findNAcc :: [String] -> [Int] -> [Int]
findNAcc is [] = []
findNAcc is (a:as) = if (take 3 (is !! a)) /= "acc" then (a:findNAcc is as) else findNAcc is as

f :: [String] -> [Int] -> Int -> Int -> [Int]
f _ addrs 648 acc = [acc]
f instrs addrs addr acc = do 
    if elem addr addrs 
        then addrs
        else 
            case take 3 i of
                "nop" -> f instrs (addr:addrs) (addr+1) (acc)
                "acc" -> f instrs (addr:addrs) (addr+1) (acc+n i)
                "jmp" -> f instrs (addr:addrs) (addr+n i) acc
                _ -> error $ "invalid instr: " ++ i
    where i = instrs !! addr

n :: String -> Int
n i = if i !! 4 == '+' 
    then (read (drop 5 i) :: Int) 
    else (read (drop 4 i) :: Int)


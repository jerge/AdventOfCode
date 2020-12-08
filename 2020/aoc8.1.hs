main = do 
  x <- readFile "./8"
  a <- f (lines x) [] 0 0
  putStr$show$a

f :: [String] -> [Int] -> Int -> Int -> IO Int
f instrs addrs addr acc = do 
    if elem addr addrs 
        then return acc
        else case take 3 i of
        "nop" -> f instrs (addr:addrs) (addr+1) (acc)
        "acc" -> f instrs (addr:addrs) (addr+1) (acc+n i)
        "jmp" -> f instrs (addr:addrs) (addr+n i) acc
        _ -> error $ "invalid instr: " ++ i
    where i = instrs !! addr

n :: String -> Int
n i = if i !! 4 == '+' 
    then (read (drop 5 i) :: Int) 
    else (read (drop 4 i) :: Int)


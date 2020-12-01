main = do 
  x <- readFile "./a1.t"
  putStr$show$f$map read $lines x

f (s:l) = case g s l of
  Just i -> i
  Nothing -> f l 

g _ [] = Nothing
g a (b:l) = if a + b == 2020 then return (a*b) else g a l
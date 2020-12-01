main = do
  x <- readFile "./a1.t"
  putStr$show$f$map read $lines x

f (s:l) = case g s l of
  Just i -> i
  Nothing -> f l

g _ [] = Nothing
g a (b:l) = case h a b l of
  Just i -> return i
  Nothing -> g a l

h a b [] = Nothing
h a b (c:l) = if a + b + c == 2020 then return (a*b*c) else h a b l
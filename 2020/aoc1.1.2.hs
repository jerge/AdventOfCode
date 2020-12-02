main = do
  x <- readFile "./1"
  putStr$show$f$map read $lines x
f (s:l) = if x<1 then f l else x
  where x = sum$map (h s) l
h a b = if a+b==2020 then a*b else 0
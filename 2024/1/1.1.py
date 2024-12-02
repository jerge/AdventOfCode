import os
import re

inp = open("1.txt", 'r').read()

matches = re.findall("(\d+)\s+(\d+)", inp)

dist = 0

ls = sorted([int(m[0]) for m in matches])
rs = sorted([int(m[1]) for m in matches])
for (l,r) in zip(ls,rs):
    diff = abs(int(l) - int(r))
    dist += diff
print (dist)
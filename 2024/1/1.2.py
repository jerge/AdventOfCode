import os
import re

inp = open("1ex.txt", 'r').read()

matches = re.findall("(\d+)\s+(\d+)", inp)

dist = 0

ls = sorted([int(m[0]) for m in matches])
rs = sorted([int(m[1]) for m in matches])
for l in ls:
    diff = l * len([r for r in rs if r == l])
    dist += diff
print (dist)

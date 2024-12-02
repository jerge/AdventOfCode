import os
import re

inp = open("2.txt", 'r').read()

safe_lines = 0
for line in inp.splitlines():
    matches = re.findall("(\d+)", line)
    prev = int(matches[0])
    inc = None
    safe = True
    for m in matches[1:]:
        mi = int(m)
        if mi < prev and (prev - mi) in [1,2,3]:
            if inc == None or inc == 'dec':
                inc = 'dec'
                prev = mi
            else:
                safe = False
                break
        elif mi > prev and (mi - prev) in [1,2,3]:
            if inc == None or inc == 'asc':
                inc = 'asc'
                prev = mi  
            else:
                safe = False
                break
        else:
            safe = False
            break
    if safe:
        safe_lines += 1
print(safe_lines)

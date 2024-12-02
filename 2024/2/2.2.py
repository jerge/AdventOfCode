import os
import re

inp = open("2.txt", 'r').read()

def valid(matches):
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
    return safe
    

safe_lines = 0
for line in inp.splitlines():
    matches = re.findall("(\d+)", line)
    m_matches = [matches[:i]+matches[i+1:] for i in range(0,len(matches))] + [matches]
    s = False
    for m_match in m_matches:
        if valid(m_match):
            s = True
            break
    if s == True:
        safe_lines += 1
print(safe_lines)

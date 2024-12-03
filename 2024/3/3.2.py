import re

inp = open("3.txt", 'r').read()

matches = re.findall("mul\(\d{1,3},\d{1,3}\)|don't\(\)|do\(\)", inp)
print(matches)

sum = 0
do = True
for s in matches:
    if s == "don't()":
        do = False
        continue
    elif s == "do()":
        do = True
        continue
    if do == False:
        continue

    m = re.search("mul\((\d{1,3}),(\d{1,3})\)", s)
    l = m.group(1)
    r = m.group(2)
    sum += int(l)*int(r)
print(sum)
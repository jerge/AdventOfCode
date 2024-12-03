import re

inp = open("3.txt", 'r').read()

matches = re.findall("mul\((\d{1,3}),(\d{1,3})\)", inp)
print(matches)

sum = 0
for (l,r) in matches:
    sum += int(l)*int(r)

print(sum)
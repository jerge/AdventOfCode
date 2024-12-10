# Setup
inp = open("10ex.txt", 'r').read()
matrix = [[int(i) for i in line] for line in inp.splitlines()]
[print(l) for l in matrix]

max_c = len(matrix[0])
max_r = len(matrix)

# Helpers
def lookup(matrix, t):
    c,r = t
    if c >= max_c or r >= max_r or c < 0 or r < 0:
        return -1
    else:
        return matrix[r][c]
def sub(t1,t2):
    return (t1[0] - t2[0], t1[1] - t2[1])
def add(t1,t2):
    return (t1[0] + t2[0], t1[1] + t2[1])

def display(matrix, t):
    for ir, r in enumerate(matrix):
        s = []
        for ic, c in enumerate(r):
            if (ic,ir) == t:
                s.append('*')
            else:
                s.append(f'{c}')
        print(s)

# Pre work
directions = [(1,0), (0,1), (-1,0), (0, -1)]

starts = []
for r in range(0,max_r):
    for c in range(0,max_r):
        if lookup(matrix, (c, r)) == 0:
            starts.append((c,r))

# Solution
def traverse(location, n):
    if n == 9:
        # matrix[location[1]][location[0]] = -1
        return 1
    paths = 0
    for d in directions:
        new_l = add(d,location)
        if lookup(matrix, new_l) == n + 1:
            paths += traverse(new_l, n + 1)
    return paths

scores = 0
for st in starts:
    # matrix = [[int(i) for i in line] for line in inp.splitlines()]
    score = traverse(st, 0)
    scores += score
print(scores)
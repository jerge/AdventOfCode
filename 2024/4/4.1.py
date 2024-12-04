inp = open("4.txt", 'r').read()
matrix = inp.splitlines()

def lookup(matrix, c, r, max_c, max_r):
    if c >= max_c or r >= max_r or c < 0 or r < 0:
        return '.'
    else:
        return matrix[r][c]

def search(matrix, c, r, max_c, max_r):
    occurences = 0
    if (lookup(matrix, c, r, max_c, max_r) != 'X'):
        return 0
    # left right
    if lookup(matrix, c+1, r, max_c, max_r) == 'M' and lookup(matrix, c+2, r, max_c, max_r) == 'A' and lookup(matrix, c+3, r, max_c, max_r) == 'S':
        occurences += 1
    if lookup(matrix, c-1, r, max_c, max_r) == 'M' and lookup(matrix, c-2, r, max_c, max_r) == 'A' and lookup(matrix, c-3, r, max_c, max_r) == 'S':
        occurences += 1
    # up down
    if lookup(matrix, c, r+1, max_c, max_r) == 'M' and lookup(matrix, c, r+2, max_c, max_r) == 'A' and lookup(matrix, c, r+3, max_c, max_r) == 'S':
        occurences += 1
    if lookup(matrix, c, r-1, max_c, max_r) == 'M' and lookup(matrix, c, r-2, max_c, max_r) == 'A' and lookup(matrix, c, r-3, max_c, max_r) == 'S':
        occurences += 1
    # diagonals
    if lookup(matrix, c+1, r+1, max_c, max_r) == 'M' and lookup(matrix, c+2, r+2, max_c, max_r) == 'A' and lookup(matrix, c+3, r+3, max_c, max_r) == 'S':
        occurences += 1
    if lookup(matrix, c-1, r-1, max_c, max_r) == 'M' and lookup(matrix, c-2, r-2, max_c, max_r) == 'A' and lookup(matrix, c-3, r-3, max_c, max_r) == 'S':
        occurences += 1
    if lookup(matrix, c+1, r-1, max_c, max_r) == 'M' and lookup(matrix, c+2, r-2, max_c, max_r) == 'A' and lookup(matrix, c+3, r-3, max_c, max_r) == 'S':
        occurences += 1
    if lookup(matrix, c-1, r+1, max_c, max_r) == 'M' and lookup(matrix, c-2, r+2, max_c, max_r) == 'A' and lookup(matrix, c-3, r+3, max_c, max_r) == 'S':
        occurences += 1
    # print(occurences, r, c)
    return occurences

max_c = len(matrix)
max_r = len(matrix[0])
print(sum([search(matrix, col, row, max_c, max_r) for row in range(0,max_c) for col in range(0,max_c)]))


inp = open("4.txt", 'r').read()
matrix = inp.splitlines()

def lookup(matrix, c, r, max_c, max_r):
    if c >= max_c or r >= max_r or c < 0 or r < 0:
        return '.'
    else:
        return matrix[r][c]

def search(matrix, c, r, max_c, max_r):
    occurences = 0
    if (lookup(matrix, c, r, max_c, max_r) != 'A'):
        return 0

    if (lookup(matrix, c+1, r+1, max_c, max_r) == 'M' and lookup(matrix, c-1, r-1, max_c, max_r) == 'S') or \
        (lookup(matrix, c+1, r+1, max_c, max_r) == 'S' and lookup(matrix, c-1, r-1, max_c, max_r) == 'M'):
        occurences += 1

    if (lookup(matrix, c+1, r-1, max_c, max_r) == 'M' and lookup(matrix, c-1, r+1, max_c, max_r) == 'S') or \
        (lookup(matrix, c+1, r-1, max_c, max_r) == 'S' and lookup(matrix, c-1, r+1, max_c, max_r) == 'M'):
        occurences += 1
    if occurences != 2:
        occurences = 0
    else:
        occurences = 1

    return occurences

max_c = len(matrix)
max_r = len(matrix[0])
print(sum([search(matrix, col, row, max_c, max_r) for row in range(0,max_c) for col in range(0,max_c)]))


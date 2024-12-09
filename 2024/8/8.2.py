inp = open("8.txt", 'r').read()

chars = set(inp).difference(set(['\n','.']))
print(chars)
matrix = inp.splitlines()

max_c = len(matrix[0])
max_r = len(matrix)

def lookup(matrix, c, r):
    if c >= max_c or r >= max_r or c < 0 or r < 0:
        return '-'
    else:
        return matrix[r][c]

def lookup_tuple(matrix, t):
    (c, r) = t
    return lookup(matrix, c, r)

def sub(t1,t2):
    return (t1[0] - t2[0], t1[1] - t2[1])
def add(t1,t2):
    return (t1[0] + t2[0], t1[1] + t2[1])

def find_locations(matrix, char):
    return [(c, r) for r in range(max_r) for c in range(max_c) if lookup(matrix, c, r) == char]

nodes = []
for char in chars:
    locs = find_locations(matrix, char)
    # print(locs)
    pairs = [(a, b) for i, a in enumerate(locs) for j, b in enumerate(locs) if i < j]
    # print(pairs)
    for (a,b) in pairs:
        diff = sub(a, b)

        nodes.append(a)
        a1 = add(a,diff)
        l1 = lookup_tuple(matrix, a1)
        while (l1 != '-'):
            nodes.append(a1)
            a1 = add(a1,diff)
            l1 = lookup_tuple(matrix, a1)
        #--------------#
        nodes.append(b)
        a2 = sub(b,diff)
        l2 = lookup_tuple(matrix, a2)
        while (l2 != '-'):
            nodes.append(a2)
            a2 = sub(a2,diff)
            l2 = lookup_tuple(matrix, a2)
        
        # print(a2)
        # print(lookup_tuple(matrix, a2))
        # if lookup_tuple(matrix, a2) != '-':
        #     nodes.append(a2)
        # print(sub(b,sub(a, b)))
        # break

print(nodes)
print(len(set(nodes)))

# for r in range(0,max_r):
#     str = ''
#     for c in range(0,max_c):
#         if (c,r) in nodes and matrix[r][c] == '.':
#             str = str + '#'
#         else:
#             str = str + matrix[r][c]
#     print(str)
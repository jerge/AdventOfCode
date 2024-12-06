inp = open("6.txt", 'r').read()

map = inp.splitlines()

print(map)

position = None
for i in range(0,len(map)):
    l = map[i].find("^")
    if l != -1:
        position = (l,i)
        break
map = [list(line) for line in inp.splitlines()]
dir = (0,-1)

def turn(dir):
    if dir == (0,1):
        return (-1,0)
    elif dir == (-1,0):
        return (0,-1)
    elif dir == (0,-1):
        return (1,0)
    else:
        return (0,1)

max_y = len(map)
max_x = len(map[0])
start_pos = position
start_dir = dir
loops = 0

for y in range(0,max_y):
    for x in range(0,max_x):
        if map[y][x] == '.':
            map[y][x] = '#'
            print(f"-------x={x},y={y}-----")
            # for line in map:
            #     print(line)
        else:
            continue

        visited = []
        position = start_pos
        dir = start_dir
        while True:
            # print("------")
            # print(position, dir)
            # for line in map:
            #     print(line)
            if (position, dir) in visited:
                # print("---Looop---")
                # print(visited)
                # print(position, dir)
                # print(y,x)
                # for line in map:
                #     print(line)
                loops += 1
                break
            visited.append((position, dir))
            new_pos = (position[0] + dir[0], position[1] + dir[1])
            if new_pos[0] < 0 or new_pos[0] >= max_x or new_pos[1] < 0 or new_pos[1] >= max_y:
                # print("---DONE---")
                # print(new_pos)
                # print(position)
                # print(dir)
                break
            if map[new_pos[1]][new_pos[0]] == "#":
                dir = turn(dir)
            else:
                position = new_pos
        map[y][x] = '.'
        
print(loops)
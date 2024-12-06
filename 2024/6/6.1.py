inp = open("6.txt", 'r').read()

map = inp.splitlines()

position = None
for i in range(0,len(map)):
    x = map[i].find("^")
    if x != -1:
        position = (x,i)
        break

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
visited = []
while True:
    visited.append(position)
    new_pos = (position[0] + dir[0], position[1] + dir[1])
    if new_pos[0] < 0 or new_pos[0] >= max_x or new_pos[1] < 0 or new_pos[1] >= max_y:
        print("---DONE---")
        print(new_pos)
        break
    if map[new_pos[1]][new_pos[0]] == "#":
        dir = turn(dir)
    else:
        position = new_pos
print(len(set(visited)))
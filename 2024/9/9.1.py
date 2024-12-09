inp = '12345123451234512345223'
inp = open("9.txt", 'r').read()

disk_map = [int(i) for i in list(inp)]

disk = []
free = False
id = 0
for x in disk_map:
    if free:
        disk.extend('.' * x)
    else:
        # print([str(id)] * x)
        disk.extend([str(id)] * x)
        id += 1
    free = not free
print(disk)

first_empty = disk.index('.')
last_occupied = len(disk) - 1
if disk[last_occupied] == '.':
    print("INVALID LAST DISK LOCATION")
    raise ValueError("INVALID LAST DISK LOCATION")

while first_empty < last_occupied:
    disk[first_empty], disk[last_occupied] = disk[last_occupied], disk[first_empty]
    first_empty = disk.index('.')
    while disk[last_occupied] == '.':
        last_occupied -= 1
    # print(disk)
    # print(first_empty)
    # print(last_occupied)
print(disk)

csum = 0
for i in range(0,first_empty):
    csum += int(disk[i]) * i
print(csum)
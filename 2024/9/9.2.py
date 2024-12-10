inp = '123456789123456789123456789'
# inp = open("9.txt", 'r').read()

def find_sub_list(sl,l):
    sll=len(sl)
    for ind in (i for i,e in enumerate(l) if e==sl[0]):
        if l[ind:ind+sll]==sl:
            return ind,ind+sll
    return None, None

disk_map = [int(i) for i in list(inp)]
disk = []
disk_length = {}
free = False
id = 0
for x in disk_map:
    if free:
        disk.extend('.' * x)
    else:
        disk.extend([str(id)] * x)
        disk_length[id] = x
        id += 1
    free = not free
print(disk)
print(disk_length)
if free:
    id -= 1
print(id)

# disk_str = ''.join(disk) 
tot_offset = 0
for i in range(id,0,-1):
    if i % 10 == 0:
        print(i)
    disk_str = ''.join(disk)
    # print(disk_str)
    
    amount = disk_length.get(i)
    size = len(str(i))

    #Kill me now, size was not needed :))))))))))))))))))))
    # start_dot, end_dot = find_sub_list(['.'] * (amount*size), disk)
    start_dot, end_dot = find_sub_list(['.'] * (amount), disk)
    # print(start_dot, end_dot)
    if start_dot == None:
        continue
    
    start_num, end_num = find_sub_list([str(i)] * amount, disk)
    # print(start_num, end_num)
    if start_num < start_dot:
        continue
    if (start_num == None):
        raise ValueError(i)
    disk = disk[:start_dot] + disk[start_num:end_num] + disk[end_dot:start_num] + disk[start_dot:end_dot] + disk[end_num:]
print(''.join(disk))
csum = 0
for i in range(0,len(disk)):
    if disk[i] == '.':
        continue
    csum += int(disk[i]) * i
print(csum)
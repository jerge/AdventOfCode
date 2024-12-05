inp = open("5.txt", 'r').read()

mid = inp.find("\n\n")

rules = inp[:mid].splitlines()
order = inp[mid+2:].splitlines()

# print(rules)
# print(order)
rule_dict = {}
for r in rules:
    [a,b] = r.split("|")
    val = rule_dict.setdefault(b, "") + "," + a
    rule_dict[b] = val
print(rule_dict)

valids = []
for o in order:
    encountered = []
    seq = o.split(",")
    valid = True
    for num in seq:
        encountered.append(num)
        if not num in rule_dict.keys():
            continue
        for before in rule_dict[num].split(",")[1:]:
            if before not in encountered and before in seq:
                valid = False
                # print(before, num)
    if valid:
        valids.append((seq[len(seq)//2]))
print(sum([int(v) for v in valids]))
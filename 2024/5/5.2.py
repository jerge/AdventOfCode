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

def find_errors(seq, rule_dict):
    encountered = []
    errors = []
    for num in seq:
        encountered.append(num)
        if not num in rule_dict.keys():
            continue
        for before in rule_dict[num].split(",")[1:]:
            if before not in encountered and before in seq:
                print(before, num)
                errors.append((before, num))
    return errors

def swap_errors(errors, seq):
    errors.reverse()
    for b,n in errors:
        bi = seq.index(b)
        bn = seq.index(n)
        seq[bi], seq[bn] = seq[bn], seq[bi]
    return seq

valids = []
for o in order:
    seq = o.split(",")
    errors = ["do"]
    while len(errors) != 0:
        errors = find_errors(seq, rule_dict)
        seq = swap_errors(errors, seq)
    if o.split(",") != seq:
        valids.append((seq[len(seq)//2]))
print(sum([int(v) for v in valids]))



import re
inp = open("7.txt", 'r').read()


def calculate(result, terms):
    if len(terms) == 2:
        if terms[0] + terms[1] == result:
            return True
        if terms[0] * terms[1] == result:
            return True
        return False
    else:
        return calculate(result, [terms[0] + terms[1]] + terms[2:]) or calculate(result, [terms[0] * terms[1]] + terms[2:])

eqs = re.findall(r"(\d+):((?:\s\d+)+)\n", inp)
print(eqs)
res_sums = 0
for eq in eqs:
    result = int(eq[0])
    terms = [int(t) for t in eq[1][1:].split(" ")]
    if (calculate(result, terms)):
        res_sums += result
    # print(result)
    # print(terms)
print(res_sums)

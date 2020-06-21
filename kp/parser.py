import re
import random
import collections as ct

MAX_COUNT = 200

gecdom = open('royal_gen_20_11_2002.ged', 'r').readlines()
gender = {}
name = {}
children = ct.defaultdict(list)

curId = ""
curGender = ""
curName = ""

for line in gecdom:
	if(re.fullmatch(r"0 \S*? (?:INDI|FAM)\n", line)):
		if(curId != "" and curGender != "" and curName != ""):
			gender[curId] = curGender
			name[curId] = curName
		curId = re.search(r"@\S*?@",line)[0]
		curGender = ""
		curName = ""
		wife = ""
		husband = ""
	if(re.fullmatch(r"1 SEX \S\n", line)):
		curGender = line[-2:][:-1]
	if(re.fullmatch(r"1 NAME [^\n]*\n", line)):
		curName = line[7:][:-1]
	if(re.fullmatch(r"1 WIFE \S*?\n", line)):
		wife = re.search(r"@\S*?@",line)[0]
	if(re.fullmatch(r"1 HUSB \S*?\n", line)):
		husband = re.search(r"@\S*?@",line)[0]
	if(re.fullmatch(r"1 CHIL \S*?\n", line)):
		child = re.search(r"@\S*?@",line)[0]
		children[wife].append(child)
		children[husband].append(child)
allowed = set()
while(len(allowed) < MAX_COUNT):
	allowed = set()
	curId = random.choice(list(gender.keys()))
	allowed.add(curId)
	curWave = set()
	curWave.add(curId)
	i = 0
	while (i < 10 and len(allowed) < MAX_COUNT):
		newWave = set()
		for e in curWave:
			for c in children[e]:
				allowed.add(c)
				newWave.add(c)
		curWave = newWave
		i += 1
result = ""
for man in allowed:
	result += "sex('{0}','{1}').".format(name[man], gender[man]) + "\n"
result += "\n"
for man in allowed:
	for child in children[man]:
		result += "parent('{0}','{1}').".format(name[man], name[child]) + "\n"
open("main2.pl", "w").write(result)
import yaml, sys
from yaml.events import *

# We need to ensure the times are in quotes for the output diffs to work:
# https://stackoverflow.com/a/52424865
class RestrictionsDump(yaml.Dumper):
    pass

class QuotedString(str):
    pass

def quoted_scalar(dumper, data):
    return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='"')

RestrictionsDump.add_representer(QuotedString, quoted_scalar)


f = open("local_restrictions.yml")
input = f.read()
f.close()

doc = yaml.safe_load(input)

for i in doc:
    place = doc[i]
    # Each place then has a set: name, restrictions [list]
    # Dedupe via https://stackoverflow.com/a/9427216
    seen = set()
    outcome = []
    for i in place["restrictions"]:
        i["start_time"] = QuotedString(i["start_time"]) #Force it to be a special string...
        t = tuple(i.items())
        if t not in seen:
            seen.add(t)
            outcome.append(i)

    place["restrictions"] = sorted(outcome, key= lambda k: k['start_date'])

#
# 
# 
print (yaml.dump(doc, Dumper=RestrictionsDump))
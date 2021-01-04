import yaml, sys, datetime
from yaml.events import *

f = open("local_restrictions.yml")
input = f.read()
f.close()

doc = yaml.safe_load(input)

for i in doc:
    place = doc[i]
    starter = place["restrictions"][0]
    if starter["start_date"] != datetime.date(2020, 12, 2):
        print("Restrictions in %s started at %s" % (place["name"], starter["start_date"]))

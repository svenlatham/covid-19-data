#!/bin/bash
# Merges another YAML file into our main one (useful for historical entries)
# Note formats must be the same!

# 1. Merge the two YAML files (changes.yml should contain an updated version for merging)
cp local_restrictions.yml working.yml
docker run --rm -v "${PWD}":/workdir mikefarah/yq eval-all 'select(fi == 0) *+ select(fi == 1)' working.yml changes.yml >local_restrictions.yml
rm working.yml

# 2. Hacky tidy-up script
cp local_restrictions.yml merger/
cd merger
docker build -q -t svenlatham/covid-19-merger . >/dev/null
docker run --rm svenlatham/covid-19-merger >../local_restrictions.yml
rm local_restrictions.yml

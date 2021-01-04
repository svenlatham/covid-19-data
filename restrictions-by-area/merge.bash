#!/bin/bash
# Merges another YAML file into our main one (useful for historical entries)
# Note formats must be the same!


cp local_restrictions.yml working.yml
docker run --rm -v "${PWD}":/workdir mikefarah/yq eval-all 'select(fi == 0) *+ select(fi == 1)' working.yml changes.yml >local_restrictions.yml
rm working.yml
./debug.bash

# Sven is no expert in YAML. Any idea how to deduplicate or sort by date is welcome!
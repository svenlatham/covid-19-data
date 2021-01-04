#!/bin/bash
cp local_restrictions.yml debugger/
cd debugger
docker build -q -t svenlatham/covid-19-debugger . >/dev/null
docker run --rm svenlatham/covid-19-debugger >../local_restrictions.yml
rm local_restrictions.yml
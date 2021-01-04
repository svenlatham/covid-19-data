#!/bin/bash
# Checks for logical issues

cp local_restrictions.yml validator/
cd validator
docker build -q -t svenlatham/covid-19-validator . >/dev/null
docker run --rm svenlatham/covid-19-validator
rm local_restrictions.yml

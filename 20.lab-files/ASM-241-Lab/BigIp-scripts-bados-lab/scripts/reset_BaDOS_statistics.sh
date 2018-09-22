#!/bin/bash

### !!! It is not recommended that customer run this commands !!!
### !!! Always double check that only ONE admd process is running !!!

echo "Resetting BaDOS Statistics...."

bigstart stop admd
rm -rf /var/run/adm/*
bigstart start admd
sleep 2

echo "Done."


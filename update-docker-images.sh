#!/bin/sh 

docker images | awk '!/REPOSITORY/ { print $1 }' | xargs -L1 docker pull 

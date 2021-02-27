#!/bin/bash

docker run --rm -d \
    -v $PWD:/srv/hugo \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    yanqd0/hugo \
    hugo 


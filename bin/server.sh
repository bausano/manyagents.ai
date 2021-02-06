#!/bin/bash

docker run --rm -d \
    -v $PWD:/srv/hugo \
    -p 1313:1313 \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    --name manyagents.ai \
    yanqd0/hugo \
    hugo server --bind 0.0.0.0


#!/bin/bash

post_name=$1

docker run --rm \
    -v $PWD:/srv/hugo \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    yanqd0/hugo \
    hugo new "posts/${post_name}.md"


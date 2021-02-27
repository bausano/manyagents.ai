#!/bin/bash

# use ./bin/build.sh to build the project into a public dir first
aws s3 sync public s3://manyagents.ai

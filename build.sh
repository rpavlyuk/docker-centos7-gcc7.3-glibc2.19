#!/bin/bash

VERSION="1.0"
CONTAINER_NAME="docker.io/rpavlyuk/c7-gcc7.3-glib2.19"

# Build docker container
docker build --rm -t $CONTAINER_NAME .

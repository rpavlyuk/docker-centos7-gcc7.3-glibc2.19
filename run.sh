#!/bin/bash

docker -D run  \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	docker.io/rpavlyuk/c7-gcc7.3-glib2.19

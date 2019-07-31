# CentOS 7.x with GCC7.3 and GLibc 2.19
CentOS 7.x is shipped with GCC 4.8.5 and GLIBC 2.16 which is quite outdated and some projects won't build or work at all.

## What's inside?
The container has the following installed:
* ```Development Tools``` group packages
* Some additional useful packages like ```strace```, ```net-tools```, ```ip-route```, ```vim``` and others
* ```systemd``` is enabled
* GCC 7.3 (built out of source code)
* GLibc 2.19 (built out of source code)

## Using the container
Run the pre-built one from repository:
```
docker -D run  \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	docker.io/rpavlyuk/c7-gcc7.3-glib2.19
```
Building the container manually:
```
git clone https://github.com/rpavlyuk/docker-centos7-gcc7.3-glibc2.19.git && \
  cd docker-centos7-gcc7.3-glibc2.19 && 
  ./build.sh
```

You can use the container to build your own ones on top of it. Make sure, you have the following first lines in your `Dockerfile`:
```
FROM docker.io/rpavlyuk/c7-gcc7.3-glib2.19
MAINTAINER "John Doe" <jonny.doe@gmail.com>


```

**NOTE:** It takes some to build it since GCC and GLIBC compilation takes a while. On my Core i7 CPU it takes nearly 2+ hours.

## Credits
Roman Pavlyuk <roman.pavlyuk@gmail.com>

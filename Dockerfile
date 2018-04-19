FROM centos:7
MAINTAINER "Roman Pavlyuk" <roman.pavlyuk@gmail.com>

ENV container docker

RUN yum install -y epel-release

RUN yum update -y

RUN yum install -y \
	less \
	file \
	mc \
	vim-enhanced \
	telnet \
	net-tools \
	which \
	bash-completion \
	openssh-clients \
	libusb-devel \
	libusbx-devel \
	cmake \
	wget \
	git \
	pkgconfig \
	gcc \
	make \
	glibc \
	autoconf \
	automake \
	filesystem \
	libtool \
	strace \
	iproute \
	traceroute

### Let's enable systemd on the container
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]


# Install GCC 7
WORKDIR /tmp
RUN wget https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz && \
        tar xfz gcc-7.3.0.tar.gz
RUN yum install -y \
	libmpc-devel \
	mpfr-devel \
	gmp-devel \
	gcc-c++ \
	gcc-c++-devel \
	zlib-devel \
	zlib
RUN cd gcc-7.3.0 && \
	./configure --with-system-zlib --disable-multilib --enable-languages=c,c++ && \
	make -j 8 && \
	make install && \
	rm -rf /tmp/gcc-7.3.0	

# Update GLIBC
RUN yum groupinstall -y "Development tools"
RUN yum install -y \
	glibc-devel.i686 \
	glibc-i686
WORKDIR /tmp
RUN wget https://ftp.gnu.org/gnu/glibc/glibc-2.19.tar.gz && \
	tar -xvzf glibc-2.19.tar.gz
RUN cd glibc-2.19 && \
	mkdir glibc-build && \
	cd glibc-build && \
	../configure --prefix='/usr' && \
	make && \
	make install && \
	rm -rf /tmp/glibc-2.19

ENV PKG_CONFIG_PATH="/usr/local/lib/pkgconfig/:${PKG_CONFIG_PATH}"

COPY local-lib64.conf /etc/ld.so.conf.d/local-lib64.conf
COPY local-lib.conf /etc/ld.so.conf.d/local-lib.conf
RUN ldconfig 

RUN gcc --version
RUN ldd --version

### Kick it off
CMD ["/usr/sbin/init"]

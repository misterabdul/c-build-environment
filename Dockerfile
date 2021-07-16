FROM ubuntu:20.04

LABEL maintainer "Abdul Pasaribu <abdoelrachmad@gmail.com>"

# Ubuntu specific: set timezone during build
ARG TZ Asia/Jakarta

# Update all current packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qq apt-utils locales && \
	DEBIAN_FRONTEND=noninteractive apt-get -qq upgrade

# Ubuntu specific: set locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \
    DEBIAN_FRONTEND=noninteractive update-locale LANG=en_US.UTF-8

# Install all necessary packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq git curl openssh-client \
	cmake vim zsh wget zip python python3

# Debian specific: change default python to python3
RUN update-alternatives --install $(which python) python $(which python3) 0

# Install all related C development tools & libraries
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq autoconf automake binutils \
	bison flex gcc g++ gdb libc-dev libtool make pkgconf strace byacc ccache cscope \
	ctags elfutils indent ltrace linux-tools-generic valgrind cmake

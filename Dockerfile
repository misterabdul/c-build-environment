FROM debian:10.9

LABEL maintainer "Abdul Pasaribu <abdoelrachmad@gmail.com>"

# Update all current packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qq apt-utils && \
	DEBIAN_FRONTEND=noninteractive apt-get -qq upgrade

# Install all necessary packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq git curl openssh-client \
	cmake vim zsh wget zip python python3

# Debian specific: change default python to python3
RUN update-alternatives --install $(which python) python $(which python3) 0

# Install all related C development tools & libraries
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq autoconf automake binutils \
	bison flex gcc g++ gdb libc-dev libtool make pkgconf strace byacc ccache cscope \
	ctags elfutils indent ltrace linux-perf valgrind cmake

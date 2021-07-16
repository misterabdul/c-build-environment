FROM opensuse/leap:15.2

LABEL maintainer "Abdul Pasaribu <abdoelrachmad@gmail.com>"

# Update all current packages
RUN zypper ref && zypper up

# Install all necessary packages
RUN zypper in -y git curl which python3 \
	cmake vim zsh wget zip

# openSUSE specific: create symlink to python3
RUN ln -s $(which python3) /usr/bin/python

# Install all related C development tools & libraries
RUN zypper in -y -t pattern "devel_C_C++" && \
	zypper in -y gcc-c++

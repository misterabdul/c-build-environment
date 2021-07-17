FROM opensuse/leap:15.2

LABEL maintainer "Abdul Pasaribu <abdoelrachmad@gmail.com>"

# Update all current packages
RUN zypper ref && zypper up

# Install all necessary packages
RUN zypper in -y git curl which python3 \
	vim zsh wget zip

# openSUSE specific: create symlink to python3
RUN ln -s $(which python3) /usr/bin/python

# Install all related C development tools & libraries
RUN zypper in --recommends -y -t pattern "devel_C_C++" && \
	zypper in -y cmake

# Install sudo
RUN zypper in -y sudo

# Create c builder user account and add to wheel group
RUN useradd --create-home c-builder-ci && \
	usermod --append --groups wheel c-builder-ci && \
	sed -i 's/\(^%wheel.*ALL=(ALL).*ALL$\)/# \1/g' /etc/sudoers && \
	sed -i 's/^#.*\(%wheel.*ALL=(ALL).*NOPASSWD:.*ALL$\)/\1/g' /etc/sudoers

# Change to that user
USER c-builder-ci
WORKDIR /home/c-builder-ci

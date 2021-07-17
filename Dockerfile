FROM fedora:34

LABEL maintainer "Abdul Pasaribu <abdoelrachmad@gmail.com>"

# Update all current packages
RUN dnf update -y

# Install all necessary packages
RUN dnf install -y git \
	vim zsh wget zip

# Install all related C development tools & libraries
RUN dnf group install --with-optional -y "C Development Tools and Libraries"

# Install sudo
RUN dnf install -y sudo

# Create c builder user account and add to wheel group
RUN useradd --create-home c-builder-ci && \
	usermod --append --groups wheel c-builder-ci && \
	sed -i 's/\(^%wheel.*ALL=(ALL).*ALL$\)/# \1/g' /etc/sudoers && \
	sed -i 's/^#.*\(%wheel.*ALL=(ALL).*NOPASSWD:.*ALL$\)/\1/g' /etc/sudoers

# Change to that user
USER c-builder-ci
WORKDIR /home/c-builder-ci

FROM fedora:34

LABEL maintainer "Abdul Pasaribu <abdoelrachmad@gmail.com>"

# Update all current packages
RUN dnf update -y

# Install all necessary packages
RUN dnf install -y git \
	vim zsh wget zip

# Install all related C development tools & libraries
RUN dnf group install --with-optional -y "C Development Tools and Libraries"

# Use an official Ubuntu image as base image
FROM ubuntu:22.04

# Install tools and dependencies:
    # Need build essential for GNU-Make and GCC/G++
    # Need valgrind for memory leaks
    # Need clang in case C++ is compiled using clang++

RUN apt-get update -y && \
    apt-get install sudo -y && \
    sudo apt-get install build-essential -y && \
    sudo apt-get install clang -y && \
    sudo apt-get install -y libpng-dev && \
    sudo apt-get install valgrind -y && \
    rm -rf /var/lib/apt/lists/*

# Create workdir for the dev environment
WORKDIR /usr/cs221dev

# Copy the entire directory under cs221dev, this will synchronize labs and PAs under ./labs and ./PAs too
COPY . /usr/cs221dev

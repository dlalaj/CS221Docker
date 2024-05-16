# Use an official GCC image as the base image
FROM gcc:latest

# Noninteractive mode 
ENV DEBIAN_FRONTEND noninteractive

# Run get update and install valgrind for checking memory leaks
# Use -y flag to automatically answer yes to prompt-based installs
RUN apt-get update -y && \
    apt-get install valgrind -y

# Create workdir for the dev environment
WORKDIR /usr/cs221dev

# Copy the entire directory under cs221dev, this will synchronize labs and PAs under ./labs and ./PAs too
COPY . /usr/cs221dev

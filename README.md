# CS221 Docker Dev Environment
This is a guide on how to setup a local development environment for CPSC221's labs and programming assignments based on the 2024 summer term 1 offering using Docker. This semester, the course is a mic of g++ and clang++ to compile all code for labs and PAs. It has been tested for MacOS but not for Windows or Linux. MacOS users will very likely be able to run the code for these locally as well since gcc/g++ and clang/clang++ are typically installed by default into either of these OSes. Linux users will be able to run all handouts whose Makefile specifies gcc/g++ only unless clang(++) is installed manually.


## Using the setup
You are recommended to open the CS221Docker repo using some text editor of your choice (VSCode is a pretty good one, so why not that). To follow the guide below make sure you run all commands at the level where the Makefile of this repo is placed.

The setup has already created two empty directories for labs and PAs and I recommend you place all your lab code under `labs/` and similar for PA code under `PAs`. I will be trying my best to test out that the setup will support all of the code provided for labs and PAs but be warned that errors might come up so if you can manage to use the CS servers with VSCode and Remote-SSH that might be the safer choice.

The entire diretory is mounted as a volume to the docker container which means that any changes you do to your local files will be synchronized with the 'copy' in Docker so that you do not have to continuously copy and paste your changes in docker. In short you can edit your code in VSCode/editor of choice and the changes will immediately be ready for you to compile.

## About public copies and UBC Code of Conduct
The `.gitignore` has intentionally excluded any files under `labs` and `PAs` from being pushed to remote in case you choose to fork the repo and have your own code in Github to avoid any cases of academic misconduct. Do NOT change the `.gitignore` and push code to a public repository. Only do it if you make your repository private. This might come handy when working in pairs for the PAs but take caution that no code you write is made available online for others to see.

## Installing Docker + what to make of it
You can install Docker from their official [page](https://docs.docker.com/get-docker/) based on your operating system. 

Do be warned that the Makefile included in this repo is built with a Unix based system in mind. The Docker installation for Windows suggests WSL is required so you will likely need to run anything from the Makefile inside WSL but I do not have a Windows machine and am therefore unable to test this on Windows.

Before you move to the rest of the steps you can think of Docker as an alternative to virtualization technologies which lets you simulate the development environment that is used for this course. You will first need to build the image described in the `Dockerfile` and the `docker-compose.yml` file only once. Once the build succeeds you will just have to:
 1. Start the container up - sort of like turning on the development environment
 2. Connect to the container via a shell so you can compile and run your code
 3. Shut the container down when you are finished working

## Building the image (only once)
You will need to build the image only once for it to be ready to be used. To build the image you can run the command below taken from the Makefile. This step is likely to take a bit of time but luckily enough you will only need to do it once unless changes are introduced to either the `Dockerfile` or the `docker-compose.yml` file.
```
make build
```
A successful build will produce fairly long output that looks something like:
```
sudo docker-compose build
[+] Building 71.3s (9/9) FINISHED
=> [cs221docker internal] load build definition from Dockerfile
=> => transferring dockerfile: 543B
=> [cs221docker internal] load metadata for docker.io/library/gcc:latest
...
...
...
=> [cs221docker 2/4] RUN apt-get update -y &&     apt-get install valgrind -y
...
...
...
 => => naming to docker.io/library/cs221docker-cs221docker
```

## Start the container (anytime you want to use it)
Before anything in this step you want to ensure Docker Desktop is running (so start the desktop application) otherwise you will not be able to start the container. After the image has been build you need to start up the container so it is up and running for you to connect to it. You can do this as shown below:
```
make start
```
A successful start should say:
```
sudo docker-compose up -d
[+] Running 1/1
 ✔ Container cs221docker  Started
```

## Connect to the container (anytime you want to compile and run code)
You will need to compile all source code and run it from the directory where the Makefile is located. Although we do a volume mount and you have a local copy of this Makefile on your machine, your machine does not have the necessary dependecies to compile and run C++ code (or at least not readily so). Thus you will need to connect via a shell to the Docker container after you have started it as shown below. The container name has been fixed so you do not have to worry about finding out which container to connect each time you start it up
```
make connect
```
This will open up a shell that should look like below. You can navigate this shell like you normally would navigate the one from the CS servers. From here you will want to navigate to where you place your labs and find the corresponding Makefile for each lab to compile and run your code.
```
sudo docker exec -it cs221docker bash
root@<SOME STRING>:/usr/cs221dev# 
```
To leave the shell when you no longer want to use it just type `exit` on it.

## Disconnect the container
After you finish working on your files, you may want to shut the container down by doing:
```
make disconnect
```
This should result into the following. 
```
sudo docker-compose down
[+] Running 1/1
 ✔ Container cs221docker Removed
 ✔ Network cs221docker_default  Removed
```

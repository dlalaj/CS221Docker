# Build the image
# NOTE: You should not have the run this after you build the first time
build:
	sudo docker-compose build

# Start up the container - will make the dev environment active
start:
	sudo docker-compose up -d

# Connect to the container from the shell, this will open a shell for you
connect:
	sudo docker exec -it cs221docker bash

# Disconnect from the container - use this when you are done working on your labs
disconnect:
	sudo docker-compose down

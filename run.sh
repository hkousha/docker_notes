#!/bin/bash

# This script will run the container will run the built image.
IMAGE_NAME=$1

if [ -z $IMAGE_NAME ];
then 
  echo "usage: ./run <containers_name>"
  exit 1
fi

# Add a trap to remove the container before exiting.
# This allow us to run the test again without needing to manually remove the container.
trap "{ make container_rm; exit 0; }" SIGINT SIGTERM                                 
# Creating an isolated bridge network for the container.
sudo docker network create --driver bridge isolated
sudo docker run --network=isolated -p 8000:8000 --name $IMAGE_NAME $IMAGE_NAME

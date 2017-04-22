# Set project name
PROJECT_NAME="docker_runner"

# Set default to build and run:
.DEFAULT_GOAL := build_run
.PHONY: build_run
build_run: build run

# Set docker name or gets it from environment if exist
IMAGE_NAME = "docker_test"
ifdef DOCKER_TEST_IMAGE_NAME
	IMAGE_NAME = $(DOCKER_TEST_IMAGE_NAME)
endif

APPLICATION_DIR = $(shell pwd)

# Building docker image from Dockerfile
.PHONY: build
build:
	@echo "running build";
	sudo docker build -t=$(IMAGE_NAME) $(APPLICATION_DIR)

# Running the container
.PHONY: run
run:
	@echo "running the image"
	sudo docker run -p 8000:8000 $(IMAGE_NAME)

## Inspecting the container 
.PHONY: inspect
inspect:
	sudo docker inspect $(IMAGE_NAME)

## Listing all images
.PHONY: list
list:
	sudo docker images

# Remove test container
.PHONY: clean
clean:
	sudo docker image rm -f $(IMAGE_NAME)

# Removing all containers
.PHONY: remove_all
remove_all:
	sudo docker images |awk '{if (NR!=1) {print $3}}' |xargs sudo docker image rm -f

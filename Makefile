# Set project name PROJECT_NAME="docker_runner"

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
	sudo docker build -t=$(IMAGE_NAME) --build-arg user=test_user $(APPLICATION_DIR)

# Running the container and set the name to the image_name
.PHONY: run
run:
	@echo "running the image"
	./run.sh $(IMAGE_NAME)

## Inspecting the container 
.PHONY: inspect
inspect:
	sudo docker inspect $(IMAGE_NAME)

## Listing all images
.PHONY: images
images:
	sudo docker images

# List containers
.PHONY: containers
containers:
	sudo docker container ls

# Remove running containers
.PHONY: container_rm
container_rm:
	sudo docker container rm -f $(IMAGE_NAME) |true

# Remove image
.PHONY: image_rm
image_rm:
	sudo docker image rm -f $(IMAGE_NAME) |true

# Remove test image
.PHONY: clean
clean: container_rm image_rm

# Removing all images
.PHONY: remove_all
remove_all:
	sudo docker container ls |awk '{if (NR!=1) {print $$1}}' |xargs sudo docker container rm -f 
	sudo docker images |awk '{if (NR!=1) {print $$3}}' |xargs sudo docker image rm -f

.PHONY: ps
ps:
	sudo docker exec -it $(IMAGE_NAME) ps aux

.PHONY: network_ls
network_ls:
	sudo docker network ls

.PHONY: network_inspect
network_inspect:
	sudo docker network inspect isolated

.PHONY: attach
attach:
	sudo docker attach $(IMAGE_NAME)

# This might not work if something changes (ip, port,...).
.PHONY: test
test:
	google-chrome 172.18.0.2:8000

VERSION = 6.0.2
NS = suzel
IMAGE_NAME = docker-postgrest

.PHONY: build clean

# Build the container from scratch
build:
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) --build-arg POSTGREST_VERSION=$(VERSION) .

# Delete container image
clean:
	docker rmi $(NS)/$(IMAGE_NAME):$(VERSION) -f

default: build
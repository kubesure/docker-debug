DOCKER=docker
DBUILD=$(DOCKER) build
DTAG= $(DOCKER) tag
DPUSH= $(DOCKER) push

BINARY_NAME=docker-debug
BINARY_VERSION=latest
TAG_LOCAL = $(BINARY_NAME):$(BINARY_VERSION)
TAG_HUB = bikertales/$(BINARY_NAME):$(BINARY_VERSION)

.PHONY: build  # - Builds docker image
build: build
	$(DBUILD) . -t $(TAG_LOCAL)

.PHONY: tag # - Tags local image to docker hub tag
tag: build
	$(DTAG) $(TAG_LOCAL) $(TAG_HUB)

.PHONY: push # - Pushes tag to docker hub
push: tag
	$(DPUSH) $(TAG_HUB)

.PHONY: tasks
tasks:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1 \2/' | expand -t20
IMAGE_NAME ?= bitwarden-action
IMAGE_VERSION ?= $$(cat version.txt)
GITHUB_USERNAME ?= flagbit
CONTAINER_MANAGER ?= docker
DOCKERFILE_PATH ?= ./Dockerfile
GHCR_ACCOUNT ?= flagbit

-include $(MAKE_RULES_PATH)/ghcr.mk

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

run:
	docker run --rm --env-file .env $(IMAGE_NAME):$(IMAGE_VERSION)

run/debug:
	docker run --rm -it --env-file .env $(IMAGE_NAME):$(IMAGE_VERSION) sh
IMAGE_NAME=bitwarden-action
IMAGE_VERSION=0.1.0

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

run:
	docker run --rm --env-file .env $(IMAGE_NAME):$(IMAGE_VERSION)

run/debug:
	docker run --rm -it --env-file .env $(IMAGE_NAME):$(IMAGE_VERSION) sh
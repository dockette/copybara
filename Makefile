DOCKER_IMAGE=dockette/copybara
DOCKER_TAG?=latest
DOCKER_PLATFORMS?=linux/amd64,linux/arm64

.PHONY: build test run

build:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${DOCKER_TAG} latest/

test:
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} java -version
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} copybara help
	docker run --rm -e COPYBARA_SUBCOMMAND=help ${DOCKER_IMAGE}:${DOCKER_TAG}

run:
	docker run --rm -it -v "$${PWD}":/usr/src/app ${DOCKER_IMAGE}:${DOCKER_TAG}

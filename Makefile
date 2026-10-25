DOCKER_IMAGE=dockette/copybara
DOCKER_TAG?=latest
DOCKER_PLATFORMS?=linux/amd64,linux/arm64

include VERSION

.PHONY: build test run

build:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${DOCKER_TAG} latest/

test:
	docker run --rm --entrypoint java ${DOCKER_IMAGE}:${DOCKER_TAG} -version
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} help
	docker run --rm -e COPYBARA_SUBCOMMAND=help ${DOCKER_IMAGE}:${DOCKER_TAG}

run:
	docker run --rm -it -v "$${PWD}":/usr/src/app ${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: version
version:
	@echo ${VERSION}

.PHONY: release
release:
	@sed -i.bak "s/^VERSION=.*/VERSION=$$(date -u +%Y.%m.%d)/" VERSION && rm VERSION.bak
	@cat VERSION

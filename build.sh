#!/usr/bin/env bash

set -e

REPO="caddy"
CADDY_VERSION="v2.6.1"
XCADDY_VERSION="v0.3.5"
DOCKERFILE_HASH=$(git rev-parse --short HEAD)
BUILDER="golang-1.21.1-alpine3.18"

docker_build_tag_and_push()
{
	IMAGE="$1"
	BUILD_ARG="$2"
	TAG="${IMAGE}:${BUILDER}-${CADDY_VERSION}"

	docker build "https://github.com:/manoj23/dockerfile-${REPO}.git" \
		--build-arg "CADDY_VERSION=${CADDY_VERSION}" \
		--build-arg "XCADDY_VERSION=${XCADDY_VERSION}" \
		--build-arg "BUILD_ARGS=${BUILD_ARG}" \
		--build-arg "DOCKERFILE_HASH=${DOCKERFILE_HASH}" \
		-t "$TAG"

	docker tag "${TAG}" "ghcr.io/manoj23/${TAG}"
	docker push "ghcr.io/manoj23/${TAG}"
}

docker_build_tag_and_push "caddy" ""
docker_build_tag_and_push "caddy-webdav" "--with github.com/mholt/caddy-webdav"

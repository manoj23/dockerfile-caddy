REPO="caddy"
CADDY_VERSION="v2.2.0"
IMAGE="caddy"
DOCKERFILE_HASH=$(git rev-parse --short HEAD)
BUILDER="golang-1.19.1-alpine3.16"

docker_build_tag_and_push()
{
	BUILD_ARG="$2"
	TAG="${IMAGE}:${BUILDER}-${CADDY_VERSION}"

	docker build "https://github.com:/manoj23/dockerfile-${REPO}.git" \
		--build-arg "CADDY_VERSION=${CADDY_VERSION}" \
		--build-arg "BUILD_ARGS=${BUILD_ARG}" \
		--build-arg "DOCKERFILE_HASH=${DOCKERFILE_HASH}" \
		-t "$TAG"

	docker tag "${TAG}" "ghcr.io/manoj23/${TAG}"
	docker push "ghcr.io/manoj23/${TAG}"
}

docker_build_tag_and_push "caddy" ""
docker_build_tag_and_push "caddy-webdav" "--with github.com/mholt/caddy-webdav"

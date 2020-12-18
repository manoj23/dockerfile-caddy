FROM golang:1.15.3-alpine3.12 as builder
ARG CADDY_VERSION
ARG BUILD_ARGS
ARG DOCKERFILE_HASH
ENV CADDY_VERSION=${CADDY_VERSION}
ENV PATH=/root/go/bin:${PATH}
RUN apk --no-cache add git \
	&& go get -u github.com/caddyserver/xcaddy/cmd/xcaddy \
	&& xcaddy build ${BUILD_ARGS}
FROM scratch
LABEL maintainer="Georges Savoundararadj <savoundg@gmail.com>"
ARG CADDY_VERSION
ARG BUILD_ARGS
ARG DOCKERFILE_HASH
LABEL CADDY_VERSION=${CADDY_VERSION}
LABEL BUILD_ARGS=${BUILD_ARGS}
LABEL DOCKERFILE_HASH=${DOCKERFILE_HASH}
COPY --from=builder /go/caddy /bin/caddy
EXPOSE 80
ENTRYPOINT [ "/bin/caddy" ]
CMD [ "run", "-config", "/etc/Caddyfile" ]

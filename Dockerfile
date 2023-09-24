FROM golang:1.19.1-alpine3.16 as builder
ARG CADDY_VERSION
ARG XCADDY_VERSION
ARG BUILD_ARGS
ARG DOCKERFILE_HASH
ENV CADDY_VERSION=${CADDY_VERSION}
ENV PATH=/root/go/bin:${PATH}
RUN apk --no-cache add git \
	&& go install github.com/caddyserver/xcaddy/cmd/xcaddy@${XCADDY_VERSION} \
	&& xcaddy build ${CADDY_VERSION} ${BUILD_ARGS}
FROM scratch
LABEL maintainer="Georges Savoundararadj <savoundg@gmail.com>"
ARG CADDY_VERSION
ARG XCADDY_VERSION
ARG BUILD_ARGS
ARG DOCKERFILE_HASH
LABEL org.opencontainers.image.source https://github.com/manoj23/dockerfile-caddy/
LABEL CADDY_VERSION=${CADDY_VERSION}
LABEL XCADDY_VERSION=${XCADDY_VERSION}
LABEL BUILD_ARGS=${BUILD_ARGS}
LABEL DOCKERFILE_HASH=${DOCKERFILE_HASH}
COPY --from=builder /go/caddy /bin/caddy
EXPOSE 80
ENTRYPOINT [ "/bin/caddy" ]
CMD [ "run", "--config", "/etc/Caddyfile" ]

FROM alpine:3.7 as builder
ARG plugins
RUN apk update && apk --no-cache add bash curl gnupg \
	&& curl https://getcaddy.com | bash -s personal ${plugins}
FROM scratch
ARG plugins
LABEL maintainer="Georges Savoundararadj <savoundg@gmail.com>"
LABEL plugins=${plugins}
COPY --from=builder /usr/local/bin/caddy /bin/caddy
EXPOSE 80
ENTRYPOINT [ "/bin/caddy" ]
CMD [ "-conf", "/etc/Caddyfile" ]

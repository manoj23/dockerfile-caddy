FROM alpine:3.7 as builder
ARG plugins
RUN apk update && apk --no-cache add bash curl gnupg ca-certificates \
	&& curl https://getcaddy.com | bash -s personal ${plugins} \
	&& update-ca-certificates \
	&& rm -rf /var/cache/apk/*
FROM scratch
ARG plugins
LABEL maintainer="Georges Savoundararadj <savoundg@gmail.com>"
LABEL plugins=${plugins}
COPY --from=builder /usr/local/bin/caddy /bin/caddy
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs/
EXPOSE 80
ENTRYPOINT [ "/bin/caddy" ]
CMD [ "-conf", "/etc/Caddyfile" ]

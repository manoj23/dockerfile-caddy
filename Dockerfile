FROM alpine:3.7 as builder
LABEL maintainer "Georges Savoundararadj <savoundg@gmail.com>"

RUN apk update && apk --no-cache add bash curl gnupg ca-certificates \
	&& curl https://getcaddy.com | bash -s personal \
	&& update-ca-certificates \
	&& rm -rf /var/cache/apk/*
FROM scratch
COPY --from=builder /usr/local/bin/caddy /bin/caddy
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs/
EXPOSE 80
ENTRYPOINT [ "/bin/caddy" ]
CMD [ "-conf", "/etc/Caddyfile" ]

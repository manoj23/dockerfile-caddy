dockerfile-caddy
================

This is a simple caddy container whose binary is downloaded from the official
website and copied into a scratch image.

## Example of docker run

```
docker build https://github.com:/manoj23/dockerfile-caddy.git -t caddy
docker run --rm -ti -p 80:80 \
	-v /path/to/Caddyfile:/etc/Caddyfile:ro \
	-v /path/to/srv/:/srv/:ro \
	-v /path/to/var/log/:/var/log/ \
	--name caddy caddy
```

## Configuration files

### Caddyfile

```
http://127.0.0.1:80
gzip
root /srv/
log /var/log/access.log {
	rotate_size 100
	rotate_compress
}
errors /var/log/error.log {
	rotate_size 100
	rotate_compress
}
```

## Example of docker-compose.yml

Put in a folder:
* Caddy server configuration file: Caddyfile
* page web: index.html
* docker-compose.yml as below

```
version: '3'
services:
  web:
    build: https://github.com:/manoj23/dockerfile-caddy.git
    volumes:
     - ./Caddyfile:/etc/Caddyfile:ro
     - ./index.html:/srv/index.html:ro
     - ./log/:/var/log
    ports:
     - "80:80"
```

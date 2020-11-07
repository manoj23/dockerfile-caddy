dockerfile-caddy
================

This is a simple caddy container that compiles caddy with xcaddy and copies
the compiled caddy binary into a scratch image.

The following docker image build argument are supported:
* CADDY_VERSION
* BUILD_ARGS

## Example of docker run

```
docker build https://github.com:/manoj23/dockerfile-caddy.git -t caddy \
	 --build-arg CADDY_VERSION=v2.2.0
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
encode gzip
root * /srv/
file_server

log {
	output file /var/log/access.log {
		roll_size 100MiB
		roll_keep 5
	}

	format console
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
    build:
      context: https://github.com:/manoj23/dockerfile-caddy.git
      args:
       - CADDY_VERSION=v2.2.0
    volumes:
     - ./Caddyfile:/etc/Caddyfile:ro
     - ./index.html:/srv/index.html:ro
     - ./log/:/var/log
    ports:
     - "80:80"
```

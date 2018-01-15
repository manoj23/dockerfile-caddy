docker-caddy
============

This is a simple caddy container whose binary is downloaded from the official
website and copied into a scratch image.

# Example

```
docker run --rm -ti -p 80:80 \
	-v /path/to/Caddyfile:/etc/Caddyfile \
	-v /path/to/srv/:/srv/,readonly \
	-v /path/to/var/log/:/var/log/ \
	--name caddy
```

# Example of a Caddyfile

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

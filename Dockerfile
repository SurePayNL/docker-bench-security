FROM alpine:3.7

LABEL \
  org.label-schema.name="docker-bench-security" \
  org.label-schema.url="https://dockerbench.com" \
  org.label-schema.vcs-url="https://github.com/docker/docker-bench-security.git"

COPY ./*.sh /usr/local/bin/
COPY ./tests/*.sh /usr/local/bin/tests/

# Switch to the HTTPS endpoint for the apk repositories
# https://github.com/gliderlabs/docker-alpine/issues/184
RUN \
  sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories && \
  apk add --no-cache \
    docker \
    dumb-init && \
  rm -rf /usr/bin/docker?*

WORKDIR /usr/local/bin

ENTRYPOINT [ "/usr/bin/dumb-init", "docker-bench-security.sh" ]


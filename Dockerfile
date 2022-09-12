FROM alpine:latest

LABEL architecture="x86_64"                       \
      build-date="$BUILD_DATE"                    \
      license="MIT"                               \
      name="mich43l/keepalived"                   \
      summary="debian based keepalived container" \
      vcs-type="git"                              \
      vcs-url="https://github.com/mach1el/docker-keepalived"

RUN apk add --no-cache \
    bash           \
    curl           \
    ipvsadm        \
    iproute2       \
    net-tools      \
    netcat-openbsd \
    dirmngr        \
    runit          \
    procps         \
    parallel       \
    keepalived     \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/keepalived

ADD units /
RUN ln -s /etc/sv/* /etc/service
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /etc/service/*/*
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
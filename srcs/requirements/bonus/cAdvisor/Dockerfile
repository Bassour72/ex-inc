FROM alpine:3.22

RUN apk add --no-cache \
    libc6-compat \
    device-mapper \
    curl

RUN curl -L https://github.com/google/cadvisor/releases/download/v0.55.0/cadvisor-v0.55.0-linux-amd64 \
    -o /usr/bin/cadvisor \
    && chmod +x /usr/bin/cadvisor


COPY tools/entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/usr/bin/entrypoint.sh"]



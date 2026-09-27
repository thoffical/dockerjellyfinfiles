FROM jellyfin/jellyfin:latest

USER root

ARG TARGETARCH=amd64

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl caddy \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL "https://github.com/filebrowser/filebrowser/releases/latest/download/linux-${TARGETARCH}-filebrowser.tar.gz" \
       -o /tmp/filebrowser.tar.gz \
    && tar -xzf /tmp/filebrowser.tar.gz -C /usr/local/bin filebrowser \
    && chmod 755 /usr/local/bin/filebrowser \
    && rm -f /tmp/filebrowser.tar.gz \
    && mkdir -p /config /cache /media \
    && chown -R 1000:1000 /config /cache /media

COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /usr/local/bin/start-blitz.sh
RUN chmod 755 /usr/local/bin/start-blitz.sh && chown 1000:1000 /etc/caddy/Caddyfile

ENV JELLYFIN_DATA_DIR=/config \
    JELLYFIN_CONFIG_DIR=/config/config \
    JELLYFIN_CACHE_DIR=/cache \
    JELLYFIN_LOG_DIR=/config/log \
    FILEBROWSER_ROOT=/media

EXPOSE 8080
VOLUME ["/config", "/cache", "/media"]

USER 1000:1000
ENTRYPOINT ["/usr/local/bin/start-blitz.sh"]

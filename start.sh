#!/bin/sh
set -eu

mkdir -p \
    /config/config \
    /config/log \
    /cache \
    /media

jellyfin \
    --datadir "$JELLYFIN_DATA_DIR" \
    --configdir "$JELLYFIN_CONFIG_DIR" \
    --cachedir "$JELLYFIN_CACHE_DIR" \
    --logdir "$JELLYFIN_LOG_DIR" &

filebrowser \
    --root "$FILEBROWSER_ROOT" \
    --address 127.0.0.1 \
    --port 8081 \
    --baseurl /files \
    --database /config/filebrowser.db &

sleep 5

exec caddy run \
    --config /etc/caddy/Caddyfile \
    --adapter caddyfile
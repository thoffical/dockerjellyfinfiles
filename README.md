# blitz.cloud — Jellyfin + File Browser (latest)

One Docker image:
- `/` → Jellyfin
- `/files` → File Browser
- `/media` → shared persistent media directory
- `/config` → persistent Jellyfin + File Browser data
- `/cache` → persistent cache
- public port: `8080`
- runs as UID/GID `1000:1000`

## Latest versions

Jellyfin uses the official `jellyfin/jellyfin:latest` image. Jellyfin documents `latest` as tracking the latest stable release.

File Browser is downloaded from its GitHub `releases/latest` endpoint during the image build.

## Build and push

```bash
docker buildx build --platform linux/amd64 \
  -t YOUR_DOCKERHUB_USER/blitz-jellyfin-filebrowser:latest \
  --push .
```

Then deploy that image on blitz.cloud with public port `8080` and persistent folders mounted at `/config`, `/cache`, and `/media`.

## Update

Rebuild and push the image with the same `:latest` tag, then redeploy/restart the blitz app. Persistent folders keep the Jellyfin/File Browser data while the container image gets the newest software.

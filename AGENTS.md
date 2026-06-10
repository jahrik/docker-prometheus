# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Purpose

Produces `jahrik/prometheus` — the official `prom/prometheus` image with a homelab Swarm scrape config and alerting rules baked in at `/etc/prometheus/`. Scrape targets use Docker Swarm `tasks.<service>` DNS service discovery (node-exporter and cAdvisor per arch, Traefik, Grafana, Jenkins) and alerts go to `alertmanager:9093`.

## Build & Push

```bash
make build   # build locally as jahrik/prometheus:latest
make push    # push to Docker Hub
make deploy  # docker stack deploy -c docker-compose.yml monitor
```

## CI

`.github/workflows/build.yml` runs on every push to `master`, every PR, and manual dispatch:
1. Builds the image, runs it with port 9090 published, and polls `http://localhost:9090/-/healthy` (60s budget).
2. On `master` only, pushes a multi-arch (amd64 + arm64) image to Docker Hub using the `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` secrets.

## Image internals

- Base: `docker.io/prom/prometheus:v3.12.0` — pinned in the `FROM` line; bump there to upgrade
- Only modification: `COPY` of `conf/prometheus.yml` and `rules/*.yml` into `/etc/prometheus/`
- Entrypoint, `EXPOSE 9090`, `/prometheus` volume, and default flags are all inherited from the official image
- History: this repo used to build Prometheus from source on per-arch golang images with a custom entrypoint — that was replaced wholesale by the official multi-arch image (the old `docker-entrypoint.sh` and `conf/docker-entrypoint.sh` weave-cortex leftovers were deleted)

## Local testing

Docker is not installed on this machine — `docker` is a Podman shim, so `make build` works as-is. Verify with:

```bash
docker run --rm -d -p 9090:9090 --name prom-test jahrik/prometheus:latest
curl -sf http://localhost:9090/-/healthy
docker rm -f prom-test
```

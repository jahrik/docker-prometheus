# Prometheus

[![Build](https://github.com/jahrik/docker-prometheus/actions/workflows/build.yml/badge.svg)](https://github.com/jahrik/docker-prometheus/actions/workflows/build.yml)

Multi-arch (amd64/arm64) [Prometheus](https://prometheus.io/) image with a baked-in scrape config and alerting rules for a homelab Docker Swarm monitoring stack (node-exporter, cAdvisor, Traefik, Grafana, Jenkins via Swarm DNS service discovery).

```bash
docker pull jahrik/prometheus
```

## Build

```bash
make build
```

The Prometheus version is pinned in the Dockerfile `FROM` line (`prom/prometheus:vX.Y.Z`) — bump it there to upgrade. The official image is multi-arch, so no per-architecture build args are needed.

## Configuration

- `conf/prometheus.yml` — scrape configs using Swarm `tasks.<service>` DNS discovery, alertmanager target
- `rules/swarm_node.rules.yml`, `rules/swarm_task.rules.yml` — node and task alerting rules

Both are baked into the image at `/etc/prometheus/`. Rebuild after editing.

## Run

```bash
docker run -d -p 9090:9090 -v prometheus-data:/prometheus jahrik/prometheus
```

## Deploy to Docker Swarm

`docker-compose.yml` deploys onto the external `monitor` overlay network with TSDB data at `/mnt/g1/prometheus`:

```bash
make deploy
```

## CI

GitHub Actions builds the image on every push and PR, waits for `GET /-/healthy`, and on `master` pushes a multi-arch (amd64 + arm64) image to Docker Hub.

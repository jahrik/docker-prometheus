FROM docker.io/prom/prometheus:v3.12.0
LABEL org.opencontainers.image.authors="jahrik@gmail.com"

COPY conf/prometheus.yml /etc/prometheus/prometheus.yml
COPY rules/ /etc/prometheus/

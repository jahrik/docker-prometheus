FROM rycus86/prometheus:aarch64

ENV WEAVE_TOKEN=none

# apk update && sudo apk upgrade && sudo apk add dhclient
# RUN apk update \
#  && apk add dhclient

COPY conf /etc/prometheus/

ENTRYPOINT [ "/etc/prometheus/docker-entrypoint.sh" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/etc/prometheus/console_libraries", \
             "--web.console.templates=/etc/prometheus/consoles" ]

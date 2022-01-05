ARG TAG=
ARG ARCH=
FROM ${ARCH}/golang

RUN apt-get update && \
  apt-get install npm -y

RUN git clone https://github.com/prometheus/prometheus.git
RUN cd prometheus && \
  make build && \
  cp prometheus /bin/prometheus

RUN mkdir -p /etc/prometheus
COPY conf /etc/prometheus/

RUN mkdir -p /prometheus
VOLUME ["/prometheus"]
EXPOSE 9090

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "--config.file=/etc/prometheus/prometheus.yml", "--storage.tsdb.path=/prometheus"]

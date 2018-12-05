FROM arm64v8/golang

ENV WEAVE_TOKEN=none

RUN git clone clone https://github.com/prometheus/prometheus.git
RUN cd prometheus && \
  make build && \
  cp prometheus /bin/prometheus

RUN mkdir /prometheus
COPY conf /etc/prometheus/

VOLUME [ "/prometheus" ]
EXPOSE 9090

ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", ]

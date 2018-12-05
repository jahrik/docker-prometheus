FROM arm64v8/golang

RUN git clone https://github.com/prometheus/prometheus.git
RUN cd prometheus && \
  make build && \
  cp prometheus /bin/prometheus

RUN mkdir -p /etc/prometheus
COPY conf /etc/prometheus/

RUN mkdir -p /prometheus
VOLUME [ "/prometheus" ]
EXPOSE 9090

CMD [ "/bin/prometheus", \
  "--config.file=/etc/prometheus/prometheus.yml", \
  "--storage.tsdb.path=/prometheus", ]

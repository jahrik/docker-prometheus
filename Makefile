IMAGE = "jahrik/arm-prometheus"
TAG := $(shell uname -m)
STACK = "monitor"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	@docker service rm ${STACK}_prometheus || true
	@sleep 10
	@docker stack deploy --resolve-image=never -c docker-compose.yml ${STACK}

.PHONY: all build push deploy

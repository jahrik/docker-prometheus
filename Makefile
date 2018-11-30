IMAGE = "jahrik/arm-prometheus"
TAG := $(shell uname -m)
STACK = "monitor"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	@docker stack deploy --resolve-image=never -c docker-compose.yml ${STACK}

.PHONY: all build push deploy

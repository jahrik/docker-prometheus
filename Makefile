IMAGE = "jahrik/arm-prometheus"
TAG = "arm32v7"
STACK = "monitor"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) .
	@docker tag ${IMAGE}:$(TAG) ${IMAGE}:latest

push:
	@docker push ${IMAGE}:$(TAG)
	@docker push ${IMAGE}:latest

deploy:
	# @docker service rm ${STACK}_prometheus || true
	# @sleep 20
	@docker stack deploy --resolve-image=never -c docker-compose.yml ${STACK}

.PHONY: all build push deploy

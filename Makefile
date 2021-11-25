#!/usr/bin/env make -f

MK_DIR = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
IMAGE_NAME = lunix33/asterisk
TAG ?= latest

CONFIG = /etc/asterisk
SPOOL = /var/spool/asterisk

build:
	docker build -t "$(IMAGE_NAME):$(TAG)" .

run:
	docker run -d \
		--restart=unless-stopped \
		--network="host" \
		--volume="$(MK_DIR)config:$(CONFIG)" \
		--volume="$(MK_DIR)spool:$(SPOOL)" \
		$(IMAGE_NAME)

clean:
	docker rmi -f $(IMAGE_NAME):$(TAG)
	docker rmi -f ubuntu:20.04

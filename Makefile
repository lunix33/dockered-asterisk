#!/usr/bin/env make -f

MK_DIR = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
IMAGE_NAME = lunix33/asterisk
TAG ?= latest

AST_LOCAL_CONFIG ?= $(MK_DIR)config
AST_REMOTE_CONFIG = /etc/asterisk
AST_LOCAL_SPOOL ?= $(MK_DIR)spool
AST_REMOTE_SPOOL = /var/spool/asterisk

build:
	docker build -t "$(IMAGE_NAME):$(TAG)" .

run:
	docker run -d \
		--restart=unless-stopped \
		--network="host" \
		--volume="$(AST_LOCAL_CONFIG):$(AST_REMOTE_CONFIG)" \
		--volume="$(AST_LOCAL_SPOOL):$(AST_REMOTE_SPOOL)" \
		$(IMAGE_NAME)

clean:
	docker rmi -f $(IMAGE_NAME):$(TAG)
	docker rmi -f ubuntu:20.04

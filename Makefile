NAME := nessus-docker
PKG := github.com/controlplane/$(NAME)
REGISTRY := docker.io/controlplane

SHELL := /bin/bash
BUILD_DATE := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)

CONTAINER_NAME_LATEST := $(REGISTRY)/$(NAME):latest

ifeq ($(NODAEMON), true)
	RUN_MODE := 
else
	RUN_MODE := "-d"
endif

.PHONY: all
.SILENT:

all: help

.PHONY: build
build: ## builds a docker image
	@echo "+ $@"
	docker image build . --tag ${CONTAINER_NAME_LATEST}

define pre-run
	@echo "+ pre-run"

	docker rm --force ${NAME} 2>/dev/null || true
endef

.PHONY: run
run: ## runs the last built docker image
	@echo "+ $@"

	@echo ${shell pwd}

	$(pre-run)
	$(run-default)

define run-default
	docker container run ${RUN_MODE} \
		--restart always \
		--publish 8834:8834 \
		--name ${NAME} \
		"${CONTAINER_NAME_LATEST}"
endef

.PHONY: stop
stop: ## stops running container
	@echo "+ $@"
	docker rm --force "${NAME}" || true

.PHONY: clean
clean: ## deletes built image and running container
	@echo "+ $@"
	docker rm --force "${NAME}" || true
	docker rmi --force "${CONTAINER_NAME_LATEST}" || true

.PHONY: help
help: ## parse jobs and descriptions from this Makefile
	@grep -E '^[ a-zA-Z0-9_-]+:([^=]|$$)' $(MAKEFILE_LIST) \
    | grep -Ev '^help\b[[:space:]]*:' \
    | sort \
    | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


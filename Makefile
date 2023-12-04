#VERSION = v2.2.1
VERSION = ""
TAG := $(shell git rev-parse --short master)

.PHONY: all

all: linux windows darwin

linux:
	GOOS=linux GOARCH=amd64 xcaddy build $(VERSION) \
		  --output dist/caddy-amd6-linux-$(TAG)  \
		  --with georgepadayatti/caddy-openapi 

windows:
	GOOS=windows GOARCH=amd64 xcaddy build $(VERSION) \
		  --output dist/caddy-amd6-windows-$(TAG).exe  \
		  --with georgepadayatti/caddy-openapi

darwin:
	GOOS=darwin GOARCH=amd64 xcaddy build $(VERSION) \
		  --output dist/caddy-amd6-darwin-$(TAG)  \
		  --with georgepadayatti/caddy-openapi

build-caddy: ## Build caddy docker image
	docker build --platform=linux/amd64 -t igrantio/bb-consent-caddy:2023.12.2 -f ./Dockerfile_caddy_dev .

publish-caddy: ## Publish caddy docker image to docker hub
	docker push igrantio/bb-consent-caddy:2023.12.2
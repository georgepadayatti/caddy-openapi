FROM caddy:2.7.3-builder AS builder

WORKDIR /build
COPY . /build/

COPY consent-openapi.yaml /consent-openapi.yaml

CMD ["xcaddy", "run", "--config", "Caddyfile"]
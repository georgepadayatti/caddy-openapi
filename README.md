# caddy-openapi

This is a fork from https://github.com/chukmunnlee/caddy-openapi.  This middleware validates HTTP request and response against a OpenAPI V3 Specification file

## Installation

Build caddy with caddy-openapi, run `make`. This will build for Linux, Windows and OSX.

You can also build with `xcaddy`
```
xcaddy build \
    --with georgepadayatti/caddy-openapi
```

Tested with `go version go1.17.1 linux/amd64`.

## Usage

### Caddyfile

Load `examples/customer/customer.yaml` file with defaults

```
:8080 {
  route /api {
    openapi ./examples/customer/customer.yaml
  }
}
```

One with all the options

```
:8080 {
  route /api {
    openapi {
      spec ./examples/customer/customer.yaml
      fall_through
      log_error
    }
  }
}
```

Reports any errors as a `{openapi.error}` [placeholder](https://caddyserver.com/docs/caddyfile/concepts#placeholders) which can be used in other [directives](https://caddyserver.com/docs/caddyfile/directives) like [`respond`](https://caddyserver.com/docs/caddyfile/directives/respond)

| Fields                   | Description |
|--------------------------|-------------|
| `spec <oas_file>`        | The OpenAPI3 YAML file. This attribute is a mandatory |
| `policy_bundle <bundle>` | [OPA](https://www.openpolicyagent.org/) policy bundle created with `opa build`. |
| `fall_through`           | Toggles fall through when the request does do match the provided OpenAPI spec. Default is `false` |
| `validate_servers`       | Enable server validation. Accepts `true`, `false` or just the directive which enables validation. Default is `true`. |
| `log_error`              | Toggles error logging. Default is `false` |
| `check`                  | Enable validation of the request parameters; include one or more of the following directives in the body:`req_params`, `req_body` and `resp_body`. `resp_body` only validates `application/json` payload. Note that validating the request body will implicitly set `req_params` |

Errors are reported in the following 2 [placeholder](https://caddyserver.com/docs/caddyfile/concepts#placeholders). You can use them in other [directives](https://caddyserver.com/docs/caddyfile/directives) like [`respond`](https://caddyserver.com/docs/caddyfile/directives/respond)

| Placeholders          | Description |
|-----------------------|-------------|
| `openapi.error`       | Description of the error |
| `openapi.status_code` | Suggested status code |


Reports any errors as a `{openapi.error}` 

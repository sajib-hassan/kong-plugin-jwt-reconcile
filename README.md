# JWT Reconcile

A Kong plugin that enables an extra HTTP POST/GET request - `jwt-reconcile-request` - before proxying to the original request.

## Description

In some cases, you may need to validate your requests using a separated HTTP service.

For every incoming request, you might forward the `path`, `host`, `headers` and `body` to your `jwt-reconcile-request`. The body response might be injected into the original header request.

## Installation

```bash
$ luarocks install kong-plugin-jwt-reconcile
```

Update the `plugins` config to add `jwt-reconcile`:

```
plugins = bundled,jwt-reconcile
```

### Inject user data into the header

1. Request with some JWT;
2. `jwt-reconcile` will send `jwt-reconcile-request` to some service;
3. The service will validate the JWT, perform some custom logic and return a JSON with `role` and `userId` properties;
4. `jwt-reconcile` will add the `role` and `userId` to the original header: `x-role` and `x-user-id`;
5. The destination service doesn't need to validate the JWT, just rely on the headers `x-role` and `x-user-id`.

## Configuration

You can add the plugin on top of an API by executing the following request on your Kong server:

```bash
$ curl -X POST http://kong:8001/apis/{api}/plugins \
    --data "name=jwt-reconcile" \
    --data "config.url=http://myservice:8080"
```

| Parameter | default | description |
| ---       | ---     | ---         |
| `config.url` | [required] | Service where the requests will be made. |
| `config.path` | /api/v1/auth/reconcile  | Path on service where the requests will be made. |
| `config.method` | POST | Allowed values: `POST` and `GET`. |
| `config.connect_timeout` | 5000 | Connection timeout (in ms) to the provided url. |
| `config.send_timeout` | 10000 | Send timeout (in ms) to the provided url. |
| `config.read_timeout` | 10000 | Read timeout (in ms) to the provided url. |
| `config.copy_headers` | true | Forward the request headers to `jwt-reconcile-request` headers. |
| `config.forward_path` | false | Forward the request path to `jwt-reconcile-request` body. |
| `config.forward_query` | false | Forward the request query to `jwt-reconcile-request` body. |
| `config.forward_headers` | false | Forward the request headers to `jwt-reconcile-request` body. |
| `config.forward_body` | false | Forward the request body to `jwt-reconcile-request` body. |
| `config.inject_body_response_into_header` | true | Inject `jwt-reconcile-request` response into the request header. Note: The response MUST BE a JSON and the property key will be dasherized (kebab-case).  |
| `config.injected_header_prefix` | "" (empty) | Prefix to the injected headers. |
| `config.streamdown_injected_headers` | false | When this option is enabled, `jwt-reconcile` will add to the response header all headers added by `jwt-reconcile` and by the middle-service. |



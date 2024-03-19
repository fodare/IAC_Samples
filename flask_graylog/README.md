# Introduction

Simple flask app with `GELF` HTTP logging.

## Build sample flask app

The sample flask app has a `Dockerfile` to help build a docker image and run a container.

```bash
docker image build -t flask-log:0.1 .
```

## Start services

The `compose.yml` file contains all service definitions. Update the service(s) specs as needed.

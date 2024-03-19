# Introduction

Simple flask app with `GELF` HTTP logging.

## Build sample flask app

The sample flask app has a `Dockerfile` to help build a docker image and run a container.

```bash
docker image build -t flask-log:0.1 .
```

## Start services

The `compose.yml` file contains all service definitions. Update the service(s) specs as needed.

## Enable GELF input

Once the Graylog service is running, navigate to the apps GUI <http://127.0.0.1:9000>. The sample flask app sends app logs via HTTP connection, checkout <https://archivedocs.graylog.org/en/latest/pages/sending_data.html#gelf-via-http> for more info on the input type.

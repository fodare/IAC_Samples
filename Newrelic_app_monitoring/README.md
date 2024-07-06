# TLDR

Tmeplate to monitor dotnet application via Newrelic APM.

## Instrument application

Before starting containarized application, update the `Install the agent` and `Enable the agent` section of the application `Dockerfile`.

To start containarized application, run the commands below.

```bash
# Build docker image.
docker image build -t {image name}:{version} .

# Start container from image.
docker run -d --name dotnetapp -p 8080:8080 -e appVersion="V.0.3" -e NEW_RELIC_REGION=eu -e NEW_RELIC_APPLICATION_LOGGING_ENABLED=true -e NEW_RELIC_APPLICATION_LOGGING_FORWARDING_ENABLED=true -e NEW_RELIC_APPLICATION_LOGGING_FORWARDING_CONTEXT_DATA_ENABLED=true -e NEW_RELIC_APPLICATION_LOGGING_FORWARDING_MAX_SAMPLES_STORED=10000 -e NEW_RELIC_APPLICATION_LOGGING_LOCAL_DECORATING_ENABLED=false dotnetapp:latest 
```

Note: The tmeplate does not cover infrastructure monitoring. To activate infrastructure monitoring, run the docker container below.

```bash
docker run -d --name newrelic-infra --network=host \ --cap-add=SYS_PTRACE \ 
--privileged --pid=host \ 
-v "/:/host:ro" \
-v "/var/run/docker.sock:/var/run/docker.sock" \
-e NRIA_LICENSE_KEY={enter license key} \
newrelic/infrastructure:latest
```

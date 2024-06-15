# TLDR

Sample and basic template for server monitoring using Prometheus and Grafana.

## Run stack

Root folder contains `compose.yml` file to help start connected services and the `prometheus.yml` to help manage and configure prometheus.

```bash
# Start services
$ sudo docker compose up -d

# Ensure services status are running
$ sudo docker container ps -a

# Stop and remove services
$ docker compose down

# Remove local volumes
$ docker compose down -v
```

Checkout [Grafana dashboards](https://grafana.com/grafana/dashboards/) for more Grafana dashboards.

# TLDR

Sample template to start and manage multipe instances of elastic search. The template also contains a simple python cli application that shares application logs with local elastic instances.

## Setup

- Update the `.env` file with desired values.

- Make sure to allocate at least 4GB of memory, else the application will not start.
  - If you do encounter memory issues, please run command below:

    ```bash
    sudo sysctl -w vm.max_map_count=262144
    ```

- Start services with the command below.

    ```bash
    # Start in deamon mode
    sudo docker-compose up -d
    ```

From your local browser, navigate to [http://localhost:<KIBANA_PORT>](http://localhost:5601). Username `elastic` and password is the value of `ELASTIC_PASSWORD`.

To stop deamon services, simply execute command `sudo docker-compose down`.

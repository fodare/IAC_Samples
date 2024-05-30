# TLDR

Sample template to start and manage multipe instances of elastic search. The template also contains a simple python cli application that shares application logs with local elastic instances.

## Setup

- Update the `.env` file with desired values.

- Make sure to allocate at least 4GB of memory, else the application will not start.
  - If you do encounter memory issues, please run command below:

    ```bash
    sudo sysctl -w vm.max_map_count=262144
    ```

- Build sample application docker file. Navigate into the `sample_application` DIR and build an image with the command below:

  ```bash
  sudo docker image build -t sampleapp:0.0.1 .
  ```

  - Update the docker-compose `sampleApp` image name and tag located in the `.env` file if you used another image name / image tag.

- Start services with the command below.

    ```bash
    # Start in deamon mode
    sudo docker-compose up -d
    ```

From your local browser, navigate to [http://localhost:<KIBANA_PORT>](http://localhost:5601). Username `elastic` and password is the value of `ELASTIC_PASSWORD`.

To index logs from the sample app, make local random `GET` calls to [http://localhost:<sample_app_port>](http://localhost:5000)

To stop and remove deamon services, simply execute command `sudo docker-compose down`.

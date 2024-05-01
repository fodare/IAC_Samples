# TLDR

Basic docker file to create a simple Nginx reverse-proxy server.

## Update and start proxy server

- Ensure you have docker installed.

- Update `default.conf` file and build docker image.

- Build docker file.

    ```bash
    sudo docker build -t <docker image name> .
    ```

- Create / run docker container from image created above.

    ```bash
    # Example
    docker run -d -p 80:80 --name nginx-reverse-proxy <image name>
    ```

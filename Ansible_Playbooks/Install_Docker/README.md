# Introduction

Template creates a Linux virtual machine with a public IP address and install / configure software(s) on provisioned servers.

## Setup

- First provision Azure VM(s). Terraform template in `Simple_linux_VM`.
- Obtain the public IP(s) of provisioned virtual machines.
- Update the IP(s) in the `ansible_hosts` file.
- Ping host(s) to verify control node can reach managed node(s).

    ```bash
    ansible -m ping all
    ```

## Execute installation play book

Run command below to update, upgrade vm apt repo and install Docker.

```bash
ansible-playbook install_docker.yml
```

# TLDR

Sample template to deploy an Azure load balancer with managed virtual machines.

## Prepare environment

Ensure you have:

- The az cli bastion extension installed.
- A privileged Azure service principle.
- Service principle credentials exported.

    ```bash
    export ARM_CLIENT_ID="service principle client id"
    export ARM_CLIENT_SECRET="service principal password"
    export ARM_TENANT_ID="service principle tenant id"
    export ARM_SUBSCRIPTION_ID="subcription id"
    ```

## Deploy infrastructure

- Login with service principle.

    ```bash
    az login --service-principal -u <app-id> -p <password> --tenant <tenant id>
    ```

- Validate, create and review terraform plan.

    ```bash
    terraform init

    terraform validate

    # Save plan to file: terraform plan -out tf.plan
    terraform plan
    ```

- Apply / create infrastructure.

    ```bash
    # Apply from file. terraform apply tf.plan
    terraform apply
    ```

## Deploy application

There are no application / web server running on the provisioned VMs. Below are steps to spawn applications on the provisioned VMs.

- Connect to specific VM via Bastion host

    ```bash
    az network bastion ssh --name $(bastion host-name) --resource-group $(resource group name) --target-ip-address ($vm ip private ip address) --auth-type "ssh-key" --username $(vm-userName) --ssh-key "$(ssh key file)"
    ```

- Run application bash script.

    ```bash
    # Update apt
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt autoremove -y && sudo snap refresh

    # Sample application needs and runs on docker
    curl -fsSL <https://get.docker.com> -o get-docker.sh
    sudo sh get-docker.sh

    sudo docker run -d -p 80:5000 --name wiseapp openops/wise_comparison:0.1
    ```

Once desired application is running on provisioned VMs. You can access it via the public loadbalancer IP address. Example [http://lb-IpAddress](http://lbIpAddress)

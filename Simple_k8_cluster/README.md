# Prerequisite

- Fill in and export Azure service principal

```bash
export ARM_CLIENT_ID="xxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxx"
export ARM_TENANT_ID="xxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxx"
```

## Provisioning

- Initialize, plan and apply Terraform.

```bash
# Initialize.
terraform init

# Terraform plan.
terraform plan

# Apply plan and provision resources.
terraform apply
```

- Destroy resources.

```bash
terraform plan

```

## Connecting and deploy to K8s Cluster

```bash
# Login with Az CLI
az login --tenant {tenant id}

# Connect to cluster
az aks get-credentials --name {enter cluster name} -- resource-group {enter resource group name}

# Deploy app to cluster
kubectl apply app_deployment.yaml

# Expose  the deployment
kubectl expose deployment wiseapp --type=LoadBalancer --name=wise-serviced

# Get K8s services. The public IP adess and port from the browser exposes
# sample app.
kubectl get services
```

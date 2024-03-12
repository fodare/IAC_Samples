# Introduction

Template creates a linux virtual machine with a public Ip address.

## Provisioning

- First fill in and export Azure service principal in your CLI / termninal.

```bash
export ARM_CLIENT_ID="xxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxx"
export ARM_TENANT_ID="xxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxx"
```

- Create CLI az context.

```bash
az login --tenant <tenant id>
```

- Initialize, update var.tf (if needed) and provision vm.

```bash
# Initialize terraform
terraform init

# Create and review terraform plan.
terraform plan

# Provision virtual machine
terraform apply

# Connect to vm 
ssh <vm username>@<vm public ip>

# Decomission vm
terraform destroy

# Delete Network watcher resource group.
az group delete --name NetworkWatcherRG
```

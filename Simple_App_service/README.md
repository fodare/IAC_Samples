# Intro

Simple IAC templates files to help provision Infra and deploy sample app to a managed Azure app service.

## Provisioning

- First fill in and export Azure service principal in your CLI / termninal

```bash
export ARM_CLIENT_ID="xxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxx"
export ARM_TENANT_ID="xxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxx"
```

- Create and apply Terraform plan

```bash
# Set Azure context
az login --tenant <Your azure tenant id>

# Create and review terraform plan
terraform validate && terraform plan

# Apply terraform plan
terraform apply
```

- Deploy sample app to provisioned app service.

```bash
az webapp up --name <app service name> --resource-group <resource group name> --plan <app service name>
```

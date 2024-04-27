```bash
az network bastion ssh --name $(bastion host-name) --resource-group $(resource group name) --target-ip-address ($vm ip private ip address) --auth-type "ssh-key" --username $(vm-userName) --ssh-key "$(ssh key file)"
```

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

- Install the AZ bastion extension

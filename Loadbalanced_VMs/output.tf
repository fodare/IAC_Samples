output "public_ip" {
  value = azurerm_public_ip.az_publicip[*].ip_address
}

output "vm_private_ip_addresses" {
  value = azurerm_linux_virtual_machine.az_vm[*].private_ip_address
}

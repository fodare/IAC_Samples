output "virtual_machine_public_ip_address" {
  value = azurerm_linux_virtual_machine.virtual_machine[*].public_ip_address
}

output "service_plan_info" {
  value = azurerm_service_plan.test_sp
}

output "app_service_id" {
  value = azurerm_linux_web_app.test_as.id
}

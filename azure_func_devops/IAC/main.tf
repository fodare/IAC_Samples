terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "azgroup" {
  name     = var.resource_groupName
  location = var.resource_groupLocation
}

resource "azurerm_storage_account" "azsa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.azgroup.name
  location                 = azurerm_resource_group.azgroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "azsp" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.azgroup.name
  location            = azurerm_resource_group.azgroup.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "azfunc" {
  name                       = var.azure_function_name
  resource_group_name        = azurerm_resource_group.azgroup.name
  location                   = azurerm_resource_group.azgroup.location
  storage_account_name       = azurerm_storage_account.azsa.name
  storage_account_access_key = azurerm_storage_account.azsa.primary_access_key
  service_plan_id            = azurerm_service_plan.azsp.id

  site_config {}
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
  }
}

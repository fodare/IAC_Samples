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

resource "azurerm_resource_group" "az_group" {
  name     = var.resource_groupName
  location = var.resource_groupLocation
}

resource "azurerm_storage_account" "az_sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.az_group.name
  location                 = azurerm_resource_group.az_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "az_sp" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.az_group.name
  location            = azurerm_resource_group.az_group.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "az_func" {
  name                       = var.azure_function_name
  resource_group_name        = azurerm_resource_group.az_group.name
  location                   = azurerm_resource_group.az_group.location
  storage_account_name       = azurerm_storage_account.az_sa.name
  storage_account_access_key = azurerm_storage_accousnt.az_sa.primary_access_key
  service_plan_id            = azurerm_service_plan.az_sp.id

  site_config {}
  app_settings = {}
}

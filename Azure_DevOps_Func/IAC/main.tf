terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}


resource "azurerm_resource_group" "azure_rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "azure_sa" {
  name                     = var.stroage_account_name
  resource_group_name      = azurerm_resource_group.azure_rg.name
  location                 = azurerm_resource_group.azure_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "azure_sp" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.azure_rg.name
  location            = azurerm_resource_group.azure_rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_function_app" "azure_fa" {
  name                       = var.function_app_name
  location                   = azurerm_resource_group.azure_rg.location
  resource_group_name        = azurerm_resource_group.azure_rg.name
  app_service_plan_id        = azurerm_service_plan.azure_sp.id
  storage_account_name       = azurerm_storage_account.azure_sa.name
  storage_account_access_key = azurerm_storage_account.azure_sa.primary_access_key
  os_type                    = "linux"
  version                    = "~3"

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"     = 1
    SCM_DO_BUILD_DURING_DEPLOYMENT = true
  }
}

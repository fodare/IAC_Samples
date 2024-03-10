terraform {
  required_version = ">=1.0"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

provider "azurerm" {
  # skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "test-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_service_plan" "test_sp" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = azurerm_resource_group.test-rg.location
  os_type             = "Linux"
  sku_name            = var.service_sku_name
  tags = {
    Environment = var.app_service_environment_tag
  }
}

resource "azurerm_linux_web_app" "test_as" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = azurerm_resource_group.test-rg.location
  service_plan_id     = azurerm_service_plan.test_sp.id
  tags = {
    Environment = var.app_service_environment_tag
  }
  site_config {
    always_on = false
    application_stack {
      python_version = var.application_stack_version
    }
  }

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT : true
    WEBSITE_RUN_FROM_PACKAGE : 1
  }
}

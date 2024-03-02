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

resource "azurerm_resource_group" "devrg" {
  name     = "Dev-ResourceGroup"
  location = "NORTH EUROPE"
  tags = {
    Environment = "Dev"
  }
}

resource "azurerm_kubernetes_cluster" "devK8sCluster" {
  name                = "dev_k8s"
  location            = azurerm_resource_group.devrg.location
  resource_group_name = azurerm_resource_group.devrg.name
  dns_prefix          = "devaks"

  default_node_pool {
    name       = "devaksnode"
    node_count = var.node_count
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}

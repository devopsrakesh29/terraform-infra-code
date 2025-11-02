terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }
  }
}

provider "azurerm" {
  features {}
  alias           = "resource_group_provider"
  subscription_id = var.rg_subscription_id
}

provider "azurerm" {
  features {}
  alias           = "storage_account_provider"
  subscription_id = var.storage_account_subscription_id
}

provider "azurerm" {
  features {}
  alias = "vnet_provider"
  subscription_id = var.vnet_subscription_id
}

# provider "azurerm" {
#   alias= "aks"
#   features {}
#   subscription_id = var.aks_subscription_id
# }
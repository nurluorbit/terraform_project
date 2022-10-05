terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dev-rg" {
  name     = "dev-resources"
  location = "West Europe"
  tags = {
    environment = "dev"
  }
}

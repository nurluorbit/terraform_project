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

resource "azurerm_virtual_network" "dev-vn" {
  name                = "dev-network"
  resource_group_name = azurerm_resource_group.dev-vn.name
  location            = azurerm_resource_group.dev-vn.location
  address_space       = ["10.123.0.0/16"]

  subnet {
    name           = "dev-subnet"
    address_prefix = ["10.123.1.0/24"]
  }

  tags = {
    environment = "dev"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.1"
    }
  }
}

provider "azurerm" {
  features {}
}

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
  subscription_id = "c1465aee-6b01-4afe-9346-d8ec9ab106a8"
  client_id       = "1a0a5f71-9201-4bb3-9eb1-6e188d1e8ecb"
  client_secret   = "NuT8Q~6DBb07rvfCqmRONYJGYFX3VI9H2bYyrdcD"
  tenant_id       = "185c7411-5580-4d7b-868d-8cf0c4526b03"

}

terraform {
  required_version = ">= 1.12.0 < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    alz = {
      source  = "azure/alz"
      version = "~> 0.21"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~> 2.12"
    }
  }
}

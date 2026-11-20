terraform {
  required_version = ">= 1.12.0, < 2.0.0"

  required_providers {
    alz = {
      source  = "Azure/alz"
      version = "~> 0.21"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.12"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

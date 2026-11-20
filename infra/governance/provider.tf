provider "alz" {
  library_references = [
    {
      path = "platform/alz"
      ref  = "2026.04.2"
    },
    {
      custom_url = "${path.root}/lib"
    }
  ]
}

provider "azapi" {
}

provider "azurerm" {
  features {}

  resource_provider_registrations = "none"
}

data "azurerm_client_config" "current" {}

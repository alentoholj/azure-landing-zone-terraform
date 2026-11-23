provider "azurerm" {
  subscription_id = var.management_subscription_id
  features {}

  resource_provider_registrations = "none"
  resource_providers_to_register = [
    "Microsoft.Insights",
    "Microsoft.ManagedIdentity",
    "Microsoft.OperationalInsights",
    "Microsoft.OperationsManagement",
  ]
}

provider "azapi" {
  subscription_id = var.management_subscription_id
}

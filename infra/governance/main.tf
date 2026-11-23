locals {
  location = "westeurope"
}
module "governance" {
  source  = "Azure/avm-ptn-alz/azurerm"
  version = "0.23.0"

  architecture_name  = "crp"
  location           = local.location
  parent_resource_id = data.azurerm_client_config.current.tenant_id

  subscription_placement = {
    management = {
      subscription_id       = var.management_subscription_id
      management_group_name = "crp-management"
    }
  }

  enable_telemetry = false
}

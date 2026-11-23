module "governance" {
  source  = "Azure/avm-ptn-alz/azurerm"
  version = "0.23.0"

  architecture_name  = "crp"
  location           = "westeurope"
  parent_resource_id = data.azurerm_client_config.current.tenant_id

  # AVM telemetry creates an empty ARM deployment in the subscription, which
  # needs subscription-level rights the pipeline identity does not have.
  enable_telemetry = false
}

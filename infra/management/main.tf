locals {
  location = "westeurope"
}

module "management" {
  source  = "Azure/avm-ptn-alz-management/azurerm"
  version = "0.10.0"

  location                     = local.location
  resource_group_name          = "rg-crp-management-weu"
  log_analytics_workspace_name = "law-crp-management-weu"

  automation_account_name                    = "aa-crp-management-weu"
  linked_automation_account_creation_enabled = true

  log_analytics_workspace_retention_in_days = 30

  log_analytics_workspace_daily_quota_gb = 1

  log_analytics_solution_plans = []

  data_collection_rules = {
    change_tracking = {
      name = "dcr-crp-change-tracking-weu"
    }
    vm_insights = {
      name = "dcr-crp-vm-insights-weu"
    }
    defender_sql = {
      name = "dcr-crp-defender-sql-weu"
    }
  }

  user_assigned_managed_identities = {
    ama = {
      name = "uami-crp-ama-weu"
    }
  }

  sentinel_onboarding = null

  enable_telemetry = false
}

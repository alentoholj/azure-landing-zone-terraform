output "management_resource_group_name" {
  description = "Name of the management resource group."
  value       = module.management.resource_group.name
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the central Log Analytics workspace."
  value       = module.management.log_analytics_workspace.id
}

output "data_collection_rule_ids" {
  description = "Resource IDs of the Azure Monitor data collection rules."
  value       = module.management.data_collection_rule_ids
}

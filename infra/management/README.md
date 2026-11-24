# Management stack

Deploys the central monitoring resources into the dedicated management
subscription with the
[ALZ management pattern module](https://registry.terraform.io/modules/Azure/avm-ptn-alz-management/azurerm/latest)
(`Azure/avm-ptn-alz-management/azurerm`).

| | |
| --- | --- |
| State key | `management.tfstate` |
| Subscription | Management subscription, placed in `crp-management` by the [governance stack](../governance/README.md) |
| Deployed by | `management` job in [Terraform CI](../../.github/workflows/terraform-ci.yml) |
| Runs | After governance |

## What is deployed

| Resource | Name |
| --- | --- |
| Resource group | `rg-crp-management-weu` |
| Log Analytics workspace | `law-crp-management-weu` (30-day retention, 1 GB daily cap) |
| Data collection rules | `dcr-crp-change-tracking-weu`, `dcr-crp-vm-insights-weu`, `dcr-crp-defender-sql-weu` |
| User-assigned managed identity (Azure Monitor Agent) | `uami-crp-ama-weu` |

## Deliberately disabled

| Feature | Why |
| --- | --- |
| Automation account | Its main use (Update Management, Change Tracking v1) is retired. Replaced by Azure Update Manager and AMA with data collection rules. |
| Log Analytics solutions (ContainerInsights, VMInsights) | Legacy; Container and VM Insights now use AMA with data collection rules. |
| Microsoft Sentinel | Billed per GB on top of Log Analytics. |
| AVM telemetry | Creates an extra ARM deployment for Microsoft usage tracking. |

## Cost

Close to zero while nothing sends data. Log Analytics is billed per GB
ingested; the daily cap (`log_analytics_workspace_daily_quota_gb = 1`) stops
ingestion for the day after 1 GB.

## Notes

- **Resource providers**: a new subscription has none registered, so the
  `azurerm` provider registers only the four this stack needs (see
  [`provider.tf`](provider.tf)). This happens during `plan`.
- **Permissions**: the pipeline identity needs Owner on the management
  subscription.
- **Destroy**: the Log Analytics workspace is soft-deleted for 14 days; its
  name stays reserved during that time.

## Inputs in CI

| Terraform variable | Source |
| --- | --- |
| `management_subscription_id` | GitHub variable `MANAGEMENT_SUBSCRIPTION_ID` (environment `crp-caf`) |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0, < 2.0.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.12 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.35 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_management"></a> [management](#module\_management) | Azure/avm-ptn-alz-management/azurerm | 0.10.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_management_subscription_id"></a> [management\_subscription\_id](#input\_management\_subscription\_id) | ID of the dedicated management subscription that hosts the Log Analytics workspace and related resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_data_collection_rule_ids"></a> [data\_collection\_rule\_ids](#output\_data\_collection\_rule\_ids) | Resource IDs of the Azure Monitor data collection rules. |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | Resource ID of the central Log Analytics workspace. |
| <a name="output_management_resource_group_name"></a> [management\_resource\_group\_name](#output\_management\_resource\_group\_name) | Name of the management resource group. |
<!-- END_TF_DOCS -->

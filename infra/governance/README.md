# Governance stack

Deploys the CRP management group hierarchy with the
[ALZ pattern module](https://registry.terraform.io/modules/Azure/avm-ptn-alz/azurerm/latest)
(`Azure/avm-ptn-alz/azurerm`) and places the platform subscriptions into it.

| | |
| --- | --- |
| State key | `governance.tfstate` |
| Deployed by | `governance` job in [Terraform CI](../../.github/workflows/terraform-ci.yml) |
| Runs | First, before all other stacks |

## Management group hierarchy

Defined in [`lib/architecture_definitions/crp.alz_architecture_definition.yaml`](lib/architecture_definitions/crp.alz_architecture_definition.yaml).
No archetypes (policies) are assigned yet.

```text
Tenant Root Group
└── crp-root
    ├── crp-platform
    │   ├── crp-management      ← management subscription
    │   ├── crp-connectivity
    │   ├── crp-identity
    │   └── crp-security
    ├── crp-landingzones
    │   ├── crp-corp
    │   └── crp-online
    ├── crp-sandbox
    └── crp-decommissioned
```

To change the hierarchy, edit the YAML file. Custom archetypes go in
`lib/archetype_definitions/`, which the `alz` provider loads alongside the
ALZ library (`platform/alz`, pinned in [`provider.tf`](provider.tf)).

## Notes

- **Subscription placement**: the management subscription is placed in
  `crp-management` here, because moving subscriptions is a management group
  change. Its resources are deployed by the [management stack](../management/README.md).
- **`imports.tf`** adopted the existing placement into state. It is a no-op
  now and can be deleted; delete it before any destroy and redeploy.
- **Telemetry** is disabled (`enable_telemetry = false`). AVM telemetry
  creates an ARM deployment at subscription scope.
- **Permissions**: the pipeline identity needs Management Group Contributor
  on the Tenant Root Group, and Owner on any subscription it places.

## Inputs in CI

| Terraform variable | Source |
| --- | --- |
| `management_subscription_id` | GitHub variable `MANAGEMENT_SUBSCRIPTION_ID` (environment `crp-caf`) |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0, < 2.0.0 |
| <a name="requirement_alz"></a> [alz](#requirement\_alz) | ~> 0.21 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.12 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.81.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_governance"></a> [governance](#module\_governance) | Azure/avm-ptn-alz/azurerm | 0.23.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_management_subscription_id"></a> [management\_subscription\_id](#input\_management\_subscription\_id) | ID of the dedicated management subscription, placed in the crp-management management group. Its resources are deployed by the infra/management stack. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

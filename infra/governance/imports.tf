# The management subscription was created directly in crp-management, so the
# placement already exists in Azure. Adopt it into state instead of creating it.
# This block is a no-op once the import has been applied and can be removed then.
import {
  to = module.governance.azapi_resource.subscription_placement["management"]
  id = "/providers/Microsoft.Management/managementGroups/crp-management/subscriptions/${var.management_subscription_id}"
}

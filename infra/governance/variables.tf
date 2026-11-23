variable "management_subscription_id" {
  type        = string
  description = "ID of the dedicated management subscription, placed in the crp-management management group. Its resources are deployed by the infra/management stack."

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.management_subscription_id))
    error_message = "management_subscription_id must be a lowercase subscription GUID."
  }
}

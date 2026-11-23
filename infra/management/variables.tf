variable "management_subscription_id" {
  type        = string
  description = "ID of the dedicated management subscription that hosts the Log Analytics workspace and related resources."

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.management_subscription_id))
    error_message = "management_subscription_id must be a lowercase subscription GUID."
  }
}

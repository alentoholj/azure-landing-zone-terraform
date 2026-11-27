# TFLint configuration shared by every stack under infra/.
# Run locally from the repo root:
#   tflint --init --config "$PWD/.tflint.hcl"
#   tflint --recursive --chdir infra --config "$PWD/.tflint.hcl"

config {
  # Only inspect modules in this repository. The AVM modules are linted by
  # their own maintainers.
  call_module_type = "local"
  format           = "compact"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "azurerm" {
  enabled = true
  version = "0.33.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

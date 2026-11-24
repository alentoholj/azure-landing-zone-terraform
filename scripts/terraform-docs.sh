#!/usr/bin/env bash
# Regenerate the terraform-docs section of README.md in every stack under infra/.
# Used by the pre-commit hook and by the Terraform Docs CI check.
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "${repo_root}"

for stack in infra/*/; do
  [ -f "${stack}main.tf" ] || continue
  terraform-docs --config .terraform-docs.yml "${stack}"
done

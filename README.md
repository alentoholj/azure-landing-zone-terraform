# azure-landing-zone-terraform

CAF-aligned Azure Landing Zone implemented with Terraform, Azure Verified Modules (AVM), and GitHub Actions.

## Stacks

Each folder under `infra/` is an independent Terraform stack with its own state file, plan, approval and apply.

| Stack | Purpose | State key | Docs |
| --- | --- | --- | --- |
| `governance` | Management group hierarchy and subscription placement (`avm-ptn-alz`) | `governance.tfstate` | [infra/governance](infra/governance/README.md) |
| `management` | Log Analytics workspace, data collection rules, AMA identity (`avm-ptn-alz-management`) | `management.tfstate` | [infra/management](infra/management/README.md) |

Stacks are deployed in this order. Destroy in reverse order.

## Pipeline

[`terraform-ci.yml`](.github/workflows/terraform-ci.yml) calls the reusable
[`terraform-stack.yml`](.github/workflows/terraform-stack.yml) once per stack:

```text
Pull request:   Format & Validate → Plan
Push to main:   Format & Validate → Plan → Approve Apply (manual) → Apply
```

- Azure authentication uses OIDC through the `crp-caf` environment.
- Manual approval uses the `crp-caf-approval` environment (required reviewers).
- The repository is public, so plan output is never written to the logs. The run
  summary lists resource addresses and actions only; the saved plan is encrypted
  before it is uploaded.

[`terraform-docs.yml`](.github/workflows/terraform-docs.yml) fails a pull request
when a stack README is out of date.

## Security

[`security.yml`](.github/workflows/security.yml) runs on every pull request, on
`main`, and weekly. Results appear under **Security → Code scanning**.

| Tool | Checks | Fails on |
| --- | --- | --- |
| [zizmor](https://docs.zizmor.sh) | Workflows and Dependabot config: injection, unpinned actions, permissions, credential persistence | Medium or higher |
| [TFLint](https://github.com/terraform-linters/tflint) | Terraform lint rules (`recommended` preset) and the azurerm ruleset, configured in [`.tflint.hcl`](.tflint.hcl) | Any issue |
| [Trivy](https://trivy.dev) | Terraform misconfigurations, including the downloaded AVM modules | HIGH or CRITICAL |

Supply chain hardening:

- Every action is pinned to a full commit SHA; [Dependabot](.github/dependabot.yml)
  proposes updates weekly, at least 7 days after a release.
- Tool binaries (terraform-docs, zizmor, TFLint, Trivy) are verified against a
  SHA-256 pinned in the workflow. Update the version and hash together.
- `actions/checkout` never persists the GitHub token, and the stack workflow
  receives no secrets from its caller; the plan passphrase is an environment
  secret of `crp-caf`.

## Local development

Requirements: Terraform, [terraform-docs](https://terraform-docs.io) and [pre-commit](https://pre-commit.com).

```bash
pre-commit install          # once per clone
pre-commit run --all-files  # run all hooks manually
```

On every commit, the hooks run `terraform fmt` and regenerate the terraform-docs
section of each stack README (configured in [`.terraform-docs.yml`](.terraform-docs.yml)).
Only the block between `<!-- BEGIN_TF_DOCS -->` and `<!-- END_TF_DOCS -->` is
generated; edit everything above it by hand.

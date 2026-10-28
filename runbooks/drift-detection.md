# Runbook: Terraform Drift Detection

## Purpose
Detect differences between the configuration/state and the actual cloud resources without automatically changing infrastructure.

## Procedure
1. Run the plan from the correct environment root using the correct remote state and read-only/plan identity.
2. Use `terraform plan -detailed-exitcode`.
   - Exit code `0`: no changes detected.
   - Exit code `1`: plan error; investigate authentication, backend, provider, or configuration failures.
   - Exit code `2`: changes are present.
3. For exit code `2`, capture the run URL, commit SHA, workspace/environment, and redacted plan summary.
4. Identify whether the change was an approved emergency action, an out-of-band change, or a configuration omission.
5. Do not blindly apply. Update Terraform code through a pull request or restore the intended cloud configuration under the change process.
6. Re-run plan and record closure.

## Guardrails
- Never publish raw state or plan output to a public log.
- Do not automatically destroy or overwrite resources to “fix” drift.
- Confirm the correct account/project and backend before any remediation.

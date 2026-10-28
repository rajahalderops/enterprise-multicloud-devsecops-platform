# Runbook: Terraform State Recovery

## Prevention
- Store state in a dedicated remote backend with restricted access.
- Enable state versioning/recovery features supported by the backend.
- Keep backend configuration separate from application resources.
- Test recovery in a non-production environment.

## Recovery outline
1. Stop concurrent pipeline runs for the affected state.
2. Identify the backend, state key, environment, last known-good version, and incident time.
3. Preserve the current state version before making changes.
4. Review backend version history and the cloud resources that currently exist.
5. Restore a known-good state version only after an authorized reviewer approves the recovery plan.
6. Run `terraform plan` and carefully inspect imports, replacements, and destroys before any apply.
7. Document the cause, actions, and preventive controls.

**Do not delete the backend storage/container or run `terraform state push` casually.** State restoration can cause Terraform to lose track of live resources or propose destructive changes.

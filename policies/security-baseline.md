# Infrastructure Security Baseline

This baseline is a review checklist, not a substitute for the organization's regulatory controls.

## Identity
- Prefer workload identity federation/OIDC over static service-principal secrets or service-account keys.
- Separate plan and apply identities where practical.
- Grant only required resource-level permissions; avoid Owner/Editor for routine pipeline identities.
- Keep emergency access monitored and time-bound.

## Network
- Do not allow SSH/RDP from `0.0.0.0/0`.
- Use private endpoints/private service access for services that support them and align with architecture.
- Document all ingress rules with owner, source range, port, and expiry/review date.
- Enable network flow logging where supported.

## Data and state
- Encrypt data at rest and in transit.
- Block anonymous/public blob access unless a documented exception is approved.
- Treat Terraform state and saved plan files as sensitive.
- Restrict state access, enable recovery/versioning features, and never commit state or plan artifacts.

## Delivery
- Run `fmt`, `validate`, lint, and IaC security scans on pull requests.
- Require peer review and protected-branch checks.
- Use a protected deployment environment for production apply.
- Record plan/apply identity, commit SHA, approver, and deployment outcome.

## Operations
- Enable and retain cloud audit logs centrally.
- Alert on policy violations, privileged role assignments, public exposure, and suspicious authentication.
- Schedule drift checks and assign every alert to a service owner.

# Security policy

## Trust model

Repository code and pull requests are untrusted. CI therefore has read-only repository
permissions, receives no cloud credentials, performs no account-level plan, and cannot
deploy resources.

Tool containers receive the repository as read-only. The Terraform initialization step
is the only exception because it must create the ignored `.terraform/` directory.

## Secret handling

Do not commit:

- AWS access keys, session tokens, passwords, or private keys
- Account IDs, personal usernames, or environment-specific role ARNs
- `terraform.tfvars`, plan files, or local/remote state
- Provider debug logs, which can contain request data

Use short-lived federation or workload identity in a real environment. Treat Terraform
state and saved plans as sensitive artifacts even if inputs appear harmless.

## Automated controls

- Gitleaks scans complete Git history.
- Trivy blocks HIGH and CRITICAL Terraform misconfigurations.
- TFLint enforces recommended language rules.
- Native tests verify the safe default and the explicit NAT opt-in path.
- CI never executes `terraform apply`.

## Reporting

Before publication, use the hosting platform's private vulnerability reporting feature.
Do not include secrets or exploit data in a public issue.

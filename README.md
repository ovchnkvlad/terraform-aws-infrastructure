# Terraform AWS Infrastructure

A security-oriented, cost-aware AWS network foundation built as a learning portfolio
project. The configuration is designed to be validated locally without AWS credentials.

> Status: repository scaffold. Infrastructure modules and automated validation are added
> in the following commits.

## Safety principles

- No access keys, passwords, account IDs, or personal usernames
- No remote state backend until a real environment is intentionally bootstrapped
- No automatic `terraform apply` in CI
- Paid network components disabled by default
- Local state and variable files excluded from Git

## Planned architecture

- One VPC across two availability zones
- Public and private subnet tiers
- Optional NAT gateway with an explicit cost warning
- VPC flow logs and restrictive default security-group rules
- Gateway endpoints for private access to supported AWS services
- Formatting, validation, linting, security scanning, and documentation

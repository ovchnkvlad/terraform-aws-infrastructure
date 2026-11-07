# Operating guide

## Credential-free workflow

Use this workflow for development and pull-request review:

```bash
make fmt
make check
```

It downloads pinned tool images and the provider recorded in `.terraform.lock.hcl`.
Neither command contacts AWS or creates infrastructure.

## Before any real deployment

1. Choose a dedicated non-production AWS account and confirm current service pricing.
2. Bootstrap an encrypted, versioned remote-state backend outside this configuration.
3. Use a short-lived federated session; do not create a long-lived access key for CI.
4. Copy `terraform.tfvars.example` to the ignored `terraform.tfvars` and review every
   value, especially NAT and flow-log settings.
5. Create and review a saved Terraform plan before applying it.
6. Require a protected environment and human approval for any future apply workflow.

This repository intentionally provides no automated apply command. That boundary keeps
the learning project safe until the target account, state backend, identity, and budget
controls are known.

## Change procedure

1. Update the module and its input validation.
2. Extend `tests/network.tftest.hcl` for the new behavior.
3. Run `make check`.
4. Review the diff for unexpected resource replacement and sensitive values.
5. Commit one coherent change with its documentation.

## Recovery principles

- Never delete a state object to fix drift without first understanding the live resource.
- Prefer importing existing resources over recreating them.
- Keep state backend versioning and access logging enabled.
- Test restore procedures in a disposable environment.
- Use `terraform state` commands only with a backup and peer review.

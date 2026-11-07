# Validation record

Validation date: 2026-11-07

The suite was run locally with containerized tools and no AWS credentials.

| Check | Result |
| --- | --- |
| Terraform 1.17.1 formatting | Passed |
| `terraform validate` | Passed |
| Native Terraform tests | Passed: 2 runs, 0 failed |
| TFLint 0.64.0 | Passed: 0 issues |
| Trivy 0.76.2 IaC scan | Passed: 0 HIGH/CRITICAL findings |
| Provider lock | AWS provider 6.72.0 recorded |

The native tests use a mock AWS provider. They prove that the default design produces two
public and two private subnet tiers with NAT disabled, and that an explicit three-zone
NAT design is accepted. They do not create, query, or modify AWS resources.

Reproduce all local checks with:

```bash
make check
```

Security databases and lint rules evolve, so this record is evidence for the dated run,
not a permanent guarantee.

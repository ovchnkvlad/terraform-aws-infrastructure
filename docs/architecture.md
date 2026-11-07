# Architecture

## Design goals

The module creates a small network foundation that demonstrates isolation, auditability,
and explicit cost decisions. It does not create application workloads or grant inbound
access.

## Address layout

The VPC CIDR is divided into sixteen equal subnet ranges with `cidrsubnet`. Public
subnets use indexes starting at `0`; private subnets use indexes starting at `8`. The
separation leaves address space for future database, inspection, or transit tiers without
renumbering the existing network.

Every requested availability zone receives one public and one private subnet. Resource
maps use the zone name as their stable key, so adding a zone does not renumber existing
instances in Terraform state.

## Routing

- Public subnets share a route table with a default route to an internet gateway.
- Automatic public IPv4 assignment is disabled, including in the public tier.
- Private subnets each have a dedicated route table.
- Private default internet routes exist only when `enable_nat_gateway` is true.
- S3 and DynamoDB gateway endpoints are associated with every private route table.

The optional design uses one NAT gateway to make the cost visible and predictable for a
learning environment. A production design would normally evaluate one gateway per zone
for failure isolation and cross-zone data-transfer behavior.

## Security controls

- The VPC default security group is managed with no ingress or egress rules.
- VPC DNS support and hostnames are enabled for private service discovery.
- Flow logs capture accepted and rejected traffic with a 60-second aggregation interval.
- The flow-log role can write only to the project log group.
- The log group has finite retention rather than indefinite storage.
- There are no application security groups because the module does not invent workload
  access requirements.

## State boundaries

The repository uses local state only for learning and deliberately creates no state file.
A real environment should bootstrap an encrypted, versioned remote backend separately,
then add a backend configuration containing only non-secret resource identifiers. State
must be treated as sensitive even when configuration inputs are not.

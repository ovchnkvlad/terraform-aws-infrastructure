output "vpc_id" {
  description = "ID of the VPC."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by availability zone."
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by availability zone."
  value       = module.network.private_subnet_ids
}

output "nat_gateway_enabled" {
  description = "Whether the billable NAT gateway is enabled."
  value       = var.enable_nat_gateway
}

output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by availability zone."
  value       = { for zone, subnet in aws_subnet.public : zone => subnet.id }
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by availability zone."
  value       = { for zone, subnet in aws_subnet.private : zone => subnet.id }
}

output "private_route_table_ids" {
  description = "Private route-table IDs keyed by availability zone."
  value       = { for zone, route_table in aws_route_table.private : zone => route_table.id }
}

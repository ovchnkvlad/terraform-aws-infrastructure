variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR assigned to the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability zones used for matching public and private subnets."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two availability zones are required."
  }
}

variable "enable_nat_gateway" {
  description = "Create one NAT gateway for private-subnet internet egress."
  type        = bool
}

variable "enable_flow_logs" {
  description = "Create VPC flow logs and their supporting resources."
  type        = bool
}

variable "flow_log_retention_days" {
  description = "CloudWatch retention period for VPC flow logs."
  type        = number
}

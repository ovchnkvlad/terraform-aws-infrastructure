variable "project_name" {
  description = "Short name used in resource names and tags."
  type        = string
  default     = "platform-lab"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,20}$", var.project_name))
    error_message = "project_name must contain 3-21 lowercase letters, numbers, or hyphens and start with a letter."
  }
}

variable "environment" {
  description = "Environment identifier used in names and tags."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging, or prod."
  }
}

variable "aws_region" {
  description = "AWS region for the network."
  type        = string
  default     = "eu-central-1"

  validation {
    condition     = can(regex("^[a-z]{2}(-[a-z]+)+-[0-9]+$", var.aws_region))
    error_message = "aws_region must be a valid region name such as eu-central-1."
  }
}

variable "availability_zones" {
  description = "Two or more zones. When empty, zones a and b in aws_region are used."
  type        = list(string)
  default     = []

  validation {
    condition = (
      length(var.availability_zones) == 0 ||
      (length(var.availability_zones) >= 2 && length(distinct(var.availability_zones)) == length(var.availability_zones))
    )
    error_message = "availability_zones must be empty or contain at least two unique zones."
  }
}

variable "vpc_cidr" {
  description = "Private IPv4 CIDR for the VPC. /16 through /20 leaves room for subnet tiers."
  type        = string
  default     = "10.40.0.0/16"

  validation {
    condition = (
      can(cidrnetmask(var.vpc_cidr)) &&
      tonumber(split("/", var.vpc_cidr)[1]) >= 16 &&
      tonumber(split("/", var.vpc_cidr)[1]) <= 20
    )
    error_message = "vpc_cidr must be a valid IPv4 CIDR with a /16 through /20 prefix."
  }
}

variable "enable_nat_gateway" {
  description = "Create one billable NAT gateway for private-subnet internet egress."
  type        = bool
  default     = false
}

variable "enable_flow_logs" {
  description = "Send accepted and rejected VPC traffic metadata to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "flow_log_retention_days" {
  description = "CloudWatch retention period for VPC flow logs."
  type        = number
  default     = 30

  validation {
    condition     = contains([14, 30, 60, 90, 120, 180, 365], var.flow_log_retention_days)
    error_message = "flow_log_retention_days must be one of the supported retention periods."
  }
}

variable "tags" {
  description = "Additional non-sensitive tags applied by the AWS provider."
  type        = map(string)
  default     = {}
}

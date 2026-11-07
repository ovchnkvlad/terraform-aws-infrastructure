locals {
  name_prefix = "${var.project_name}-${var.environment}"
  availability_zones = length(var.availability_zones) > 0 ? var.availability_zones : [
    "${var.aws_region}a",
    "${var.aws_region}b",
  ]
}

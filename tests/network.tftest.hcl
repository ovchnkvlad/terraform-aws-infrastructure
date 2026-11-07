mock_provider "aws" {
  mock_data "aws_iam_policy_document" {
    defaults = {
      json = "{\"Version\":\"2012-10-17\",\"Statement\":[]}"
    }
  }
}

run "cost_safe_defaults" {
  command = plan

  assert {
    condition     = output.nat_gateway_enabled == false
    error_message = "The billable NAT gateway must remain opt-in."
  }

  assert {
    condition     = length(output.public_subnet_ids) == 2
    error_message = "The default network must have two public subnets."
  }

  assert {
    condition     = length(output.private_subnet_ids) == 2
    error_message = "The default network must have two private subnets."
  }
}

run "explicit_three_zone_nat_design" {
  command = plan

  variables {
    availability_zones = [
      "eu-central-1a",
      "eu-central-1b",
      "eu-central-1c",
    ]
    enable_nat_gateway = true
  }

  assert {
    condition     = output.nat_gateway_enabled == true
    error_message = "The explicit NAT gateway setting must reach the module."
  }

  assert {
    condition     = length(output.private_subnet_ids) == 3
    error_message = "Every requested zone must receive a private subnet."
  }
}

# AWS Identity and Access Management (IAM)

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/200x100/https://www.opstree.com/images/og_image8.jpg
  - This terraform module will create a complete AWS Identity and Access Management(IAM).
  - This project is a part of opstree's ot-aws initiative for terraform modules.


## Usage

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.44.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

## Local tags are used to define common tags. 
locals {
  tags = { "Environment" : "test", "Client" : "DevOps", "Project" : "Demo", "Organisation" : "opstree" }
}

#Create simple Redis cluster with one node in disabled mode.
module "iam" {
  source             = "./"
  name               = var.role_name
  tags               = var.role_tags
  iam_policy_arn     = var.iam_policy_arn
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS":"arn:aws:iam::103299751604:user/agent"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
        }
    ]
}
EOF
}


```

## Inputs

| Name | Description | Type | Default | Required | Supported |
|------|-------------|:----:|---------|:--------:|:---------:|
| name | AWS IAM Role name. | `string` | | yes | |
| assume_role_policy | Assume Role Policy for role. | `any` | | yes | |
| custome_policy | Custome Policy for role. | `any` | | yes | |
| tags | Additional tags for AWS IAM Role. | `map(string)` | | yes | |
| iam_policy_arn | IAM Policy to be attached to role. | `list(string)` | | yes | |

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
module "iam-role" {
  source                 = "./terraform-aws-iam"
  name                   = "opstree_test"
  inline_policy_required = true
  inline_policy_name     = "opstree-inline-policy"
  iam_policy_arn         = [module.iam-role.custom_policy_arn]
  max_session_duration   = 3600
  force_detach_policies  = false
  inline_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:ListBucket",
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action   = ["s3:GetObject", "s3:PutObject"],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::my-s3-bucket/*"
      }
    ]
  })
  assume_role_policy   = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
    }
    EOF
  create_custom_policy = true
  custom_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:ListBucket",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::my-s3-bucket/*"
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
| custome_policy | Custom Policy for role. | `any` | | yes | |
| tags | Additional tags for AWS IAM Role. | `map(string)` | | yes | |
| iam_policy_arn | IAM Policy to be attached to role. | `list(string)` | | yes | |

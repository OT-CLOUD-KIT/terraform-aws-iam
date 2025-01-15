data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "standard_tags" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-standard-tagging.git?ref=dev"
  env     = var.env
  app     = var.app
  bu      = var.bu
  program = var.program
  team    = "devops"
  region  = var.region
}

module "buildpiper_role" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-iam-role.git?ref=dev"

  roles         = [{
    name                  = "buildpiper"
    path                  = "/"
    desc                  = "IAM Role for buildpiper to Assume other roles"
    trust_policy = {
      policy_template_file  = "ec2-trust.tpl"
      policy_template_vars  = {}
    }
  }]
  policies = []

  use_root_path_template = var.use_root_path_template
  # Create tags for Role and Policies
  env        = var.env
  app        = var.app
  bu         = var.bu
  roles_tags = module.standard_tags.standard_tags
  policies_tags = module.standard_tags.standard_tags
}

resource "aws_iam_instance_profile" "This" {
  name       = "buildpiper_instance_profile"
  role       = module.buildpiper_role.role["name"][0]
  depends_on = [ module.buildpiper_role ]
}

module "name_iam_role_policy" {
  source   = "git@github.com:OT-CLOUD-KIT/terraform-aws-naming.git?ref=dev"

  bu       = var.bu
  env      = var.env
  app      = var.app
  tenant   = var.tenant
  resource = "bp-assume-policy"
}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "AllowBuildPiperToAssumeRoles"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    resources = concat(
      [ for iam in module.common_buildpiper_role.role["arn"] : iam ],
      var.create_rds_role == true ? [ for iam in module.rds_buildpiper_role[0].role["arn"] : iam ] : []
    )
  }
}

resource "aws_iam_role_policy" "inline_policy_attachments" {
  name   = module.name_iam_role_policy.naming_tag[0]
  role   = module.buildpiper_role.role["name"][0]
  policy = data.aws_iam_policy_document.this.json
}

module "common_buildpiper_role" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-iam-role.git?ref=dev"

  env = var.env
  app = var.app
  bu  = var.bu

  use_root_path_template  = var.use_root_path_template
  policies_tags           = module.standard_tags.standard_tags
  roles_tags              = module.standard_tags.standard_tags

  roles         = [{
    name                  = "bp-network-skeleton"
    path                  = "/"
    desc                  = "IAM Role for BuildPiper to create basic resources"
    policies              = ["bp-network-skeleton"]
    trust_policy = {
      policy_template_file  = "assume-role-trust.tpl"
      policy_template_vars  = {
        account_id       = data.aws_caller_identity.current.account_id
        assume_role_name = module.buildpiper_role.role["name"][0]
      }
    }
  }]

  policies = [
    {
      name = "bp-network-skeleton"
      path = "/"
      desc = "IAM Policy for BuildPiper to create Network Skeleton resources"
      policy_template_file = "network-policy.tpl"
      policy_template_vars = {
        "account_id" = data.aws_caller_identity.current.account_id
        "region"     = data.aws_region.current.name
      }
    }
  ]
}

module "rds_buildpiper_role" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-iam-role.git?ref=dev"

  count = var.create_rds_role == true ? 1 : 0

  env = var.env
  app = var.app
  bu  = var.bu

  use_root_path_template  = var.use_root_path_template
  policies_tags           = module.standard_tags.standard_tags
  roles_tags              = module.standard_tags.standard_tags

  roles         = [{
    name                  = "bp-rds"
    path                  = "/"
    desc                  = "IAM Role for buildpiper to create RDS Resources"
    policies              = ["bp-rds"]
    trust_policy = {
      policy_template_file  = "assume-role-trust.tpl"
      policy_template_vars  = {
        account_id       = data.aws_caller_identity.current.account_id
        assume_role_name = module.buildpiper_role.role["name"][0]
      }
    }
  }]

  policies = [
    {
      name = "bp-rds"
      path = "/"
      desc = "IAM Policy for buildpiper to create RDS Resources"
      policy_template_file = "rds-policy.tpl"
      policy_template_vars = {}
    }
  ]
}

module "msk_buildpiper_role" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-iam-role.git?ref=dev"

  count = var.create_msk_role == true ? 1 : 0

  env = var.env
  app = var.app
  bu  = var.bu

  use_root_path_template  = var.use_root_path_template
  policies_tags           = module.standard_tags.standard_tags
  roles_tags              = module.standard_tags.standard_tags

  roles         = [{
    name                  = "bp-msk"
    path                  = "/"
    desc                  = "IAM Role for buildpiper to create MSK Resources"
    policies              = ["bp-msk"]
    trust_policy = {
      policy_template_file  = "assume-role-trust.tpl"
      policy_template_vars  = {
        account_id       = data.aws_caller_identity.current.account_id
        assume_role_name = module.buildpiper_role.role["name"][0]
      }
    }
  }]

  policies = [
    {
      name = "bp-msk"
      path = "/"
      desc = "IAM Policy for buildpiper to create MSK Resources"
      policy_template_file = "msk-policy.tpl"
      policy_template_vars = {}
    }
  ]
}

module "docdb_buildpiper_role" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-iam-role.git?ref=dev"

  count = var.create_rds_role == true ? 1 : 0

  env = var.env
  app = var.app
  bu  = var.bu

  use_root_path_template  = var.use_root_path_template
  policies_tags           = module.standard_tags.standard_tags
  roles_tags              = module.standard_tags.standard_tags

  roles         = [{
    name                  = "bp-docdb"
    path                  = "/"
    desc                  = "IAM Role for buildpiper to create DocumentDB Resources"
    policies              = ["bp-docdb"]
    trust_policy = {
      policy_template_file  = "assume-role-trust.tpl"
      policy_template_vars  = {
        account_id       = data.aws_caller_identity.current.account_id
        assume_role_name = module.buildpiper_role.role["name"][0]
      }
    }
  }]

  policies = [
    {
      name = "bp-docdb"
      path = "/"
      desc = "IAM Policy for buildpiper to create DocumentDB Resources"
      policy_template_file = "documentdb-policy.tpl"
      policy_template_vars = {}
    }
  ]
}

module "iam_buildpiper_role" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-iam-role.git?ref=dev"

  count = var.create_rds_role == true ? 1 : 0

  env = var.env
  app = var.app
  bu  = var.bu

  use_root_path_template  = var.use_root_path_template
  policies_tags           = module.standard_tags.standard_tags
  roles_tags              = module.standard_tags.standard_tags

  roles         = [{
    name                  = "bp-iam"
    path                  = "/"
    desc                  = "IAM Role for buildpiper to create IAM Resources"
    policies              = ["bp-iam"]
    trust_policy = {
      policy_template_file  = "assume-role-trust.tpl"
      policy_template_vars  = {
        account_id       = data.aws_caller_identity.current.account_id
        assume_role_name = module.buildpiper_role.role["name"][0]
      }
    }
  }]

  policies = [
    {
      name = "bp-iam"
      path = "/"
      desc = "IAM Policy for buildpiper to create IAM Resources"
      policy_template_file = "iam-policy.tpl"
      policy_template_vars = {}
    }
  ]
}

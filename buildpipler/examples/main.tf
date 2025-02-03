module "buildpiper_role" {
  source = "../"

  env     = var.env
  app     = var.app
  bu      = var.bu
  program = var.program
  region  = var.region

  create_rds_role = var.create_rds_role
  create_s3_role = var.create_s3_role
  create_dynamodb_role = var.create_dynamodb_role
}
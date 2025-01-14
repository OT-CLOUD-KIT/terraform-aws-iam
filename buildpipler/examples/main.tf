module "buildpiper_role" {
  source = "../"

  env     = var.env
  app     = var.app
  bu      = var.bu
  program = var.program
  region  = var.region

  create_rds_role = var.create_rds_role
}
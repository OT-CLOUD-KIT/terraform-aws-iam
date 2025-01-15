output "iam_role" {
  description = "value"
  value = module.iam_buildpiper_role.role
}

output "documentdb_role" {
  description = "value"
  value = module.docdb_buildpiper_role.role
}

output "msk_role" {
  description = "value"
  value = module.msk_buildpiper_role.role
}

output "rds_role" {
  description = "value"
  value = module.msk_buildpiper_role.role
}

output "common_role" {
  description = "value"
  value = module.common_buildpiper_role.role
}

output "buildpiper_instance_role" {
  description = "value"
  value = module.buildpiper_role.role
}

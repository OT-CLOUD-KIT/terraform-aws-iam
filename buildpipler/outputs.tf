output "iam_role" {
  description = "value"
  value = try(module.iam_buildpiper_role.role, null)
}

output "documentdb_role" {
  description = "value"
  value = try(module.docdb_buildpiper_role.role, null)
}

output "msk_role" {
  description = "value"
  value = try(module.msk_buildpiper_role.role, null)
}

output "rds_role" {
  description = "value"
  value = try(module.msk_buildpiper_role.role, null)
}

output "common_role" {
  description = "value"
  value = try(module.common_buildpiper_role.role, null)
}

output "buildpiper_instance_role" {
  description = "value"
  value = try(module.buildpiper_role.role, null)
}

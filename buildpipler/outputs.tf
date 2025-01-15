output "iam_role" {
  description = "IAM Role for IAM role and policy creation"
  value = try(module.iam_buildpiper_role.role, null)
}

output "documentdb_role" {
  description = "IAM Role for documentDB creation"
  value = try(module.docdb_buildpiper_role.role, null)
}

output "msk_role" {
  description = "value"
  value = try(module.msk_buildpiper_role.role, null)
}

output "rds_role" {
  description = "IAM Role for RDS creation"
  value = try(module.msk_buildpiper_role.role, null)
}

output "common_role" {
  description = "IAM Role for MSK Cluster creation"
  value = try(module.common_buildpiper_role.role, null)
}

output "buildpiper_instance_role" {
  description = "IAM Role for BuildPiper Instance with instance profile"
  value = try(module.buildpiper_role.role, null)
}

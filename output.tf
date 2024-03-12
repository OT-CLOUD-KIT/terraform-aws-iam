output "role_id" {
  value = aws_iam_role.main.id
}

output "role_arn" {
  value = aws_iam_role.main.arn
}

output "custom_policy_arn" {
  value = var.create_custom_policy ? aws_iam_policy.custom[0].arn : null
}

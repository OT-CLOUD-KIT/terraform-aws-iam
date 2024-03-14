resource "aws_iam_role" "main" {
  name                  = var.name
  tags                  = var.tags
  assume_role_policy    = var.assume_role_policy
  force_detach_policies = var.force_detach_policies
  managed_policy_arns   = var.managed_policy_arns
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary

}

# resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
#   role       = aws_iam_role.main.name
#   count      = length(var.iam_policy_arn)
#   policy_arn = var.iam_policy_arn[count.index]
# }

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  for_each   = { for idx, arn in var.iam_policy_arn : idx => arn }
  role       = aws_iam_role.main.name
  policy_arn = each.value
}


resource "aws_iam_policy" "custom" {
  count  = var.create_custom_policy ? 1 : 0
  name   = "${var.name}-policy"
  policy = var.custom_policy
  path   = var.iam_policy_path
  
}

resource "aws_iam_role_policy_attachment" "custom-policy-attachment" {
  count      = var.custom_policy == null ? 0 : 1
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.custom[count.index].arn
}


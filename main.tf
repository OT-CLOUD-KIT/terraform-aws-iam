resource "aws_iam_role" "main" {
  name               = var.name
  tags               = var.tags
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role       = aws_iam_role.main.name
  count      = length(var.iam_policy_arn)
  policy_arn = var.iam_policy_arn[count.index]
}

resource "aws_iam_policy" "custome" {
  count = var.custome_policy == null ? 0 : 1
  name = "${var.name}-policy"
  policy = var.custome_policy
}

resource "aws_iam_role_policy_attachment" "custome-policy-attachment" {
  count = var.custome_policy == null ? 0 : 1
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.custome[count.index].arn
}


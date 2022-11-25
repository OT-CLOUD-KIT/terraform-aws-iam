variable "name" {
  type        = string
  description = "AWS IAM Role name"
}

variable "assume_role_policy" {
  type        = any
  description = "assume_role_policy for role"
}

variable "custome_policy" {
  type        = any
  description = "custome_policy for role"
  default = null
}

variable "tags" {
  description = "Additional tags for AWS IAM Role"
  type        = map(string)
  default     = {}
}

variable "iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type        = list(string)
}


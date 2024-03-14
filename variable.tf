variable "name" {
  type        = string
  description = "AWS IAM Role name"
}

variable "assume_role_policy" {
  type        = any
  description = "assume_role_policy for role"
}

variable "custom_policy" {
  type        = any
  description = "custome_policy for role"
  default     = null
}
variable "create_custom_policy" {
  description = "Create a custom IAM policy"
  type        = bool
  default     = false
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
variable "force_detach_policies" {
  type        = bool
  description = "force_detach_policies is set to true, which means that when you destroy this IAM role, any attached managed policies will be forcefully detached before the role is deleted."
  default     = false

}

# variable "name_prefix" {
#   description = "Prefix for the IAM role name"
#   type        = string
# }

variable "path" {
  description = "Path for the IAM role"
  type        = string
  default     = "/"
}
variable "iam_policy_path" {
  description = "Path for the IAM policy"
  type        = string
  default     = "/"
}

variable "managed_policy_arns" {
  description = "List of ARNs of managed policies to attach to the IAM role"
  type        = list(string)
  default     = []
}

# The session duration can be specified when the role is created. The default duration is one hour,
#  and it can be set to a maximum of 12 hours. We can also change the session duration later by editing the role.

variable "max_session_duration" {
  description = "The maximum session duration for the IAM role"
  type        = number
  default     = 3600
}

variable "permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = ""
}

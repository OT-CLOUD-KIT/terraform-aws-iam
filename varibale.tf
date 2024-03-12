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

variable "inline_policy_name" {
  description = "Name for the inline policy"
  type        = string
}

variable "inline_policy" {
  description = "Inline policy document"
  type        = string
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

variable "inline_policy_required" {
  description = "Flag to indicate if inline policy is required"
  type        = bool
  default     = false
}

################################################################################################################

# Example:
# module "example" {
#   source = "./path/to/your/module_directory"

#   region                = "us-east-1"
#   role_name             = "example-role"
#   force_detach_policies = true

#   inline_policy_required = true
#   inline_policy_name     = "example-inline-policy"
#   inline_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action   = "s3:ListBucket",
#         Effect   = "Allow",
#         Resource = "*"
#       },
#       {
#         Action   = ["s3:GetObject", "s3:PutObject"],
#         Effect   = "Allow",
#         Resource = "arn:aws:s3:::example-bucket/*"
#       }
#     ]
#   })
#}

####################################################### FOR custom policy = True || example #####################

# module "example_iam_role_with_policy" {
#   source = "./path/to/your/module_directory"

#   region                   = "us-east-1"
#   role_name                = "example-role"
#   assume_role_policy       = "your-assume-role-policy"
#   force_detach_policies    = true
#   inline_policy_required   = false
#   create_custom_policy     = true
#   custom_policy            = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "s3:ListBucket",
#       "Effect": "Allow",
#       "Resource": "*"
#     },
#     {
#       "Action": ["s3:GetObject", "s3:PutObject"],
#       "Effect": "Allow",
#       "Resource": "arn:aws:s3:::example-bucket/*"
#     }
#   ]
# }
# EOF
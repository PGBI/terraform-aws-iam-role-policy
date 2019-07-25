variable "name" {
  description = "Name of the policy"
  type        = string
}

variable "role_name" {
  description = "Name of the role to attach the policy to."
  type        = string
}

variable "statements" {
  description = "List of IAM statements composing the policy."
  type        = list(object({ actions = list(string), resources = list(string) }))
}


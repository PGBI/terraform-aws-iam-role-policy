# IAM Role Policy module

This module is a simple wrapper around the AWS resource `aws_iam_role_policy` allowing to create an IAM Role policy
without the need to write the policy in JSON format or to use the `aws_iam_policy_document` datasource.

Usage:

```hcl
module "iam_role_policy" {
  source  = "PGBI/iam-role-policy/aws"
  version = "~>0.1.0"

  name      = "policyName"
  role_name = "someExistingRole"

  statements = [
    {
      actions   = ["ec2:Describe*"]
      effect    = "Allow"
      resources = ["*"]
    }, {
      actions   = ["s3:*"]
      effect    = "Allow"
      resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
    }
  ]
}
```

The above example is equivalent to:

```hcl
data "aws_iam_policy_document" "main" {
  statement {
    actions   = ["ec2:Describe*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["s3:*"]
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
  }
}

resource "aws_iam_role_policy" "main" {
  name   = "policyName"
  policy = data.aws_iam_policy_document.main.json
  role   = "someExistingRole"
}
```

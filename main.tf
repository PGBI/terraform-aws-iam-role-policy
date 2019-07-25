data "aws_iam_policy_document" "main" {
  dynamic "statement" {
    for_each = var.statements
    content {
      resources = statement.value.resources
      actions   = statement.value.actions
    }
  }
}

resource "aws_iam_role_policy" "main" {
  name   = var.name
  policy = data.aws_iam_policy_document.main.json
  role   = var.role_name
}

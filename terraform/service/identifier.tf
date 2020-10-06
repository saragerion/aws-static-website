resource "random_string" "stack_identifier" {
  length  = 16
  special = false
  upper   = false

  keepers = {
      env = var.env
      aws_account_id = local.aws_account_id
      aws_region = var.aws_region
  }
}

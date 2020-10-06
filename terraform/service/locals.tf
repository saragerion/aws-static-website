locals {
  service_name               = element(split("/", var.github_repo), 1)
  verbose_service_name       = "${local.service_name}-${var.env}-${var.aws_region}"
  stack_id                   = random_string.stack_identifier.result
  aws_account_id             = data.aws_caller_identity.current.account_id
  cloudfront_distribution_id = aws_cloudfront_distribution.bucket_distribution.id

  tags = {
    Service      = local.service_name
    Environment  = var.env
    ManagedBy    = "Terraform"
    GithubRepo   = var.github_repo
    Owner        = var.owner
    AwsRegion    = var.aws_region
    AwsAccountId = local.aws_account_id
  }
}

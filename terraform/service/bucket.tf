resource "aws_s3_bucket" "bucket" {
  bucket = "${local.verbose_service_name}-bucket-${local.stack_id}"
  acl    = "private"

  website {
    index_document = "index.html"
  }

  versioning {
    enabled = true
  }

  tags = local.tags
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}

data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

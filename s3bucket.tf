data "aws_iam_policy_document" "s3_site_policy" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${local.s3_site_bucket_name}"]

    principals {
      type        = "CanonicalUser"
      identifiers = [aws_cloudfront_origin_access_identity.main_origin_access_identity.s3_canonical_user_id]
    }
  }

  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.s3_site_bucket_name}/*"]

    principals {
      type        = "CanonicalUser"
      identifiers = [aws_cloudfront_origin_access_identity.main_origin_access_identity.s3_canonical_user_id]
    }
  }
}

resource "aws_s3_bucket" "site" {
  bucket = local.s3_site_bucket_name
  acl    = "private"

  tags = var.common_tags

  policy = data.aws_iam_policy_document.s3_site_policy.json
}

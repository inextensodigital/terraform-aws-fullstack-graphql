resource "aws_cloudfront_distribution" "main" {
  enabled = true

  tags = "${var.common_tags}"

  comment = "By Terraform"

  default_root_object = "index.html"
  http_version        = "http2"
  is_ipv6_enabled     = "true"
  price_class         = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  # Route53 requires Alias/CNAME to be setup
  aliases = concat(var.domains, var.alternate_domains, [var.rest_domain])

  # graphql origin
  origin {
    domain_name = var.graphql_domain
    origin_id   = local.graphql_origin_id

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "match-viewer"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_read_timeout      = 30
      origin_keepalive_timeout = 5
    }
  }

  origin {
    domain_name = var.rest_domain
    origin_id   = local.rest_origin_id

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "match-viewer"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_read_timeout      = 30
      origin_keepalive_timeout = 5
    }
  }

  # front-end origin
  origin {
    domain_name = aws_s3_bucket.site.bucket_domain_name
    origin_id   = local.site_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main_origin_access_identity.cloudfront_access_identity_path
    }
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  default_cache_behavior {
    field_level_encryption_id = ""
    forwarded_values {
      cookies {
        forward = "all"
      }

      query_string = "true"
    }

    default_ttl      = 86400
    min_ttl          = 0
    max_ttl          = 31536000
    target_origin_id = local.site_origin_id

    trusted_signers = []

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    smooth_streaming = false

    lambda_function_association {
      event_type   = "origin-response"
      lambda_arn   = data.aws_lambda_function.custom_headers.qualified_arn
      include_body = false
    }

    dynamic lambda_function_association {
      for_each = var.redirect_dk ? [true] : []

      content {
        event_type   = "viewer-request"
        lambda_arn   = data.aws_lambda_function.redirectDK.qualified_arn
        include_body = false
      }
    }
  }

  ordered_cache_behavior {
    path_pattern     = "/graphql"
    target_origin_id = local.graphql_origin_id

    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 0
    min_ttl     = 0
    max_ttl     = 0

    compress         = false
    smooth_streaming = false

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }

      headers                 = ["*"]
      query_string_cache_keys = []
    }

    allowed_methods = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods  = ["HEAD", "GET"]



    lambda_function_association {
      event_type   = "origin-request"
      lambda_arn   = data.aws_lambda_function.host.qualified_arn
      include_body = true
    }
  }

  ordered_cache_behavior {
    path_pattern     = "/api/*"
    target_origin_id = local.rest_origin_id

    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 0
    min_ttl     = 0
    max_ttl     = 0

    compress         = false
    smooth_streaming = false

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }

      headers                 = ["*"]
      query_string_cache_keys = []
    }

    allowed_methods = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods  = ["HEAD", "GET"]

  }
}

resource "aws_cloudfront_origin_access_identity" "main_origin_access_identity" {
  comment = "Origin Access Identity for S3"
}

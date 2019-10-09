data "aws_route53_zone" "site" {
  count = length(local.zones)
  name  = "${local.zones[count.index]}."
}

resource "aws_route53_record" "subdomain" {
  count   = length(var.domains)
  zone_id = data.aws_route53_zone.site[count.index].zone_id
  name    = var.domains[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = "Z2FDTNDATAQYW2" # CloudFront ZoneID (https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-aliastarget.html)
    evaluate_target_health = false
  }
}

output "MAIN-cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.main.domain_name
  description = "The cloud front domain name"
}

output "MAIN-cloudfront_id" {
  value       = aws_cloudfront_distribution.main.id
  description = "The cloud front id"
}

output "MAIN-cloudfront_aliases" {
  value       = aws_cloudfront_distribution.main.aliases
  description = "The cloud front aliases"
}

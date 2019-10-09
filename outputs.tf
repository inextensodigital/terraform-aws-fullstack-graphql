output "cloudfront_domain_name.main" {
  value       = aws_cloudfront_distribution.main.domain_name
  description = "The cloud front domain name"
}

output "cloudfront_id.main" {
  value       = aws_cloudfront_distribution.main.id
  description = "The cloud front id"
}

output "cloudfront_aliases.main" {
  value       = aws_cloudfront_distribution.main.aliases
  description = "The cloud front aliases"
}

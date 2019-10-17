output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.main.domain_name
  description = "The cloud front domain name"
}

output "cloudfront_id" {
  value       = aws_cloudfront_distribution.main.id
  description = "The cloud front id"
}

output "cloudfront_aliases" {
  value       = aws_cloudfront_distribution.main.aliases
  description = "The cloud front aliases"
}

output "graphql_lambda_arn" {
  value = module.ied-lambda-graphql.lambda_arn
}

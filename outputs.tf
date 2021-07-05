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

output "lambda_versions" {
  value       = module.ied-lambda-graphql.lambda_versions
  description = "the lambda versions"
}

output "lambda_role_names" {
  value       = module.ied-lambda-graphql.lambda_role_names
  description = "the lambda roles"
}

output "lambda_arns" {
  value       = module.ied-lambda-graphql.lambda_arns
  description = "the lambda arns"
}

output "lambda_function_names" {
  value       = module.ied-lambda-graphql.lambda_function_names
  description = "the lambda function name"
}

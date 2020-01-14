# terraform-aws-fullstack-graphql

terraform module for deploying a graphql full stack on aws (cloudfront, api gateway, route 53, lambda, s3) in a blink

## Usage

```hcl
module "ied-fullstack-graphql" {
  source  = "app.terraform.io/ied/fullstack-graphql/aws"
  version = "~>2.0.1"

	// We actually deploy some resources
	// (like S3 Bucket for static website on us-east-1 for performance issue)
  providers = {
    aws            = "aws"
    aws.n_virginia = "aws.n_virginia"
  }

	// The default region used by aws main provider
	aws_region  = var.aws_region

	// Tags used on every resources that supports tags
  common_tags = local.common_tags

	// The environment (dev/preprod/prod)
  stage       = var.stage

  app_id      = local.app_id
  app_name    = var.app_name

	// The domains that access to CloudFront and managed by terraform with Route53
  domains           = var.domains[var.stage]

	// The domains that access to CloudFront and NOT managed by terraform
  alternate_domains = local.alternate_domains

	// The domains where /api should points to (NOT MANAGED by terraform)
  rest_domain = var.rest_domains[var.stage]

	// The certificate used in cloudfront
  certificate_domain = var.certificate_domain[var.stage]

	// The domains where /graphql should points (managed by terrarform with Route53)
	// The domain will be used to point to API Gateway
  graphql_domain           = var.graphql_domains[var.stage]

	// The domains where /graphql should points (not managed by terrarform with Route53)
	// The domain will be used to point to API Gateway
  alternate_graphql_domain = local.alternate_graphql_domain


	// The S3 Bucket onto which the back-end is uploaded
  backend_s3_bucket       = var.backend_s3_bucket
  backend_s3_key          = var.backend_s3_key

	// The packaged lambda file
  backend_lambda_filename = "../../back-end/lambda.zip"

	// Networking
  security_account_arn = var.account_arn_list["security"]
  default_account_arn  = var.account_arn_list[var.stage]
	vpc = var.vpcs[var.stage]

	// Logs
  lambda_logs_to_kibana_name              = var.logs[var.stage][0]
  logs_to_kibana_subscription_filter_name = var.logs[var.stage][1]

	// GraphQL Lambda Specific Parameters
	// The secret the lambda has access too
  graphql_secret_managers = local.secrets

	// The handler
  graphql_handler = "handler.graphql"

	// The timeout
  graphql_timeout = 30

	// The runtime
	graphql_runtime = "nodejs10.x"

	// The environment variable
  graphql_environment = {
    STAGE = var.stage
    TZ    = "UTC"
  }
}
```

# terraform-aws-fullstack-graphql

terraform module for deploying a graphql full stack on aws (cloudfront, api gateway, route 53, lambda, s3) in a blink

## Usage
```hcl
module "ied-fullstack-graphql" {
  source  = "app.terraform.io/ied/fullstack-graphql/aws"
  version = "~>10.13.0"

  providers = {
    aws            = aws
    aws.n_virginia = aws.n_virginia
  }

  common_tags = local.common_tags
  stage       = var.stage
  app_id      = local.app_id
  app_name    = var.app_name
  aws_region  = var.aws_region

  domains           = var.domains[var.stage]
  alternate_domains = local.alternate_domains

  rest_domain = var.rest_domains[var.stage]

  certificate_domain = var.certificate_domain[var.stage]

  graphql_domain           = var.graphql_domains[var.stage]
  alternate_graphql_domain = local.alternate_graphql_domain

  backend_s3_bucket       = var.backend_s3_bucket
  backend_s3_key          = var.backend_s3_key
  backend_lambda_filename = "../../back-end/lambda.zip"

  security_account_arn = var.account_arn_list["security"]
  default_account_arn  = var.account_arn_list[var.stage]

  lambda_logs_to_kibana_name              = var.logs[var.stage][0]
  logs_to_kibana_subscription_filter_name = var.logs[var.stage][1]

  vpc = var.vpcs[var.stage]

  lambda_runtime = "nodejs12.x"
  lambda_secrets = local.secrets
  lambda_environment = {
    STAGE = var.stage
    TZ    = "utc"
  }
  routes = [{
    "route"                          = "graphql"
    "canonical_name"                 = "graphql"
    "description"                    = "Public GraphQL API Handler"
    "handler"                        = "functions/graphql/index.handler"
    "timeout"                        = 30
    "memory_size"                    = 1024
    "reserved_concurrent_executions" = null
  }]
}
```

terraform {
  required_version = ">=0.13.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      source = "hashicorp/random"
    }
    template = {
      source = "hashicorp/template"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

module "ied-lambda-graphql" {
  source  = "app.terraform.io/ied/lambda-graphql/aws"
  version = "~>10.13.0"

  providers = {
    aws            = aws
    aws.n_virginia = aws.n_virginia
  }

  common_tags = var.common_tags
  stage       = var.stage
  app_id      = var.app_id

  app_name   = var.app_name
  aws_region = var.aws_region

  certificate_domain = var.certificate_domain

  backend_s3_bucket = var.backend_s3_bucket
  backend_s3_key    = var.backend_s3_key

  security_account_arn = var.security_account_arn
  default_account_arn  = var.default_account_arn

  graphql_domain           = var.graphql_domain
  alternate_graphql_domain = var.alternate_graphql_domain

  graphql_binary_media_types = var.graphql_binary_media_types

  backend_lambda_filename = var.backend_lambda_filename

  lambda_logs_to_kibana_name              = var.lambda_logs_to_kibana_name
  logs_to_kibana_subscription_filter_name = var.logs_to_kibana_subscription_filter_name

  vpc = var.vpc

  secret_managers = var.lambda_secrets
  environment     = var.lambda_environment

  routes = var.routes
}

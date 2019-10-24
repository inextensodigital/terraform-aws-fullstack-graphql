# COMPUTED VARIABLES DO NOT CHANGE ANY VALUES FROM HERE
locals {
  # APPLICATION VARIABLES

  ## stage == prod: app_name
  ## else: app_name-{staging}
  camel_app_name = replace(title(replace(var.app_name, "/\\W+/", " ")), " ", "")

  # S3 VARIABLES
  # the bucket where the front-end is deployed
  s3_site_bucket_name = "${var.app_id}-front-end--us-1"

  # CLOUDFRONT VARIABLES
  ## GRAPHQL ORIGIN
  graphql_origin_id = "${var.app_id}-graphql"
  rest_origin_id    = "${var.app_id}-api"

  ## SITE ORIGIN
  site_origin_id = "${var.app_id}-site-us"

  zones = [for domain in var.domains : regex("([^\\.]+)\\.(.+)", domain)[1]]
}

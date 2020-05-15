data "aws_lambda_function" "tf_host" {
  function_name = "Host"
  qualifier     = "TFHost"
  provider      = "aws.n_virginia"
}

data "aws_lambda_function" "host" {
  function_name = "Host"
  qualifier     = data.aws_lambda_function.tf_host.version
  provider      = "aws.n_virginia"
}

data "aws_lambda_function" "tf_custom_headers" {
  function_name = "CustomHeaders"
  qualifier     = "TFCustomHeaders"
  provider      = "aws.n_virginia"
}

data "aws_lambda_function" "custom_headers" {
  function_name = "CustomHeaders"
  qualifier     = data.aws_lambda_function.tf_custom_headers.version
  provider      = "aws.n_virginia"
}

data "aws_lambda_function" "tf_redirectDK" {
  function_name = "redirectDK"
  qualifier     = "TFRedirectDK"
  provider      = "aws.n_virginia"
}

data "aws_lambda_function" "redirectDK" {
  function_name = "redirectDK"
  qualifier     = data.aws_lambda_function.tf_redirectDK.version
  provider      = "aws.n_virginia"
}

locals {
  lambda_layer_secrets_wrapper_arn         = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:layer:secrets_wrapper"
  lambda_layer_version_secrets_wrapper     = "53"
  lambda_layer_version_secrets_wrapper_arn = "${local.lambda_layer_secrets_wrapper_arn}:${local.lambda_layer_version_secrets_wrapper}"
}

data "aws_secretsmanager_secret_version" "terraform_datadog_api_key" {
  provider = aws.meta-primary

  secret_id = data.terraform_remote_state.meta.outputs.secretsmanager_secret_terraform_datadog_api_key_arn
}

data "aws_secretsmanager_secret_version" "terraform_datadog_app_key" {
  provider = aws.meta-primary

  secret_id = data.terraform_remote_state.meta.outputs.secretsmanager_secret_terraform_datadog_app_key_arn
}

provider "datadog" {
  api_key = data.aws_secretsmanager_secret_version.terraform_datadog_api_key.secret_string
  app_key = data.aws_secretsmanager_secret_version.terraform_datadog_app_key.secret_string
}

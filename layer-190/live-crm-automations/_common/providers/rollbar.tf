data "aws_secretsmanager_secret_version" "terraform_rollbar_account_access_token" {
  provider = aws.meta-primary

  secret_id = data.terraform_remote_state.meta.outputs.secretsmanager_secret_terraform_rollbar_account_access_token_arn
}

provider "rollbar" {
  api_key = data.aws_secretsmanager_secret_version.terraform_rollbar_account_access_token.secret_string
}

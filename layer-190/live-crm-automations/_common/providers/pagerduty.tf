data "aws_secretsmanager_secret_version" "terraform_pagerduty_token" {
  provider = aws.meta-primary

  secret_id = data.terraform_remote_state.meta.outputs.secretsmanager_secret_terraform_pagerduty_token_arn
}

provider "pagerduty" {
  token = data.aws_secretsmanager_secret_version.terraform_pagerduty_token.secret_string
}

data "pagerduty_vendor" "cloudwatch" {
  name = "Amazon Cloudwatch"
}

data "pagerduty_vendor" "rollbar" {
  name = "Rollbar"
}

data "pagerduty_extension_schema" "slack-v2" {
  name = "Slack V2"
}

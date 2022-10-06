data "aws_secretsmanager_secret_version" "live_groups_slack" {
  secret_id = data.terraform_remote_state.babbel["credentials"].outputs.secretsmanager-secret-live_groups-slack-arn
}

locals {
  slack_secrets = jsondecode(data.aws_secretsmanager_secret_version.live_groups_slack.secret_string)
}

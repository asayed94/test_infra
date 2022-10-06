data "aws_secretsmanager_secret_version" "live_groups_google" {
  secret_id = data.terraform_remote_state.babbel["credentials"].outputs.secretsmanager-secret-live_groups-google-arn
}

locals {
  google_secrets = jsondecode(data.aws_secretsmanager_secret_version.live_groups_google.secret_string)
}

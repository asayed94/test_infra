locals {
  google_organization_domain  = "babbel.com"
  google_billing_account_name = "Infrastructure Team"
}

data "aws_secretsmanager_secret_version" "terraform_google_credentials" {
  provider = aws.meta-primary

  secret_id = data.terraform_remote_state.meta.outputs.secretsmanager_secret_terraform_google_credentials_arn
}

provider "google" {
  credentials = data.aws_secretsmanager_secret_version.terraform_google_credentials.secret_string
}

data "google_organization" "current" {
  domain = local.google_organization_domain
}

data "google_billing_account" "current" {
  display_name = local.google_billing_account_name
}

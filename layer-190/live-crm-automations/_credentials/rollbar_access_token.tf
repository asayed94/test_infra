module "secretsmanager-for-rollbar-access-tokens-live-groups" {
  source  = "babbel/secretsmanager-for-rollbar-access-tokens/aws"
  version = "1.1.0"

  name_prefix = "live-groups-${var.environment}"

  rollbar_project_name       = local.rollbar_project_name
  rollbar_access_token_names = ["post_server_item"]

  tags = local.tags
}

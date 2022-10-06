module "kinesis-producer-live-groups" {
  source = "../../../_modules/kinesis/producer"

  name = "${var.service}-${var.environment}"

  retention_period = 168

  target_kinesis_stream = data.terraform_remote_state.babbel["enrich"].outputs.kinesis-stream-mainstream

  rollbar = {
    access_token = "${module.secretsmanager-for-rollbar-access-tokens-live-groups.secretsmanager_secret.arn}:post_server_item::"
    environment  = var.environment
  }

  sns_topic_arns = {
    high-urgency = module.pagerduty-live-groups.sns_topics.high_urgency.regional.arn
    low-urgency  = module.pagerduty-live-groups.sns_topics.low_urgency.regional.arn
  }

  lambda_layer_version_secrets_wrapper_arn = local.lambda_layer_version_secrets_wrapper_arn

  tags = local.tags
}

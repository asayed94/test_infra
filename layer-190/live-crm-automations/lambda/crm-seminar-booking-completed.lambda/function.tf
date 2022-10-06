locals {
  consuming_from = data.terraform_remote_state.babbel["passage"].outputs.passage-poddle.arn

  events = [
    "live_groups:seminar:booking:completed",
  ]
}

module "lambda-live-crm-automations" {
  source = "https://babbel.s3.amazonaws.com/lessonnine/shared.terraform/df93180a476be6d0e3996a646a18038da760dbd3/lambda/outsourced/without-vpc.zip"

  name        = "live-crm-automations-${var.environment}"
  description = "Receives events from Kinesis and send events to Emarsys API"

  runtime = "nodejs16.x"
  handler = "index.handler"

  memory_size                    = 256
  timeout                        = 10
  reserved_concurrent_executions = null

  environment_variables = {
    ENVIRONMENT = var.environment
  }

  secret_environment_variables = {
    EMARSYS_USERNAME     = "${data.terraform_remote_state.babbel["credentials"].outputs.secretsmanager_secret_live_crm_automations_emarsys.arn}:username::"
    EMARSYS_SECRET       = "${data.terraform_remote_state.babbel["credentials"].outputs.secretsmanager_secret_live_crm_automations_emarsys.arn}:secret::"
    ROLLBAR_ACCESS_TOKEN = "${module.secretsmanager-for-rollbar-access-tokens-live-crm-automations.secretsmanager_secret.arn}:post_server_item::"
  }

  secrets_wrapper_lambda_layer_version_number = local.lambda_layer_version_secrets_wrapper

  principals = {
    app-deploy = data.terraform_remote_state.deploy.outputs.iam_role_app_deploy
  }

  event_bus = data.terraform_remote_state.babbel["aqueduct"].outputs.event_bus_aqueduct

  environment = var.environment
  bucket      = data.terraform_remote_state.repositories.outputs.s3-bucket-babbel
  repository  = data.terraform_remote_state.repositories.outputs.github-lessonnine-live-crm-automations-microverse.full_name

  lambda_tags = {
    consuming_from = local.consuming_from
  }

  tags = local.tags
}

resource "aws_lambda_event_source_mapping" "live-crm-automations" {
  function_name = module.lambda-live-crm-automations.lambda.arn

  event_source_arn  = local.consuming_from
  starting_position = "LATEST"
  batch_size        = 100

  bisect_batch_on_function_error = true

  filter_criteria {
    filter {
      pattern = jsonencode({
        data = {
          name = local.events
        }
      })
    }
  }

  enabled = true
}

resource "aws_s3_object" "emarsys-external-payments" {
  bucket = data.terraform_remote_state.events.outputs.s3-bucket-events.bucket
  key    = "consumers/v1/${var.environment}/${module.lambda-live-crm-automations.lambda.microverse}.json"

  content = jsonencode({
    pattern = [for pattern in aws_lambda_event_source_mapping.live-crm-automations.filter_criteria.0.filter[*].pattern : jsondecode(pattern)]
    tags    = local.tags
  })
  content_type = "application/json"
}
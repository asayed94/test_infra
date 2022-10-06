module "lambda-alarms-live-groups-account-verifier" {
  source = "https://babbel.s3.amazonaws.com/lessonnine/shared.terraform/61febefe22c402ab5a7d3e515b7b67fa6aeef867/lambda/alarms.zip"

  function_name      = module.lambda-live-groups-account-verifier.lambda.function_name
  log_group_name     = module.lambda-live-groups-account-verifier.log_group.name
  treat_missing_data = "notBreaching"

  concurrent_executions_enabled = false

  concurrent_executions = {
    reserved_concurrent_executions = module.lambda-live-groups-account-verifier.lambda.reserved_concurrent_executions
  }

  duration = {
    timeout = module.lambda-live-groups-account-verifier.lambda.timeout
  }

  iterator_age_enabled = false

  max_memory_used = {
    memory_size = module.lambda-live-groups-account-verifier.lambda.memory_size
  }

  sns_topic_arns = {
    high = module.pagerduty-live-groups.sns_topics.low_urgency.regional.arn
    low  = module.pagerduty-live-groups.sns_topics.low_urgency.regional.arn
  }
}

resource "aws_budgets_budget" "app" {
  for_each = (
    local.budget_limit_amount != null ?
    {
      active = {
        limit_amount               = local.budget_limit_amount
        subscriber_email_addresses = local.teams[local.team].budget_notification_email_addresses
      }
    } :
    {}
  )

  name = local.tags.app

  budget_type = "COST"

  limit_amount      = each.value.limit_amount
  limit_unit        = "USD"
  time_period_start = "2018-01-01_00:00"
  time_unit         = "MONTHLY"

  cost_filter {
    name   = "TagKeyValue"
    values = ["user:app${"$"}${local.tags.app}"]
  }

  notification {
    notification_type   = "ACTUAL"
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"

    subscriber_email_addresses = each.value.subscriber_email_addresses
  }
}

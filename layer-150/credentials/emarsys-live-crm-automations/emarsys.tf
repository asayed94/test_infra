resource "aws_secretsmanager_secret" "emarsys_live_crm_automations_emarsys" {
  name = "emarsys-live-crm-automations-${var.environment}.emarsys"

  description = <<EOS
The value/version of this secrets-manager container shall be retrieved by the Terraform "emarsys-payments-events" module via the 
"aws_secretsmanager_secret_version" data source and needs to be parsed as JSON.
This is a JSON object containing the "username" and "secret" which shall be passed to the emarsys-payments-events service as environment 
variables "EMARSYS_USERNAME" and "EMARSYS_SECRET".
EOS

  tags = {
    app = "emarsys-live-crm-automations"
    env = var.environment

    "managed_by:team" = "crm_tech"
    "managed_by:xa"   = local.teams.crm_tech.xa
  }
}

output "secretsmanager_secret_emarsys_live_crm_automations_emarsys" {
  value = aws_secretsmanager_secret.live_crm_automations_emarsys
}


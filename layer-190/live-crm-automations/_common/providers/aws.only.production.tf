locals {
  aws_account_role_arn = "arn:aws:iam::${data.terraform_remote_state.meta.outputs.aws_organization_account_production.id}:role/${data.terraform_remote_state.meta.outputs.aws_organization_account_production.role_name}"
}

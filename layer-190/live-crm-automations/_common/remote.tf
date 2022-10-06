variable "remote_state_s3_bucket" {
  type = string
}

variable "remote_state_s3_region" {
  type = string
}

variable "remote_state_s3_role_arn" {
  type = string
}

data "terraform_remote_state" "babbel" {
  for_each = {
    # Convert each element from "layer-123/foo" to key-value pair "foo" => "layer-123/foo",
    # allowing to reference the data source instances without the layer number.
    for value in local.remote_babbel_modules :
    split("/", value)[1] => value
  }

  backend = "s3"

  config = {
    bucket   = var.remote_state_s3_bucket
    key      = "lessonnine/babbel.infrastructure/terraform/babbel/${each.key}/state-${var.environment}.tfstate"
    region   = var.remote_state_s3_region
    role_arn = var.remote_state_s3_role_arn
  }
}

data "terraform_remote_state" "deploy" {
  backend = "s3"

  config = {
    bucket   = var.remote_state_s3_bucket
    key      = "lessonnine/deploy.infrastructure/terraform/deploy/state.tfstate"
    region   = var.remote_state_s3_region
    role_arn = var.remote_state_s3_role_arn
  }
}

data "terraform_remote_state" "events" {
  backend = "s3"

  config = {
    bucket   = var.remote_state_s3_bucket
    key      = "lessonnine/events.infrastructure/terraform/events/state.tfstate"
    region   = var.remote_state_s3_region
    role_arn = var.remote_state_s3_role_arn
  }
}

data "terraform_remote_state" "meta" {
  backend = "s3"

  config = {
    bucket   = var.remote_state_s3_bucket
    key      = "lessonnine/meta.infrastructure/terraform/meta/state.tfstate"
    region   = var.remote_state_s3_region
    role_arn = var.remote_state_s3_role_arn
  }
}

data "terraform_remote_state" "repositories" {
  backend = "s3"

  config = {
    bucket   = var.remote_state_s3_bucket
    key      = "lessonnine/repositories.infrastructure/terraform/repositories/state.tfstate"
    region   = var.remote_state_s3_region
    role_arn = var.remote_state_s3_role_arn
  }
}

data "terraform_remote_state" "users" {
  backend = "s3"

  config = {
    bucket   = var.remote_state_s3_bucket
    key      = "lessonnine/users.infrastructure/terraform/users/state.tfstate"
    region   = var.remote_state_s3_region
    role_arn = var.remote_state_s3_role_arn
  }
}

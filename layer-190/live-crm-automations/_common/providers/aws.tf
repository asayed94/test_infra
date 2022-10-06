# AWS account for var.environment

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn     = local.aws_account_role_arn
    session_name = data.external.whoami.result["username"]
  }
}

data "aws_availability_zones" "all" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

provider "aws" {
  alias  = "secondary"
  region = "eu-central-1"

  assume_role {
    role_arn     = local.aws_account_role_arn
    session_name = data.external.whoami.result["username"]
  }
}

data "aws_region" "secondary" {
  provider = aws.secondary
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"

  assume_role {
    role_arn     = local.aws_account_role_arn
    session_name = data.external.whoami.result["username"]
  }
}

data "aws_region" "global" {
  provider = aws.global
}

# data platform AWS account

provider "aws" {
  alias  = "data-platform"
  region = "eu-west-1"

  assume_role {
    role_arn     = "arn:aws:iam::${data.terraform_remote_state.meta.outputs.aws_organization_account_data_platform.id}:role/AnalystSecretRole"
    session_name = data.external.whoami.result["username"]
  }
}

data "aws_region" "data-platform" {
  provider = aws.data-platform
}

# meta infrastructure (currently master account)

provider "aws" {
  alias  = "meta-primary"
  region = "eu-west-1"

  assume_role {
    role_arn = data.terraform_remote_state.meta.outputs.iam-role-read-terraform-configuration.arn

    session_name = data.external.whoami.result["username"]
  }
}

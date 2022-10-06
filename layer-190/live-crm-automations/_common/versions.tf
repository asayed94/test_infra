terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
    datadog = {
      source  = "datadog/datadog"
      version = "3.16.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.2.2"
    }
    github = {
      source  = "integrations/github"
      version = "5.3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.39.0"
    }
    okta = {
      source  = "okta/okta"
      version = "3.36.0"
    }
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "2.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    rollbar = {
      source  = "rollbar/rollbar"
      version = "1.7.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.3"
    }
  }
}

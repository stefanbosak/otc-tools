#https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs
terraform {
  backend "s3" {
    bucket = "organization-obs-all-iac"
    key    = "cce-cluster/terraform.tfstate"
    region = "eu-de"

    endpoints = {
      s3 = "https://obs.eu-de.otc.t-systems.com"
    }

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }

  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = "1.37.1"
    }
  }
}

provider "opentelekomcloud" {}

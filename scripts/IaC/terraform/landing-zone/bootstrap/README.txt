Terraform
=========

https://developer.hashicorp.com/terraform/docs
https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs

# variables
terraform.tfvars

# main (project, IAM groups and roles)
main.tf

# terraform versions
versions.tf

# otc-cli login is required for IaC (optionally, covered within ~/scripts/set_otc_environment.sh)
# otc login --cloud <cloud-name> --domain-id <domain-id>

# initialize terraform modules
terraform init

# review terraform plan (what would be applied)
terraform plan -no-color

# apply (after terraform plan has been reviewed)
terraform apply

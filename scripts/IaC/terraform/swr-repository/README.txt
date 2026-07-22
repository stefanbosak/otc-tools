Terraform
=========

https://developer.hashicorp.com/terraform/docs
https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs

# NOTE: otc-cli (https://github.com/ysoftdevs/otc-cli/) does not cover SWR
# (Software Repository for Container, OTC's Artifact Registry equivalent),
# so the SWR organization is created through this Terraform module instead.
# Individual repositories are created implicitly on first:
#   docker push swr.<region>.otc.t-systems.com/<organization>/<image>:<tag>

# variables
terraform.tfvars

# main (SWR organization)
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

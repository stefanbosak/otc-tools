Terraform
=========

https://developer.hashicorp.com/terraform/docs
https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs

# NOTE: otc-cli (https://github.com/ysoftdevs/otc-cli/) only covers day-2
# operations (list/show/config/login) and does not provision resources, so
# CCE cluster creation is handled through this Terraform module instead.
# Once created, fetch the kubeconfig with:
#   otc cce config <cluster-name> --cloud <cloud-name> --region <region> --project <project>

# variables
terraform.tfvars

# main (VPC, subnet, CCE cluster, default node pool)
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

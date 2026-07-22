#!/bin/bash
cwd=$(dirname $(realpath "${0}"))

# load environment details
source "${cwd}/set_otc_environment.sh"

export ORGANIZATION_NAME="${OTC_PROJECT}-repo"

# otc-cli does not cover SWR (container registry) provisioning, so the SWR
# organization (namespace) is created through the dedicated Terraform module
# instead (see IaC/terraform/swr-repository)
terraform -chdir="${cwd}/IaC/terraform/swr-repository" init
terraform -chdir="${cwd}/IaC/terraform/swr-repository" apply \
  -var="organization_name=${ORGANIZATION_NAME}" \
  -var="region=${OTC_REGION}"

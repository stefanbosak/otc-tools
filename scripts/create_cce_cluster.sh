#!/bin/bash
cwd=$(dirname $(realpath "${0}"))

# load environment details
source "${cwd}/set_otc_environment.sh"

# otc-cli only covers day-2 operations (list/show/config/login) and has no
# cluster-provisioning command, so CCE cluster creation is handled through
# the dedicated Terraform module instead (see IaC/terraform/cce-cluster)
terraform -chdir="${cwd}/IaC/terraform/cce-cluster" init
terraform -chdir="${cwd}/IaC/terraform/cce-cluster" apply \
  -var="cluster_name=${CLUSTER_NAME}"

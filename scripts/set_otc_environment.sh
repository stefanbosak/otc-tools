#!/bin/bash
# OTC cloud profile (defined in ~/.config/openstack/clouds.yaml)
export OTC_CLOUD=${OTC_CLOUD:-otc}

# domain (tenant) attributes
#
# NOTE: otc-cli has no equivalent of "gcloud config get account", so the
# domain id is expected to already be defined below or in clouds.yaml
export OTC_DOMAIN_ID=

# OTC_DOMAIN_ID is a required attribute, if empty terminate
if [ -z "${OTC_DOMAIN_ID}" ]; then
  echo "OTC_DOMAIN_ID is not set, exitting..."
  exit 1
fi

# login to OTC (browser-based SSO; safe to re-run once the token expires)
otc login --cloud "${OTC_CLOUD}" --domain-id "${OTC_DOMAIN_ID}"

# project attributes
#
# NOTE: unlike gcloud, otc-cli requires an explicit project scope on every
# command instead of an implicit "current project" configuration
export OTC_PROJECT=

# OTC_PROJECT is a required attribute, if empty terminate
if [ -z "${OTC_PROJECT}" ]; then
  echo "OTC_PROJECT is not set, exitting..."
  exit 1
fi

# location attributes
export OTC_REGION=

# OTC_REGION is a required attribute, if empty terminate
if [ -z "${OTC_REGION}" ]; then
  echo "OTC_REGION is not set, exitting..."
  exit 1
fi

# cluster attributes
#
# NOTE: currently only one cluster is supported, working with more clusters would be added later
export CLUSTER_NAME=$(otc cce list --cloud "${OTC_CLOUD}" --region "${OTC_REGION}" --project "${OTC_PROJECT}" -f value 2> /dev/null | awk 'NR==1{print $1}')

# extract cluster credentials for kubectl only when a cluster has been recognized
if [ ! -z "${CLUSTER_NAME}" ]; then
  # writes/merges the CCE cluster kubeconfig used by kubectl
  otc cce config "${CLUSTER_NAME}" --cloud "${OTC_CLOUD}" --region "${OTC_REGION}" --project "${OTC_PROJECT}"
fi

# authentication to the SWR container registry
#
# NOTE: otc-cli does not cover SWR; authenticate with a temporary login
# token retrieved from the SWR console/API, e.g.:
#   docker login -u "${OTC_DOMAIN_ID}@<AK>" -p "<login-token>" "swr.${OTC_REGION}.otc.t-systems.com"

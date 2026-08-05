CloudNativePG (Helm)
======================

https://cloudnative-pg.io/documentation/current/installation_upgrade/#helm
https://artifacthub.io/packages/helm/cloudnative-pg/cloudnative-pg

# NOTE: cnpgctl (bundled in this image, aliased from the kubectl-cnpg
# plugin) only manages an already-running operator/clusters; it has no
# chart-install command, so the operator itself is installed through this
# Helm chart.

# add/update the cnpg repo
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm repo update

# install the operator
helm install cnpg cnpg/cloudnative-pg \
  --namespace cnpg-system --create-namespace \
  -f values.yaml

# verify with the bundled CNPG kubectl plugin
cnpgctl status

# upgrade / uninstall
helm upgrade cnpg cnpg/cloudnative-pg --namespace cnpg-system -f values.yaml
helm uninstall cnpg --namespace cnpg-system

cert-manager (Helm)
====================

https://cert-manager.io/docs/installation/helm/
https://artifacthub.io/packages/helm/cert-manager/cert-manager

# NOTE: cmctl (bundled in this image) only checks/manages an already-running
# cert-manager install; it has no chart-install command, so the operator
# itself is installed through this Helm chart.

# add/update the jetstack repo
helm repo add jetstack https://charts.jetstack.io
helm repo update

# install (CRDs are installed by the chart, see values.yaml)
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager --create-namespace \
  -f values.yaml

# verify with the bundled cert-manager CLI
cmctl check api --namespace cert-manager

# upgrade / uninstall
helm upgrade cert-manager jetstack/cert-manager --namespace cert-manager -f values.yaml
helm uninstall cert-manager --namespace cert-manager

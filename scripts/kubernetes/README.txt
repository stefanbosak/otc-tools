Kubernetes (kubectl + Helm)
============================

https://kubernetes.io/docs/reference/kubectl/
https://helm.sh/docs/helm/

# NOTE: CCE cluster access is established via ~/scripts/set_otc_environment.sh,
# which merges the CCE kubeconfig once a cluster is recognized (see
# IaC/terraform/cce-cluster). Run it before any kubectl/helm command below.

# plain kubectl manifests (namespace, deployment, service)
manifests/sample-workload

# OTC-specific CSI storage (everest add-on: EVS/SFS/OBS StorageClasses + PVCs)
manifests/csi-storage

# OTC-specific CNI networking (CCE network models, NetworkPolicy examples)
manifests/cni-networking

# Helm charts for the operators whose CLIs are already bundled in this image
# (cmctl -> cert-manager, cnpgctl -> CloudNativePG)
helm/cert-manager
helm/cloudnative-pg

# quick cluster sanity check
kubectl get nodes
kubectl get ns
helm list --all-namespaces

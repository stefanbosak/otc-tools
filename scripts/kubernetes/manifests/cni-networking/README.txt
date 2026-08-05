CNI Networking (CCE network models)
======================================

https://docs.otc.t-systems.com/cloud-container-engine/umn/networking/networking_overview.html

# NOTE: OTC CCE offers three container network (CNI) models, selected at
# cluster creation and not changeable afterwards:
#   Container Tunnel Network -> overlay, OVS/VXLAN encapsulation on top of
#                                the node network, decoupled from the VPC.
#                                This is what IaC/terraform/cce-cluster
#                                provisions (container_network_type =
#                                "overlay_l2"), and it enforces standard
#                                Kubernetes NetworkPolicy resources.
#   VPC Network              -> routes pod CIDRs directly in the VPC route
#                                table, no encapsulation overhead, but the
#                                node count is bound by the VPC route quota.
#   Cloud Native Network 2.0 -> CCE Turbo clusters only; pods get ENIs/
#                                sub-ENIs straight from the VPC for
#                                near-native throughput and higher density.
#
# The two policies below are plain Kubernetes NetworkPolicy objects, which
# work unmodified against the Container Tunnel Network model used by this
# repo's cce-cluster module. If the cluster's container_network_type is
# instead "vpc-router" (VPC Network) or a CCE Turbo cluster, re-check the
# OTC docs above for that model's current NetworkPolicy support.

# default-deny baseline for the sample-workload namespace
networkpolicy-default-deny.yaml

# punches a hole back open: only pods labelled role=frontend, in a
# namespace labelled frontend, may reach sample-workload on port 80
networkpolicy-allow-frontend.yaml

# apply (namespace + workload come from manifests/sample-workload)
kubectl apply -f ../sample-workload/namespace.yaml
kubectl apply -f ../sample-workload/deployment.yaml -f ../sample-workload/service.yaml
kubectl apply -f networkpolicy-default-deny.yaml -f networkpolicy-allow-frontend.yaml

# verify
kubectl -n sample-workload get networkpolicy
kubectl -n sample-workload describe networkpolicy allow-frontend-to-sample-workload

# clean up
kubectl delete -f networkpolicy-default-deny.yaml -f networkpolicy-allow-frontend.yaml

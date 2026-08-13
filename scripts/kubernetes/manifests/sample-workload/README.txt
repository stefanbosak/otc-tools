Sample Workload (kubectl)
==========================

# namespace
namespace.yaml

# deployment (2 replicas)
deployment.yaml

# ClusterIP service in front of the deployment
service.yaml

# apply namespace first, then the workload
kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml -f service.yaml

# check rollout status
kubectl -n sample-workload rollout status deployment/sample-workload

# inspect resources
kubectl -n sample-workload get pods,svc

# remove everything (namespace deletion cascades to the deployment/service)
kubectl delete -f namespace.yaml

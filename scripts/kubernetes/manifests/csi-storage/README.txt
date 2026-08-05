CSI Storage (Everest add-on)
==============================

https://docs.otc.t-systems.com/cloud-container-engine/umn/add-ons/container_storage_add-ons/cce_container_storage_everest.html

# NOTE: every OTC CCE cluster of Kubernetes v1.15+ ships the "everest" CSI
# add-on by default (provisioner: everest-csi-provisioner). It exposes
# three built-in StorageClasses out of the box, backed by different OTC
# storage services:
#   csi-disk  -> EVS (Elastic Volume Service), block storage, RWO only
#   csi-nas   -> SFS (Scalable File Service), shared file storage, RWX
#   csi-obs   -> OBS (Object Storage Service), object storage via obsfs, RWX
#
# kubectl get sc   # lists the built-ins once the cluster is reachable

# custom StorageClass on top of the everest EVS driver (disk.csi.everest.io),
# pinning the disk-volume-type to SSD instead of the default SAS tier
storageclass-csi-disk-ssd.yaml

# PVC bound against the custom SSD disk class (ReadWriteOnce block volume)
pvc-csi-disk.yaml

# PVC bound against the built-in csi-obs class (ReadWriteMany object storage,
# mounted with the obsfs driver so it can be shared across pods/nodes)
pvc-csi-obs.yaml

# Pod that mounts both PVCs, to see the CSI driver actually attach/mount
pod-with-volumes.yaml

# apply (namespace comes from manifests/sample-workload)
kubectl apply -f ../sample-workload/namespace.yaml
kubectl apply -f storageclass-csi-disk-ssd.yaml
kubectl apply -f pvc-csi-disk.yaml -f pvc-csi-obs.yaml
kubectl apply -f pod-with-volumes.yaml

# verify binding and the underlying everest CSI driver pods
kubectl -n sample-workload get pvc
kubectl -n kube-system get pods -l app=everest-csi-controller

# clean up
kubectl delete -f pod-with-volumes.yaml -f pvc-csi-disk.yaml -f pvc-csi-obs.yaml -f storageclass-csi-disk-ssd.yaml

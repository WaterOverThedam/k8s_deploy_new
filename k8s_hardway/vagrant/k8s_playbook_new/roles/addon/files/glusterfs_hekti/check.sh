#!/bin/bash


HEKETI_POD=$(kubectl get pod -l name=heketi -o jsonpath="{.items[0].metadata.name}") && \
echo "heketi check ..." && \
kubectl exec -it $HEKETI_POD -- bash -c "heketi-cli  --user admin --secret 'My Secret' topology info" 

GLUSTERFS_POD=$(kubectl get pod -l glusterfs-node=pod -o jsonpath="{.items[0].metadata.name}") && \
echo "glusterFS node check ..." && \
kubectl exec -it $GLUSTERFS_POD -- bash -c "/usr/sbin/gluster peer status"

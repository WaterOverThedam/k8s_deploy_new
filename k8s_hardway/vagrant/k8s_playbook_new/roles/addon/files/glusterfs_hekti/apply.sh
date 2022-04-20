#!/bin/bash

export PATH=$PATH:/usr/local/bin

kubectl get no  --no-headers|awk '{print "kubectl label node "$1" storagenode=glusterfs --overwrite"}'|sh && \
kubectl apply -f glusterfs-daemonset.yaml && \
kubectl apply -f heketi-deployment.yaml && \
kubectl apply -f heketi-security.yaml 

#!/bin/bash

export PATH=$PATH:/usr/local/bin
kubectl get pod |grep gluster || {
  echo 'no gluster pod'
  exit 1
}
HEKETI_POD=$(kubectl get pod -l name=heketi -o jsonpath="{.items[0].metadata.name}") && \
kubectl cp /tmp/glusterfs_hekti/install.sh $HEKETI_POD:/tmp/  && \
kubectl cp /tmp/glusterfs_hekti/topology.json $HEKETI_POD:/tmp/   && \
kubectl exec -it $HEKETI_POD -- chmod +x /tmp/{install.sh,topology.json}  && \
kubectl exec -it $HEKETI_POD -- /tmp/install.sh

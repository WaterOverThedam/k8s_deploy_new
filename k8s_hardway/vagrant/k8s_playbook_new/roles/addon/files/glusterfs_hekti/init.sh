#!/bin/bash

HEKETI_POD=$(kubectl get pod -l name=heketi -o jsonpath="{.items[0].metadata.name}")
kubectl cp /tmp/install.sh $HEKETI_POD:/tmp/ 
kubectl cp /tmp/topology.json $HEKETI_POD:/tmp/ 
kubectl exec -it $HEKETI_POD -- chmod +x /tmp/{install.sh,topology.json}
kubectl exec -it $HEKETI_POD -- /tmp/install.sh

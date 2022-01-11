#!/bin/bash

for ns  in `kubectl get ns --no-headers | grep "md-" | awk '{ print $1 }' -`
do
    echo $ns

    for pvc  in `kubectl -n $ns get --no-headers pvc  | awk '{ print $1 }' -`
    do
        echo "pvc: $pvc"
        kubectl -n $ns delete pvc $pvc
    done

    kubectl delete ns $ns
    echo "------------------------------------------------------------"
done



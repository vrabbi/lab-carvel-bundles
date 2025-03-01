#!/bin/bash

# Download vcluster binary.
curl -L --silent --show-error --fail -o /opt/kubernetes/bin/vcluster https://github.com/loft-sh/vcluster/releases/download/v0.3.0-beta.2/vcluster-linux-amd64 --retry 10 --retry-connrefused --retry-max-time 120 --retry-delay 5

chmod +x /opt/kubernetes/bin/vcluster

# Ensure using Educates cluster context.

kubectl config use-context eduk8s 1>/home/eduk8s/logs 2>/home/eduk8s/errors

# Connect to cluster, merging the kubeconfig with $HOME/.kube/config.

vcluster connect vcluster -n $SESSION_NAMESPACE-vc --server https://vcluster.$SESSION_NAMESPACE-vc.svc.cluster.local --update-current 1>/home/eduk8s/logs 2>/home/eduk8s/errors

# Set the current context to use the virtual Kubernetes cluster.

kubectl config use-context vcluster_$SESSION_NAMESPACE-vc_vcluster  1>/home/eduk8s/logs 2>/home/eduk8s/errors

kubectl config set-context vcluster_$SESSION_NAMESPACE-vc_vcluster --namespace default 1>/home/eduk8s/logs 2>/home/eduk8s/errors

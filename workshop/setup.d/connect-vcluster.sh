#!/bin/bash

set -x

set -eo pipefail

# Download vcluster binary.
sleep 10
curl -L --silent --show-error --fail -o /opt/kubernetes/bin/vcluster https://github.com/loft-sh/vcluster/releases/download/v0.3.0-beta.2/vcluster-linux-amd64

chmod +x /opt/kubernetes/bin/vcluster

# Ensure using Educates cluster context.

kubectl config use-context eduk8s

# Connect to cluster, merging the kubeconfig with $HOME/.kube/config.

vcluster connect vcluster -n $SESSION_NAMESPACE-vc --server https://vcluster.$SESSION_NAMESPACE-vc.svc.cluster.local --update-current

# Set the current context to use the virtual Kubernetes cluster.

kubectl config use-context vcluster_$SESSION_NAMESPACE-vc_vcluster 

kubectl config set-context vcluster_$SESSION_NAMESPACE-vc_vcluster --namespace default

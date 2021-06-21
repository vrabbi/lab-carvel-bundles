This workshop environment uses a virtual Kubernetes cluster. To verify that
the virtual Kubernetes cluster has started up correctly, run:

```terminal:execute
command: kubectl get ns
```

You should see the namespaces listed below.

```
NAME              STATUS   AGE
default           Active   5m
kube-system       Active   5m
kube-public       Active   5m
kube-node-lease   Active   5m
```

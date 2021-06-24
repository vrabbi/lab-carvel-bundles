```terminal:execute
command: tree bundles
```

```terminal:execute
command: (cd bundles/educates; vendir sync)
```

```terminal:execute
command: (cd bundles/educates; kbld --imgpkg-lock-output .imgpkg/images.yml)
```

```terminal:execute
command: imgpkg push -b {{registry_host}}/educates:21.05.10.1 -f bundles/educates
```

```terminal:execute
command: imgpkg pull -b {{registry_host}}/educates:21.05.10.1 -o /tmp/educates-bundle
```

```terminal:execute
command: imgpkg copy -b {{registry_host}}/educates:21.05.10.1 --to-repo={{registry_host}}/educates-local
```

```terminal:execute
command: kubectl create ns eduk8s
```

```terminal:execute
command: ytt -f bundles/educates/config -v ingressDomain={{ingress_domain}} | kbld -f - | kapp deploy -a educates -f - -y
```

```terminal:execute
command: |
  kubectl apply -f https://raw.githubusercontent.com/eduk8s/lab-markdown-sample/master/resources/workshop.yaml
  kubectl apply -f https://raw.githubusercontent.com/eduk8s/lab-markdown-sample/master/resources/training-portal.yaml
```

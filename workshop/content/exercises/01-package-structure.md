```terminal:execute
command: tree upstream
```

```terminal:execute
command: imgpkg push -b {{registry_host}}/educates:21.05.10.1 -f bundles/educates
```

```terminal:execute
command: imgpkg copy -b {{registry_host}}/educates:21.05.10.1 --to-repo={{registry_host}}/educates-local
```

```terminal:execute
command: kubectl create ns eduk8s
```

```terminal:execute
command: ytt -f bundles/educates/config | kbld -f - | kapp deploy -a educates -f - -y
```

```terminal:execute
command: |
  kubectl apply -f https://raw.githubusercontent.com/eduk8s/lab-markdown-sample/master/resources/workshop.yaml
  kubectl apply -f https://raw.githubusercontent.com/eduk8s/lab-markdown-sample/master/resources/training-portal.yaml
```

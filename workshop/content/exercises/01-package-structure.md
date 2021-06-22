```terminal:execute
command: tree upstream
```

```terminal:execute
command: kubectl create ns eduk8s
```

```terminal:execute
command: ytt -f upstream | k apply -f -
```

```terminal:execute
command: |
  kubectl apply -f https://raw.githubusercontent.com/eduk8s/lab-markdown-sample/master/resources/workshop.yaml
  kubectl apply -f https://raw.githubusercontent.com/eduk8s/lab-markdown-sample/master/resources/training-portal.yaml
```

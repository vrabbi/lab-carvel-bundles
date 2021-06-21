```terminal:execute
command: tree packages
```

```terminal:execute
command: (cd packages/educates/bundle; vendir sync)
```

```terminal:execute
command: tree packages
```

```terminal:execute
command: ytt -f packages/educates/bundle/config | k apply -f -
```

```terminal:execute
command: |
  kubectl apply -f https://raw.githubusercontent.com/eduk8s/lab-markdown-sample/master/resources/workshop.yaml
  kubectl apply -f https://raw.githubusercontent.com/eduk8s/lab-markdown-sample/master/resources/training-portal.yaml
```

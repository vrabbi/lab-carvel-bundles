```terminal:execute
command: tree packages
```

```terminal:execute
command: |
  cat > packages/educates/bundle/vendir.yml << EOF
  apiVersion: vendir.k14s.io/v1alpha1
  kind: Config
  directories:
  - path: config/upstream
    contents:
    - path: .
      git:
        url: https://github.com/eduk8s/eduk8s
        ref: 21.05.10.1
      newRootPath: resources
      excludePaths:
      - resources/kustomization.yaml
  EOF
```

```terminal:execute
command: (cd packages/educates/bundle; vendir sync)
```

```terminal:execute
command: tree packages
```


```terminal:execute
command: |
  mkdir -v -p packages/educates
  mkdir -v packages/educates/bundle
  mkdir -v packages/educates/bundle/config
  mkdir -v packages/educates/bundle/.imgpkg
  mkdir -v packages/educates/bundle/config/overlay
  mkdir -v packages/educates/bundle/config/upstream
```

```terminal:execute
command: |
  cat > packages/educates/bundle/vendir.yml << EOF
  apiVersion: vendir.k14s.io/v1alpha1
  kind: Config
  directories:
  - path: config
    contents:
    - path: upstream
      git:
        url: https://github.com/eduk8s/eduk8s
        ref: origin/master
      newRootPath: resources
  EOF
```

```terminal:execute
command: (cd packages/educates/bundle; vendir sync)
```

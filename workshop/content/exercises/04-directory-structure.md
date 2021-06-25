To get started we first want to construct a directory structure to hold both
the upstream deployment resources for Educates, as well as our own customized
overlays and resources.

```terminal:execute
command: |-
  mkdir -p packages/educates
  mkdir -p packages/educates/bundle
  mkdir -p packages/educates/bundle/config
  mkdir -p packages/educates/bundle/.imgpkg
  mkdir -p packages/educates/bundle/config/overlay
  mkdir -p packages/educates/bundle/config/resources
  mkdir -p packages/educates/bundle/config/upstream
```

The result will be a directory structure looking like:

```
packages
└── educates
    └── bundle
        └── config
            ├── overlay
            ├── resources
            └── upstream
```

This may look elaborate, but there is a greater purpose with what we are
trying to achieve with the Carvel tools, and this is the layout we need to
use.

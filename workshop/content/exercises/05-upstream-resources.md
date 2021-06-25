We next need a copy of the deployment resources for the Educates package.

You may be tempted to manually make a copy of the resources from a specific
version of Educates, but doing anything manually can be prone to mistakes.
Automating the creation of a snapshot of any upstream resources is therefore
recommended, and this is where the next tool from the Carvel tool set comes
into play. This tool is called ``vendir``.

The purpose of ``vendir`` is to make copies of select resources from an
upstream package hosted on GitHub, a HTTP server or other hosting mechanism.

Keeping with the idea that any configuration driving such a process would be
kept under source control and therefore reproduceable, we can create a
configuration file to be used by ``vendir``.

In this workshop we have already pre-created this configuration, which can
be found at ``packages/educates/bundle/vendir.yml``.

```editor:open-file
path: ~/exercises/packages/educates/bundle/vendir.yml
```

The contents should be:

```
apiVersion: vendir.k14s.io/v1alpha1
kind: Config
directories:
  - path: config/upstream
    contents:
      - path: .
        git:
          url: https://github.com/eduk8s/eduk8s
          ref: 21.05.10.1
        includePaths:
        - resources/crds-v1/**/*
        - resources/operator/**/*
        - resources/image-mappings.env
        excludePaths:
        - resources/operator/namespace.yaml
```

To have the specific version of the upstream resources downloaded to our
local directory we can then run:

```terminal:execute
command: (cd packages/educates/bundle; vendir sync)
```

The list of files copied down can be seen by running:

```terminal:execute
command: tree packages/educates/bundle/config/upstream
```

Of the original files we can say exactly what we want to be copied through
listing the files to include, or what to exclude.

In this case we have included all the raw Kubernetes resources with the
exception of that which was creating the namespace. We will cover why we
don't include this one later.

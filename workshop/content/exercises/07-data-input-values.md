The source of the defaults for input values is the file
``packages/educates/bundle/config/values.yaml``.

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/values.yaml
```

Here we have already pre-defined all the data values that can be specified.
For example:

```
#@data/values
---

#! The namespace in which to deploy Educates.

namespace: eduk8s

#! DNS parent subdomain used for training portal and workshop ingresses.

ingressDomain: workshops.example.com
```

As we will see later, the default values can be overridden when processing
the resource bundle. This can be done as command line options or by specifying
an additional data values file with overrides. In other words, the original
data values file is always left as is and changes are applied separately.

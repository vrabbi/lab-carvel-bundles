The source of the defaults for input values is the file
``packages/educates/bundle/config/values.yaml``.

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/values.yaml
```

Here we have already pre-defined all the data values that can be specified,
including that for ``namespace``.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/config/overlay/operator-image.yaml
text: "namespace = .*"
isRegex: true
```

As we will see later, the default values can be overridden when processing the
resources. This can be done as command line options or by specifying an
additional data values file with overrides. In other words, the original data
values file is always left as is and changes are applied separately, ensuring
you don't loose what the default values were.

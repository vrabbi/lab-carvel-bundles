The next example of an overlay can be found in the file
``packages/educates/bundle/config/overlay/operator-image.yaml``.

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/overlay/operator-image.yaml
```

This example is a bit more complicated and shows how where we previously
used ``data.values.namespace``, that can actually be any expression. Further
that it is possible to embed programmatic logic, including conditionals
and loops.

```
      #@ pull_secrets = image_pull_secrets()
      #@ if pull_secrets:
      #@overlay/match missing_ok=True
      imagePullSecrets: #@ [{"name": name} for name in pull_secrets]
      #@ end
```

The programming language used with ``ytt`` is
[Starlark](https://github.com/google/starlark-go), which is a dialect of
Python intended for use as a configuration language.

As well as being able to be used to embed programmatic logic into the
resources, it is possible to create your own libraries of helper functions
and make callouts to these functions. This is what is occuring with the
``image_pull_secrets()`` call in the example above.

The set of helper functions implemented for use with these resources can be
seen in the file ``packages/educates/bundle/config/helpers.star``.

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/helpers.star
```

Builtin Starlark function libraries are also provided for tasks such as
regular expression matching, hashing, serialization, and more.

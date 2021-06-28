Since we want to be able to make changes to the original upstream resources
for Educates, but not actually edit the files themselves, we use a feature
of ``ytt`` called overlays to apply changes to them.

Our first example of an overlay can be found in the file
``packages/educates/bundle/config/overlay/namespaces.yaml``.

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/overlay/namespaces.yaml
```

In this case what is occuring is that we are ensuring that the ``namespace``
property of the resources is set to the namespace where we want to deploy
the Educates operator. This includes the namespace of a service account
when referenced in a role binding.

What you may notice though is that the namespace we want to use isn't itself
defined in the overlay file. Instead you will see a reference to a data
value called ``data.values.namespace``.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/config/overlay/namespaces.yaml
text: "data.values.namespace"
```

So in addition to the overlay feature of ``ytt``, we are also using its
ability to support templates, where an overlay itself can be a template.

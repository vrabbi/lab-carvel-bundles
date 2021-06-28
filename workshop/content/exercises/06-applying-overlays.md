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
the Educates operator.

As example from this overlay file is:

```
#@overlay/match by=overlay.subset({"kind":"Deployment", "metadata": {"name": "eduk8s-operator"}})
---
metadata:
  #@overlay/match missing_ok=True
  namespace: #@ data.values.namespace
```

What you may notice though is that the namespace we want to use isn't itself
defined in the overlay file. Instead you will see a reference to a data
value called ``data.values.namespace``.

So in addition to the overlay feature of ``ytt``, we are also using its
ability to support templates, where an overlay itself can be a template.

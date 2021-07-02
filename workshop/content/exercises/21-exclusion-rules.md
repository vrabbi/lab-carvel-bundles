As has already been mentioned, one of the benefits of using ``kapp`` is that
it will reorder the Kubernetes resources before applying them to the cluster.
The behaviour of ``kapp`` around this is driven by an inbuilt rule set which
you can display by running:

```terminal:execute
command: kapp deploy-config
```

Where you have special requirements you can provide additional configuration
to ``kapp`` to control how it works. You could for example specify special
ordering relationships of your own between resources being created to ensure
certain actions are performed before others.

In the case of Educates we have up till now been automatically injecting some
custom configuration for ``kapp``. This was being done to exclude certain
fields within custom resources handled by Educates from consideration when
using the ``--diff-changes`` option to ``kapp``.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/config/kapp-config.yml
text: "diffAgainstLastAppliedFieldExclusionRules:"
after: 8
```

Adding exclusion rules for these fields was necessary as they are special
fields which are injected by the Educates operator, or more precisely by
the operator framework it uses. As these fields represent state information
and are updated after any change to the custom resource, they would always
show as changing each time a change was made but aren't actually relevant
in the context of any changes we would make, being an internal detail of
how the operator functions.

For this configuration it wasn't necessary to inject it explicitly as it
was included in the ``config`` directory, and thus was always being passed
to ``kapp``.

When we processed the resources using ``ytt`` we did not supply any data
values to override the defaults. The result is that since we didn't override
the ingress domain used by Educates, we will not be able to access any
Educates workshops were we to deploy some.

To provide data values you can either supply them individually on the command
line when running ``ytt``, such as in:

```terminal:execute
command: ytt -f packages/educates/bundle/config -v ingressDomain={{ingress_domain}} > educates-resources.yaml
```

or you can create a separate values file with any overrides in it, and pass
the name of that as an option.

To create a separate values file run:

```execute
cat > educates-values.yaml << EOF
#@data/values
---

ingressDomain: {{ingress_domain}}
EOF
```

Then generate the resources using:

```terminal:execute
command: ytt -f packages/educates/bundle/config -f educates-values.yaml > educates-resources.yaml
```

Note that the order of the options is important, with overrides for data
values needing to come last.

Since in this case we output the processed resources to a file, we can use
``kapp`` to show us what the differences are, and verify we want to apply
them, before updating the cluster.

```terminal:execute
command: kapp deploy -a educates -f educates-resources.yaml --diff-changes
```

We were prompted in this case to confirm the changes as we didn't supply the
``-y`` option.

Enter "y" to confirm that the changes should be applied to the cluster.

```terminal:input
text: y
```

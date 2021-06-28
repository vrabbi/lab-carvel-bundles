With the original upstream resources copied, and the overlays and additional
resources also having been created, it is time to deploy Educates using our
modifications.

To do this we first need to pass all our resources through ``ytt`` to have it
expand them based on the data input values.

To see the result of this run:

```terminal:execute
command: ytt -f packages/educates/bundle/config
```

The result from this will be all the resources being displayed to the terminal,
but nothing will be created in the cluster.

Normally you would expect that you could pipe the output from ``ytt`` direct
into ``kubectl apply -f -``, however this can be problematic and can fail.

The reason this can fail is that when you use tools which process a set of
resources, you cannot necessarily control the order in which the final
resources are output.

In particular, applying the resources to the cluster can fail if the resource
for a namespace isn't output before the resources which need to be created in
that namespace. Another problem that can occur is that a custom resource
definition may not have been applied before an instance of the custom resource
needs to be created.

To solve the problem of ordering we are going to use another tool from the
Carvel tool set to apply the resources to the cluster. This tool is called
``kapp``.

Although ``kapp`` avoids our current problem, by doing some reordering of
resources before applying them, it can do much more than that.

To create the deployment using ``kapp``, run:

```terminal:execute
command: ytt -f packages/educates/bundle/config | kapp deploy -a educates -f - -y
```

You will see quite a bit of output from ``kapp`` as it validates and reorders
the resources and applies them to the cluster.

When it is finished, just to make sure the Educates operator has finished
deploying, run:

```terminal:execute
command: kubectl rollout status deployment/eduk8s-operator -n eduk8s
```

One aspect of ``kapp`` worth pointing out is that it is able to track
what applications you have deployed using it. To see this, run:

```terminal:execute
command: kapp list
```

This will show the list of applications you have deployed.

You can then use ``kapp`` to inspect the set of resources created for an
application:

```terminal:execute
command: kapp inspect -a educates
```

or shows logs for any pods created by the deployment.

```terminal:execute
command: kapp logs -a educates
```

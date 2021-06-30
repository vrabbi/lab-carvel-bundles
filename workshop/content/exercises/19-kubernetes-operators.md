Kubernetes operators such as Educates, can face extra complications when it
comes to installing and using them in a disconnected environment.

The problem with operators is that when they respond to a custom resource that
often triggers the creation of deployment resources within the Kubernetes
cluster. How the resources are defined and what container images they require
can be hard wired in the operator code and not something that is evident by
looking at the resources used to deploy the operator itself.

This is the case with Educates which will create deployments for a training
portal and workshop sessions.

Fortuitously Educates implements a mechanism which extracts out the details of
what those images are into the configuration, with the names of the images
being passed to the operator through a Kubernetes config map. Originally this
was done to make it easier to develop Educates as one could swap out what
images were used without needing to rebuild the operator container image. The
presence of this mechanism is though going to help in the case of being able
to support disconnected environments.

The list of the internal images and versions used by Educates are included
as part of the data values file.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/config/values.yaml
text: "imageVersions:"
after: 14
```

This is used to construct the config map which is mounted into the container
for the Educates operator.

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/resources/image-mappings.yaml
```

The problem is that ``kbld`` will not rewrite the image references in the
config map. This is because by default ``kbld`` will only attempt to rewrite
image references which appear against an ``image`` field in any resources.

Configuration for ``kbld`` to change this behaviour is why the option
``-f educates-private/kbld-bundle.yml`` supplied to ``kbld`` with this latest
deployment is used.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/kbld-bundle.yml
text: "searchRules:"
after: 10
```

The search rules tell ``kbld`` to also rewrite any image reference it finds
in fields ``PORTAL_IMAGE``, ``BASE_ENVIRONMENT_IMAGE`` etc. This way the
images used in deployments created by the operator code will also be
rewritten to use the versions of the images copied to the internal image
registry on the private network.

If you need to create configuration for a Kubernetes operator so it can be
installed in a disconnected environment, you will need to keep this in mind
and may have to modify the operator code so that it can be supplied details
of images through a config map supplied through the deployment resources.
By externalizing details of the images, ``kbld`` can then do its job of
helping in relocation of images and rewriting the configuration used by the
operator.

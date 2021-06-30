Given that disconnected networks are created to keep things secure, it is
likely to be the case that the internal image registry to which a bundle is
being relocated will require credentials to be accessed.

Although the ``imgpkg`` tool can deal with authenticated registries when
pushing, pulling or copying bundles, the Carvel tools don't otherwise help in
respect of ensuring that when a set of resources are deployed to a cluster,
that Kubernetes will be able to access the image registry when pulling
container images.

For this the application resources must themselves accomodate the fact that an
authenticated image registry is used.

In the case of the upstream Educates resources they did not support being able
to deploy the operator container image from an authenticated registry. This
though is something that can be handled by additional resources and overlays.

First up, provision was added to supplying as data values credentials for the
image registry.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/config/values.yaml
text: "imageRegistry:"
after: 3
```

An image registry pull secret was then created if the image registry
credentials were provided:

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/resources/registry-secret.yaml
```

and the deployment for the operator patched using an overlay to use the
image registry pull secret.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/config/overlay/operator-image.yaml
text: "pull_secrets = image_pull_secrets()"
after: 4
```

In the case of Educates the operator itself creates deployments. We already
dealt with how to pass details of the relocated images via the config map.
Luckily Educates also already provided a way to supply image pull secrets for
use when those internal container images are deployed so it was possible to
piggy back on that.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/config/resources/system-profile.yaml
text: "pull_secrets = image_pull_secrets()"
after: 5
```

With that all in place, and since for this workshop session the image registry
requires authentication, this is why when deploying Educates using the
relocated image bundle that the image registry host, username and password
were supplied as data values when running ``ytt`` in this latest deployment.

Now that we have an image lock file which includes a list of images with the
resolved hash references for the images, we are ready for the next step, which
is to create a bundle containing the configuration for the application.

Bundles are a bit different to what you may be used to as they aren't just a
set of files that reside on your local filesystem. Bundles are OCI artifacts
which you need to host on an OCI compliant image registry.

Use of the bundles is tied to being able to host them in an image registry,
with use in a disconnected environment entailing copying the configuration
bundle and its associated container images from one image registry to another,
where the latter would be within the network of the disconnected environment. 

To create the bundle we use another tool from the Carvel tool set. This is the
``imgpkg`` command.

To create the configuration bundle for Educates and push it to an image
registry run:

```terminal:execute
command: imgpkg push -b {{registry_host}}/educates:21.05.10.1 -f packages/educates/bundle
```

In this case the image registry is associated with this workshop session and
the session has already been logged into the image registry so that login
credentials do not need to be passed explicitly.

To verify that the bundle has been uploaded, you can use a tool such as
``skopeo`` to inspect the OCI artifact stored in the image registry.

```terminal:execute
command: skopeo inspect docker://{{registry_host}}/educates:21.05.10.1
```

The ``dev.carvel.imgpkg.bundle`` label recorded in the image manifest is
what identifies it as a bundle created using ``imgpkg``.

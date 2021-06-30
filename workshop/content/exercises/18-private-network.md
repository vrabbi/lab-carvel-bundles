We now have the configuration bundle, as well as all the required container
images for the application copied into the internal image registry of the
private network.

To deploy the application to a Kubernetes cluster within the private network
the process is similar to before when deploying it from the public image
registry.

First up, delete the Educates deployment once more.

```terminal:execute
command: kapp delete -a educates -y
```

Once that is done, copy down the configuration bundle again, this time from
the copy we made.

```terminal:execute
command: imgpkg pull -b {{registry_host}}/educates-private:21.05.10.1 -o educates-private
```

The name of the directory this time is ``educates-private``. The ``-private``
suffix is to highlight that this bundle is for use in the private network of
the disconnected environment.

This version is the same as before with the exception of one file, which is
the images lock file.

```editor:open-file
file: ~/exercises/educates-private/.imgpkg/images.yml
```

If you look at the images lock file now you will see that the image references
have been rewritten to refer to the images which were copied into the internal
image registry, and no longer reference the originals where they existed on
the public image registry.

To accomodate that the image references have been rewritten we need to adjust
the command we use to deploy the application using the relocated configuration
bundle. The new command is:

```terminal:execute
command: |
  ytt -f educates-private/config -f educates-values.yaml \
    -v imageRegistry.host=$REGISTRY_HOST \
    -v imageRegistry.username=$REGISTRY_USERNAME \
    -v imageRegistry.password=$REGISTRY_PASSWORD | \
    kbld -f educates-private/kbld-bundle.yml -f educates-private/.imgpkg/images.yml -f - | \
    kapp deploy -a educates -f - -y
```

The important difference to note at this point is the ``-f
educates-private/.imgpkg/images.yml`` option passed to ``kbld``. This tells
``kbld`` that rather than resolving image references based on what was in the
deployment resources, to remap the image references based on what exists in
the rewritten images lock file, to the local copies of the images stored in
the private image registry.

There are a couple of other differences with the command as well, which we
will cover next.

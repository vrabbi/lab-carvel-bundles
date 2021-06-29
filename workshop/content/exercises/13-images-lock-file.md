Rewriting image references to use a hash reference value is important as far
as ensuring you can correctly reproduce a deployment using the exact same
images. Being able to identify the exact image versions is also helpful in
our goal of being able to deploy Educates in a disconnected environment.

Specifically, we need to be able to identify all images used by a deployment
so we can copy them to an internal image registry for the disconnected
environment.

In the previous step ``kbld`` was used to rewrite the image references on the
fly. What we need though is to be able to capture details of what rewrites are
required into a file for later use.

Once again ``kbld`` can help out with this by running the command:

```terminal:execute
command: (cd packages/educates/bundle; kbld -f config --imgpkg-lock-output .imgpkg/images.yml)
```

which will output what is called an images lock file. In this case saved as
the file ``packages/educates/bundle/.imgpkg/images.yml``.

```editor:open-file
file: ~/exercises/packages/educates/bundle/.imgpkg/images.yml
```

This generated file contains a mapping from the original image reference
to one which includes the hash reference value instead of the original image
tag.

Note that we haven't captured the standard output from ``kbld`` and that
output isn't actually particularly useful. This is because we ran ``kbld`` on
the unprocessed files which would normally be used as input to ``ytt``. Some
of the output therefore doesn't actually consists of Kubernetes resources but
arbitrary YAML files.

The reason we used the unprocessed files with ``kbld`` was because we want to
pickup all possible uses of images in the deployment resources. By using the
processed output this may not be the case as conditional flags may mean that
in any one configuration set by the data values not all images may be used in
the final deployment resources.

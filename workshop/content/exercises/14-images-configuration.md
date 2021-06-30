When resolving the images and generating the image lock file it may be
necessary to customize what ``kbld`` is doing. There are two main situations
in which you may need to do this.

The first is that you may need to override what versions of images are used
when the upstream resources are to be applied. In the case of the Educates
operator this is necessary as the upstream resources use the ``develop`` tag
on the operator container image. This wasn't a specific version as usually the
Kustomize configuration it provides would override that with the actual
version of the image to use.

For this reason when ``kbld`` was run previously, the ``-f kbld-upstream.yml``
option was supplied, passing a configuration for ``kbld``.

```editor:open-file
file: ~/exercises/packages/educates/bundle/kbld-upstream.yml
```

In this file an overrides section is supplied which remaps the image version
referenced in the resource, with the actual version we want to be used.

```editor:select-matching-text
file: ~/exercises/packages/educates/bundle/kbld-upstream.yml
text: "overrides:"
after: 2
```

The second situation where you may need to use configuration to customize what
``kbld`` does is when non standard fields within the resources actually have
values that refer to images. That is, by default it will only look for fields
with name ``image`` as indicating an image reference. We don't use this
ability here, but we will need it later on.

Note that although we use the overrides section to change what version of the
image is used, the image lock file still shows the original version of the
image. Even so, the resolved version of the hash reference value corresponds
to the version we did want. Unfortunately the images lock file doesn't
indicate that an override was in play, which would be useful to aid
understanding when debugging issues since the hash value reference doesn't
correspond to the version it is replacing.

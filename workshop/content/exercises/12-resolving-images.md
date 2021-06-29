We have Educates deployed, but it is still using container images which are
being pulled down from public image registries.

You can see a list of the images which the deployment is using by running:

```terminal:execute
command: kapp inspect -a educates --raw --tty=false | kbld inspect -f -
```

This command is using the Carvel tool called ``kbld`` to inspect the resources
for the deployed application.

One thing you may notice is that image references are using the original
version tags for the images, and not a hash reference value. There is even
one image listed which is using the ``latest`` tag.

The problem with the tags being used is that they don't uniquely identify
a specific image, because a new different image could be pushed to the image
registry with the same tag.

Best practice is to resolve image references and rewrite them to include the
hash reference value instead of the tag. Manually calculating the hash
reference value for images is tedious, but this is where the ``kbld`` tool can
help out.

Using ``kbld``, we can run:

```terminal:execute
command: (cd packages/educates/bundle; kbld -f config --imgpkg-lock-output .imgpkg/images.yml)
```

which will output the file ``packages/educates/bundle/.imgpkg/values.yml``.

```editor:open-file
file: ~/exercises/packages/educates/bundle/.imgpkg/values.yml
```

This generated file contains a mapping from the original image reference
to one which includes the hash reference value instead of the original image
tag. It calculates the hash reference value by querying the image registries
where the image are hosted, obtaining the image manifest and extracting the
hash reference value for the image.

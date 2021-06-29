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
also help out.

Run ``ytt`` again to process the deployment resources, with our data values,
but this time pipe the output into ``kbld``.

```terminal:execute
command: ytt -f packages/educates/bundle/config -f educates-values.yaml | kbld -f - > educates-resources.yaml
```

This time when we use ``kapp`` to update the deployment:

```terminal:execute
command: kapp deploy -a educates -f educates-resources.yaml --diff-changes
```

You will see that ``kbld`` has rewritten the image references for us to use
hash reference value instead of the original tag.

Enter "y" to confirm that the changes should be applied to the cluster.

```terminal:input
text: y
```

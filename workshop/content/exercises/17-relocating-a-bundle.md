At this point it would appear that bundles provide little more than a fancy
way of hosting a tarball of the configuration, but as an OCI artifact on an
image registry.

On the contrary, this is the foundation for the magic which enables us to be
able to install an application in a disconnected environment.

The next step in this process is to now copy the bundle to another image
registry.

For this, imagine that you are on a bastion or proxy host of a disconnected
network, where the host can see the public internet and the internal network,
but the networks on each side can not see each other.

From this location what you can then do is run:

```terminal:execute
command: imgpkg copy -b {{registry_host}}/educates:21.05.10.1 --to-repo {{registry_host}}/educates-private
```

In this case we are cheating a bit since we don't actually have two networks
and have only one image registry, so we are going to copy the bundle from the
image registry to the same image registry but under a different name,
emulating what would occur if they were distinct.

What will occur when this command is run is that not only is the configuration
bundle copied, but any container images required for the application, as were
previously written to the images lock file, will be copied from their original
image registries, into the target image registry. In this case this is the
same registry, but for a disconnected environment that would be the image
registry within the internal network.

Here we assumed that we could run the command on a host which could see both
public and private networks, but if that wasn't possible, what can instead be
done is use ``imgpkg copy`` to create a tarball on the local file system. This
tarball like the copy currently being run, would contain both the
configuration bundle and copies of the container images required. Having that
tarball it can then be copied by whatever means necessary to get it onto the
private network. The ``imgpkg`` command can then be used to copy the tarball
from the local file system up to the internal image registry just as if it had
been copied across directly.

As copying all the container images may take a little while, wait for the
copy to finish before continuing.
